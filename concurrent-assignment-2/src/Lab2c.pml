/* DTU Course 02158 Concurrent Programming
 *   Lab 2
 *   spin5.pml
 *     Skeleton PROMELA model of mutual exlusion by coordinator
 */

#define N 4

bool enter[N];  /* Request to enter flags */
bool ok[N];     /* Entry granted flags    */

int incrit = 0; /* For easy statement of mutual exlusion */

/*
 * Below it is utilised that the first N process instances will get
 * pids from 0 to (N-1).  Therefore, the pid can be directly used as
 * an index in the flag arrays.
 */


active [N] proctype P()
{
    do  :: skip;

entry:
        enter[_pid] = true;
        /*await*/ ok[_pid] ->

crit:    /* Critical section */
        incrit++;
        assert(incrit == 1);
        incrit--;

exit:
        ok[_pid] = false;
        
        /* Non-critical setion (may or may not terminate) */
        do :: true -> break od

    od;
}

active proctype Coordinator()
{
    int i;
    do
    ::
        i = i % N;
        if ::     enter[i] -> atomic{ok[i] = true; enter[i] = false;}
                    ok[i] == false ->
        fi;
        i = i+1
    od
}

ltl fair1 { [] ( (P[0]@entry) -> <>  (P[0]@crit) ) }