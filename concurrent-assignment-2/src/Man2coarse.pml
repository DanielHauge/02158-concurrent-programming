/* DTU Course 02158 Concurrent Programming
 *   Lab 2
 *   spin5.pml
 *     Skeleton PROMELA model of mutual exlusion by coordinator
 */

#define NUp 3
#define NDown 4

int incritUp = 0;
int incritDown = 0;

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
        atomic{ (up == 0) -> down++; }

crit:    /* Critical section */
        incritDown++;
        assert(incritDown <= NDown);
		assert(incritUp == 0);
        incritDown--;

exit:
        atomic{ down--; }
    od;
}

active [NUp] proctype PU()
{
	int upTemp;
    do
    ::    /* First statement is a dummy to allow a label at start */
        skip;

entry:
		atomic{ (down == 0) -> up++; }

crit:    /* Critical section */
		incritUp++;
		assert(incritUp <= NUp);
		assert(incritDown == 0);
		incritUp--;

exit:
		atomic{ up--; }
    od;
}


/* ltl fair1 { [] ( (P[0]@entry) -> <>  (P[0]@crit) ) } */