package main

import ( "fmt";  "time"; "math/rand" )

type Votes struct { a, b int }

func station(out chan<- Votes) {
    for i := 0; i < 10; i++ { 
        time.Sleep(time.Duration(rand.Intn(2000)) * time.Millisecond)
        aVotes := rand.Intn(100) 
        out<- Votes{aVotes, 100 - aVotes}
    }
    close(out)
}

func (start Votes) addVotes(other Votes) Votes {
	return Votes{start.a + other.a, start.b + other.b}
}

func collector(in1, in2 <-chan Votes, out chan<-  Votes) {
	for i := 0; i < 10; i++ {
		votes_station_1 := <- in1
		votes_station_2 := <- in2
		out <- votes_station_1.addVotes(votes_station_2)
	}
	close(out)
}

func setup_collectors(i int, out chan <- Votes){
	if(i == 0) {
		fmt.Println("setting up station")
		go station(out)
		return
	}
	in_votes_1 := make(chan Votes)
	in_votes_2 := make(chan Votes)
	fmt.Println("setting up collector")
	setup_collectors(i-1, in_votes_1)
	setup_collectors(i-1, in_votes_2)
	
	go collector(in_votes_1, in_votes_2, out)
}

func main() {
    rand.Seed(time.Now().UnixNano())
    var votes = make(chan Votes)

    go setup_collectors(3, votes)

    var tally Votes
    for {
        var v, ok = <-votes
        if !ok { break }
        tally.a += v.a;  tally.b += v.b
        fmt.Println("Current tally:", tally)
    }
    
    //tot := tally.a + tally.b

    //if tot != 1000 { fmt.Println("Tally issue:", tot) }

    var winner string
    switch {
        case tally.a > tally.b: winner = "A"
        case tally.a < tally.b: winner = "B"
        default:                winner = "undetermined"
    }
    fmt.Printf("All votes counted. And the winner is: %s\n", winner)
    if winner == "B" { fmt.Println("A: This must be FRAUD!!!") }
}
