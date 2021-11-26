/*
   DTU 02158 Concurrent Programming
   Mandatory Assignment 4
   Fall 2021
*/

package main

import "fmt"

const N = 5

func odds(out chan<- int, last <-chan int) {
	// Fill in
	i := 3
	for {
		select {
		case <-last: // Last sieve let an element through, thus last prime is found.
			fmt.Println(2)
			close(out)
			return
		case out <- i: // A goroutines is ready to pick up next odd number
			i += 2 // Odd + 2 = Odd
		}
	}
}

func sieve(in <-chan int, out chan<- int) {
	// Fill in
	myprime := <-in
	for {
		nextCandidate, ok := <-in
		if !ok {
			break
		}
		if nextCandidate%myprime != 0 {
			out <- nextCandidate
		}
	}
	fmt.Println(myprime)
	close(out)
}

func main() {
	// Declare channels
	channels := make([]chan int, N)

	// Initialize channels
	for i, _ := range channels {
		channels[i] = make(chan int)
	}

	fmt.Println("The first", N, "prime numbers are:")

	// Connect/start goroutines
	go odds(channels[0], channels[N-1])
	for i := 0; i < N-1; i++ {
		go sieve(channels[i], channels[i+1])
	}

	// Await termination
	for {
		_, ok := <-channels[N-1]
		if !ok {
			break
		}
	}
	fmt.Println("Done!")
}