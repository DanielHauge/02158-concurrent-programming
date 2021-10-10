// Amount of cars
#define NUp 2
#define NDown 3

// Macro's for Non-atomic increment and decrement of variable V. (Java increments/decrements are non-atomic)
#define Inc(V) { temp = V; temp = temp + 1; V = temp; }
#define Decr(V) { temp = V; temp = temp - 1; V = temp; }

// History varible for model control.
byte incritUp = 0;
byte incritDown = 0;

// Control variable to allow multiple cars driving in the same direction and otherwise block.
byte up = 0;
byte down = 0;

// Semaphores.
byte eSem = 1;
byte upSem = 0;
byte downSem = 0;

// Queue count variables (To check if baton can be passed)
byte upWaiting = 0;
byte downWaiting = 0;

// Semaphore lock and unlock.
inline V(sem) {sem++;}
inline P(sem) {atomic{ sem>0 -> sem--}}

// Entry: atomic{ (opposite == 0) -> own++; } : eg. atomic{ (down == 0) -> up++; }
// e: Main semaphore lock
// own: The varible which will be incremented atomically.
// opposite: The variable used in the conditional
// waiting: The amount of cars in queue for the same direction.
// waitSem: Semaphore waiting for a baton from another car.
inline Entry(e, own, opposite, waiting, waitSem) {
    P(e);
    if :: opposite > 0 -> // There are already cars in the alley moving in opposite direciton.
            Inc(waiting);
            V(e);
            P(waitSem)
        :: opposite <= 0 -> skip
    fi; 
    Inc(own);
    if  :: waiting > 0 -> // There are more cars that want to move in the same direction as "me", passing the baton the the car behind.
            Decr(waiting); 
            V(waitSem)
        :: waiting <= 0 -> V(e)
    fi;
}

// Exit: atomic{ up--; } || atomic{ down--; }
// e: Main semaphore lock
// own: The varible which will be decremented atomically
// oppositeWait: The amount of cars in queue for the opposite direction.
// oppositeSem: Semaphore for passing a baton to if there are any in queue and "i'm" the last car leaving the alley.
inline Exit(e, own, oppositeWait, oppositeSem) {
    P(e);
    Decr(own);
    if  :: (own == 0 && oppositeWait > 0) -> // "i'm" the last car leaving the alley, and cars are waiting to enter to drive in the opposite direction, passing the baton.
            Decr(oppositeWait); 
            V(oppositeSem)
        :: (own != 0 || oppositeWait <= 0) -> // "I'm" not last, or there is no opposite in queue.
            V(e)
    fi
}

// Car driving through the alley top to bottom.
proctype Pd()
{
    int temp;
	do  :: skip;

entry:  // atomic{ (up == 0) -> down++; }
        Entry(eSem, down, up, downWaiting, downSem);
        
crit:    /* Critical section : Driving through the alley. */
        incritDown++;
        assert(incritDown <= NDown);
		assert(incritUp == 0);
        incritDown--;

exit:   // atomic{ down--; }
        Exit(eSem, down, upWaiting, upSem);
    od;
}

// Car driving through the alley bottom to top.
proctype Pu()
{
    int temp;
    do  :: skip;

entry:  // atomic{ (down == 0) -> up++; }
        Entry(eSem, up, down, upWaiting, upSem);

crit:    /* Critical section:  Driving through the alley. */
		incritUp++;
		assert(incritUp <= NUp);
		assert(incritDown == 0);
		incritUp--;

exit:   // atomic{ up--; }
		Exit(eSem, up, downWaiting, downSem);
    od;
}


pid up1, up2, down1, down2, down3;

init {
    atomic {
      up1 = run Pu();
      up2 = run Pu();
      down1 = run Pd();
      down2 = run Pd();
      down3 = run Pd();
    }
}


// When up1 process will eventually make progress.  P -> Q = [](P => <> Q)
// ltl fair1 { [] ( (Pu[up1]@entry) -> <>  (Pu[up1]@crit) ) } 

// Process up1 cannot escape progressing forever.  Strong fairness: []<> (at a & B) ~> after a  : [] <> ([] @a -> <> after @a)
// ltl strongFair { [] <> ([] ( (Pu[up1]@entry) -> <>  (Pu[up1]@crit) )) } 

// A process on its own will make progress without delay. 
// ltl obl { [] ( ((Pd[down1]@entry) && [] !(Pu[up1]@entry) ) -> <> (Pd[down1]@crit) )}

// It should allways be the case that: atleast one of the processes will make progress.
// ltl res1 { [] ( Pu[up1]@entry || Pu[up2]@entry || Pd[down1]@entry || Pd[down2]@entry || Pd[down3]@entry) -> <> (Pu[up1]@crit || Pu[up2]@crit || Pd[down1]@crit || Pd[down2]@crit || Pd[down3]@crit) )}
// ltl res2 { [] ( (Pu[up1]@entry || Pu[up2]@entry) -> <> ( Pu[up1]@crit || Pu[up2]@crit ) && ( Pd[down1]@entry || Pd[down2]@entry || Pd[down3]@entry) -> <> ( Pd[down1]@crit || Pd[down2]@crit || Pd[down3]@crit) ) }
