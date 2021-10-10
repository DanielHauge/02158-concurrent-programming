#define NUp 3
#define NDown 4

#define Inc(V) { temp = V; temp = temp + 1; V = temp; }
#define Decr(V) { temp = V; temp = temp - 1; V = temp; }

int incritUp = 0;
int incritDown = 0;

int up = 0;
int down = 0;

int eSem = 1;
int upSem = 0;
int downSem = 0;

int upWaiting = 0;
int downWaiting = 0;



inline V(sem) {sem++;}
inline P(sem) {atomic{ sem>0 ; sem--}}




active [NDown] proctype PD()
{
    int temp;
	do
    ::    /* First statement is a dummy to allow a label at start */
        skip;

entry:  /* atomic{ (up == 0) -> down++; } */
        P(eSem);
        if :: (up > 0) -> 
                Inc(downWaiting);
                V(eSem);
                P(downSem)
        fi; 
        Inc(down);
        skip;
        if  :: downWaiting > 0 -> Decr(downWaiting); V(downSem)
            :: V(eSem)
        fi;
        
crit:    /* Critical section */
        incritDown++;
        assert(incritDown <= NDown);
		assert(incritUp == 0);
        incritDown--;

exit:
        P(eSem);
        Decr(down);
        if  :: down == 0 && upWaiting > 0 -> Decr(upWaiting); V(upSem) 
            :: V(eSem)
        fi
    od;
}

active [NUp] proctype PU()
{
    int temp;
    do
    ::    /* First statement is a dummy to allow a label at start */
        skip;

entry:  // atomic{ (down == 0) -> up++; }
        P(eSem);
        if :: (down > 0) -> 
                Inc(upWaiting);
                V(eSem);
                P(upSem)
            :: skip
        fi; 
        Inc(up);
        if  :: (upWaiting > 0) -> Decr(upWaiting); V(upSem)
            :: V(eSem)
        fi;

crit:    /* Critical section: In alley */
		incritUp++;
		assert(incritUp <= NUp);
        skip;
		assert(incritDown == 0);
		incritUp--;

exit:   // atomic{ up--; }
		P(eSem);
        Decr(up);
        if  :: up == 0 && downWaiting > 0 -> Decr(downWaiting); V(downSem);
            :: V(eSem)
        fi
    od;
}


/* ltl fair1 { [] ( (P[0]@entry) -> <>  (P[0]@crit) ) } */