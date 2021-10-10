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

// Car driving through the alley top to bottom.
active [NDown] proctype PD()
{
	int downTemp;
	do
    ::    /* First statement is a dummy to allow a label at start */
        skip;

entry:
        atomic{ (up == 0) -> down++; }

crit:   /* Critical section : Driving through the alley. */
        incritDown++;
        assert(incritDown <= NDown);
		assert(incritUp == 0);
        incritDown--;

exit:
        atomic{ down--; }
    od;
}

// Car driving through the alley bottom to top.
active [NUp] proctype PU()
{
	int upTemp;
    do  :: skip;

entry:
		atomic{ (down == 0) -> up++; }

crit:   /* Critical section : Driving through the alley. */
		incritUp++;
		assert(incritUp <= NUp);
		assert(incritDown == 0);
		incritUp--;

exit:
		atomic{ up--; }
    od;
}