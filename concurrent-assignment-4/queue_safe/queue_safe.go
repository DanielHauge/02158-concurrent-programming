// Copyright (c) 2019 The Jaeger Authors.
// Copyright (c) 2017 Uber Technologies, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package queue_safe

import (
	"sync"
	"sync/atomic"
)

var mutex sync.Mutex

// BoundedQueue implements a producer-consumer exchange similar to a ring buffer queue,
// where the queue is bounded and if it fills up due to slow consumers, the new items written by
// the producer force the earliest items to be dropped. The implementation is actually based on
// channels, with a special Reaper goroutine that wakes up when the queue is full and consumers
// the items from the top of the queue until its size drops back to maxSize
type BoundedQueue struct {
	capacity      int
	size          int32
	onDroppedItem func(item interface{})
	items         chan interface{}
	stopCh        chan struct{}
	stopWG        sync.WaitGroup
	stopped       int32
	mutex         sync.Mutex
}

// NewBoundedQueue constructs the new queue of specified capacity, and with an optional
// callback for dropped items (e.g. useful to emit metrics).
func NewBoundedQueue(capacity int, onDroppedItem func(item interface{})) *BoundedQueue {
	return &BoundedQueue{
		capacity:      capacity,
		onDroppedItem: onDroppedItem,
		items:         make(chan interface{}, capacity),
		stopCh:        make(chan struct{}),
	}
}

// StartConsumers starts a given number of goroutines consuming items from the queue
// and passing them into the consumer callback.
func (q *BoundedQueue) StartConsumers(num int, consumer func(item interface{})) {
	var startWG sync.WaitGroup
	for i := 0; i < num; i++ {
		q.stopWG.Add(1)
		startWG.Add(1)
		go func() {
			startWG.Done()
			defer q.stopWG.Done()
			for {
				select {
				case item := <-q.items:
					q.mutex.Lock()
					atomic.AddInt32(&q.size, -1)
					q.mutex.Unlock()
					consumer(item)
				case <-q.stopCh:
					return
				}
			}
		}()
	}
	startWG.Wait()
}

// Produce is used by the producer to submit new item to the queue. Returns false in case of queue overflow.
func (q *BoundedQueue) Produce(item interface{}) bool {
	if atomic.LoadInt32(&q.stopped) != 0 {
		q.onDroppedItem(item)
		return false
	}
	q.mutex.Lock()
	select {
	case q.items <- item:
		atomic.AddInt32(&q.size, 1)
		q.mutex.Unlock()
		return true
	default:
		if q.onDroppedItem != nil {
			q.onDroppedItem(item)
		}
		q.mutex.Unlock()
		return false
	}

}

// Stop stops all consumers, as well as the length reporter if started,
// and releases the items channel. It blocks until all consumers have stopped.
func (q *BoundedQueue) Stop() {
	atomic.StoreInt32(&q.stopped, 1) // disable producer
	close(q.stopCh)
	q.stopWG.Wait()
	close(q.items)
}

// Size returns the current size of the queue
func (q *BoundedQueue) Size() int {
	return int(atomic.LoadInt32(&q.size))
}

// Capacity returns capacity of the queue
func (q *BoundedQueue) Capacity() int {
	return q.capacity
}
