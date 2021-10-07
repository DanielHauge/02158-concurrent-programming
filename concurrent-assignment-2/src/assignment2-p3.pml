/* DTU Course 02158 Concurrent Programming
 *   Lab 2
 *   spin5.pml
 *     Skeleton PROMELA model of mutual exlusion by coordinator
 */

#define NUp 3
#define NDown 4

int incritUp = 0;
int incritDown = 0;
int upSem = 1;
int downSem = 1;
int up = 0;
int down = 0;

inline V(sem) {sem++;}
inline P(sem) {atomic{ sem>0 ; sem--}}

/*
 * Below it is utilised that the first N process instances will get
 * pids from 0 to (N-1).  Therefore, the pid can be directly used as
 * an index in the flag arrays.
 */
active [NDown] proctype PD()
{
	int downTemp;
	do
    ::    /* First statement is a dummy to allow a label at start */
        skip;

entry:
        P(downSem);
		if :: down == 0 -> P(upSem) fi; 
        downTemp = down;
		downTemp = downTemp + 1;
		down = downTemp;
		V(downSem);
		skip;

crit:    /* Critical section */
        incritDown++;
        assert(incritDown <= NDown);
		assert(incritUp == 0);
        incritDown--;
exit:
        downTemp = down;
		downTemp = downTemp + 1;
		down = downTemp;
		if :: down == 0 -> V(upSem) fi;
		skip
    od;
}

active [NUp] proctype PU()
{
	int upTemp;
    do
    ::    /* First statement is a dummy to allow a label at start */
        skip;

entry:
        P(upSem);
		if :: up == 0 -> P(downSem) fi;
		upTemp = up;
		upTemp = upTemp + 1;	
		up = upTemp;
		V(upSem);
		skip;

crit:    /* Critical section */
        incritUp++;
        assert(incritUp <= NUp);
		assert(incritDown == 0);
        incritUp--;

exit:
        upTemp = up;
		upTemp = upTemp + 1;
		up = upTemp;
		if :: up == 0 -> V(downSem) fi;
		skip
    od;
}


/* ltl fair1 { [] ( (P[0]@entry) -> <>  (P[0]@crit) ) } */