#define NUp 3
#define NDown 4


// History varible for model control.
byte incritUp = 0;
byte incritDown = 0;

// Control variable to allow multiple cars driving in the same direction and otherwise block.
byte up = 0;
byte down = 0;

// Semaphore lock and unlock.
inline V(sem) {sem++;}
inline P(sem) {atomic{ sem>0 -> sem--}}

// Semaphores locking the directions.
int upSem = 1;
int downSem = 1;


// Car driving through the alley top to bottom.
active [NDown] proctype PD()
{
	int downTemp;
	do  :: skip;
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
		downTemp = downTemp - 1;
		down = downTemp;
		if :: down == 0 -> V(upSem) fi;
		skip
    od;
}

// Car driving through the alley bottom to top.
active [NUp] proctype PU()
{
	int upTemp;
    do 	::  skip;

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
		upTemp = upTemp - 1;
		up = upTemp;
		if :: up == 0 -> V(downSem) fi;
		skip
    od;
}

