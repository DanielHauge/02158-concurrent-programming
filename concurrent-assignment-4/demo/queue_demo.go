/*
   DTU 02158 Concurrent Programming
   Mandatory Assignment 4
   Fall 2021
*/

package main

import (
	"fmt"

	queue "queue"
)

func main() {

	q := queue.NewBoundedQueue(5, func(item interface{}) { fmt.Println("Dropped: ", item) })

	q.StartConsumers(0, func(item interface{}) {
		fmt.Println(item)
	})

	q.Produce("A")
	q.Produce("B")
	q.Produce("C")
	q.Produce("D")
	q.Produce("E")
	q.Produce("F")

	q.Stop()

}
