#define rand	pan_rand
#if defined(HAS_CODE) && defined(VERBOSE)
	cpu_printf("Pr: %d Tr: %d\n", II, t->forw);
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* PROC PU */
	case 3: /* STATE 2 - Man2multi.pml:18 - [((upSem>0))] (11:0:1 - 1) */
		IfNotBlocked
		reached[1][2] = 1;
		if (!((now.upSem>0)))
			continue;
		/* merge: upSem = (upSem-1)(0, 3, 11) */
		reached[1][3] = 1;
		(trpt+1)->bup.oval = now.upSem;
		now.upSem = (now.upSem-1);
#ifdef VAR_RANGES
		logval("upSem", now.upSem);
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 4: /* STATE 6 - Man2multi.pml:65 - [((up==0))] (0:0:0 - 1) */
		IfNotBlocked
		reached[1][6] = 1;
		if (!((now.up==0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 5: /* STATE 7 - Man2multi.pml:18 - [((downSem>0))] (13:0:1 - 1) */
		IfNotBlocked
		reached[1][7] = 1;
		if (!((now.downSem>0)))
			continue;
		/* merge: downSem = (downSem-1)(0, 8, 13) */
		reached[1][8] = 1;
		(trpt+1)->bup.oval = now.downSem;
		now.downSem = (now.downSem-1);
#ifdef VAR_RANGES
		logval("downSem", now.downSem);
#endif
		;
		/* merge: .(goto)(0, 12, 13) */
		reached[1][12] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 6: /* STATE 13 - Man2multi.pml:66 - [upTemp = up] (0:0:1 - 2) */
		IfNotBlocked
		reached[1][13] = 1;
		(trpt+1)->bup.oval = ((P1 *)this)->_2_upTemp;
		((P1 *)this)->_2_upTemp = now.up;
#ifdef VAR_RANGES
		logval("PU:upTemp", ((P1 *)this)->_2_upTemp);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 7: /* STATE 14 - Man2multi.pml:67 - [upTemp = (upTemp+1)] (0:0:1 - 1) */
		IfNotBlocked
		reached[1][14] = 1;
		(trpt+1)->bup.oval = ((P1 *)this)->_2_upTemp;
		((P1 *)this)->_2_upTemp = (((P1 *)this)->_2_upTemp+1);
#ifdef VAR_RANGES
		logval("PU:upTemp", ((P1 *)this)->_2_upTemp);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 8: /* STATE 15 - Man2multi.pml:68 - [up = upTemp] (0:0:1 - 1) */
		IfNotBlocked
		reached[1][15] = 1;
		(trpt+1)->bup.oval = now.up;
		now.up = ((P1 *)this)->_2_upTemp;
#ifdef VAR_RANGES
		logval("up", now.up);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 9: /* STATE 16 - Man2multi.pml:17 - [upSem = (upSem+1)] (0:0:1 - 1) */
		IfNotBlocked
		reached[1][16] = 1;
		(trpt+1)->bup.oval = now.upSem;
		now.upSem = (now.upSem+1);
#ifdef VAR_RANGES
		logval("upSem", now.upSem);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 10: /* STATE 19 - Man2multi.pml:73 - [incritUp = (incritUp+1)] (0:0:1 - 1) */
		IfNotBlocked
		reached[1][19] = 1;
		(trpt+1)->bup.oval = now.incritUp;
		now.incritUp = (now.incritUp+1);
#ifdef VAR_RANGES
		logval("incritUp", now.incritUp);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 11: /* STATE 20 - Man2multi.pml:74 - [assert((incritUp<=3))] (0:0:0 - 1) */
		IfNotBlocked
		reached[1][20] = 1;
		spin_assert((now.incritUp<=3), "(incritUp<=3)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 12: /* STATE 21 - Man2multi.pml:75 - [assert((incritDown==0))] (0:0:0 - 1) */
		IfNotBlocked
		reached[1][21] = 1;
		spin_assert((now.incritDown==0), "(incritDown==0)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 13: /* STATE 22 - Man2multi.pml:76 - [incritUp = (incritUp-1)] (0:0:1 - 1) */
		IfNotBlocked
		reached[1][22] = 1;
		(trpt+1)->bup.oval = now.incritUp;
		now.incritUp = (now.incritUp-1);
#ifdef VAR_RANGES
		logval("incritUp", now.incritUp);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 14: /* STATE 23 - Man2multi.pml:79 - [upTemp = up] (0:0:1 - 1) */
		IfNotBlocked
		reached[1][23] = 1;
		(trpt+1)->bup.oval = ((P1 *)this)->_2_upTemp;
		((P1 *)this)->_2_upTemp = now.up;
#ifdef VAR_RANGES
		logval("PU:upTemp", ((P1 *)this)->_2_upTemp);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 15: /* STATE 24 - Man2multi.pml:80 - [upTemp = (upTemp-1)] (0:0:1 - 1) */
		IfNotBlocked
		reached[1][24] = 1;
		(trpt+1)->bup.oval = ((P1 *)this)->_2_upTemp;
		((P1 *)this)->_2_upTemp = (((P1 *)this)->_2_upTemp-1);
#ifdef VAR_RANGES
		logval("PU:upTemp", ((P1 *)this)->_2_upTemp);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 16: /* STATE 25 - Man2multi.pml:81 - [up = upTemp] (0:0:1 - 1) */
		IfNotBlocked
		reached[1][25] = 1;
		(trpt+1)->bup.oval = now.up;
		now.up = ((P1 *)this)->_2_upTemp;
#ifdef VAR_RANGES
		logval("up", now.up);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 17: /* STATE 26 - Man2multi.pml:82 - [((up==0))] (0:0:0 - 1) */
		IfNotBlocked
		reached[1][26] = 1;
		if (!((now.up==0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 18: /* STATE 27 - Man2multi.pml:17 - [downSem = (downSem+1)] (0:0:1 - 1) */
		IfNotBlocked
		reached[1][27] = 1;
		(trpt+1)->bup.oval = now.downSem;
		now.downSem = (now.downSem+1);
#ifdef VAR_RANGES
		logval("downSem", now.downSem);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 19: /* STATE 35 - Man2multi.pml:85 - [-end-] (0:0:0 - 1) */
		IfNotBlocked
		reached[1][35] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC PD */
	case 20: /* STATE 2 - Man2multi.pml:18 - [((downSem>0))] (11:0:1 - 1) */
		IfNotBlocked
		reached[0][2] = 1;
		if (!((now.downSem>0)))
			continue;
		/* merge: downSem = (downSem-1)(0, 3, 11) */
		reached[0][3] = 1;
		(trpt+1)->bup.oval = now.downSem;
		now.downSem = (now.downSem-1);
#ifdef VAR_RANGES
		logval("downSem", now.downSem);
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 21: /* STATE 6 - Man2multi.pml:34 - [((down==0))] (0:0:0 - 1) */
		IfNotBlocked
		reached[0][6] = 1;
		if (!((now.down==0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 22: /* STATE 7 - Man2multi.pml:18 - [((upSem>0))] (13:0:1 - 1) */
		IfNotBlocked
		reached[0][7] = 1;
		if (!((now.upSem>0)))
			continue;
		/* merge: upSem = (upSem-1)(0, 8, 13) */
		reached[0][8] = 1;
		(trpt+1)->bup.oval = now.upSem;
		now.upSem = (now.upSem-1);
#ifdef VAR_RANGES
		logval("upSem", now.upSem);
#endif
		;
		/* merge: .(goto)(0, 12, 13) */
		reached[0][12] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 23: /* STATE 13 - Man2multi.pml:35 - [downTemp = down] (0:0:1 - 2) */
		IfNotBlocked
		reached[0][13] = 1;
		(trpt+1)->bup.oval = ((P0 *)this)->_1_downTemp;
		((P0 *)this)->_1_downTemp = now.down;
#ifdef VAR_RANGES
		logval("PD:downTemp", ((P0 *)this)->_1_downTemp);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 24: /* STATE 14 - Man2multi.pml:36 - [downTemp = (downTemp+1)] (0:0:1 - 1) */
		IfNotBlocked
		reached[0][14] = 1;
		(trpt+1)->bup.oval = ((P0 *)this)->_1_downTemp;
		((P0 *)this)->_1_downTemp = (((P0 *)this)->_1_downTemp+1);
#ifdef VAR_RANGES
		logval("PD:downTemp", ((P0 *)this)->_1_downTemp);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 25: /* STATE 15 - Man2multi.pml:37 - [down = downTemp] (0:0:1 - 1) */
		IfNotBlocked
		reached[0][15] = 1;
		(trpt+1)->bup.oval = now.down;
		now.down = ((P0 *)this)->_1_downTemp;
#ifdef VAR_RANGES
		logval("down", now.down);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 26: /* STATE 16 - Man2multi.pml:17 - [downSem = (downSem+1)] (0:0:1 - 1) */
		IfNotBlocked
		reached[0][16] = 1;
		(trpt+1)->bup.oval = now.downSem;
		now.downSem = (now.downSem+1);
#ifdef VAR_RANGES
		logval("downSem", now.downSem);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 27: /* STATE 19 - Man2multi.pml:42 - [incritDown = (incritDown+1)] (0:0:1 - 1) */
		IfNotBlocked
		reached[0][19] = 1;
		(trpt+1)->bup.oval = now.incritDown;
		now.incritDown = (now.incritDown+1);
#ifdef VAR_RANGES
		logval("incritDown", now.incritDown);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 28: /* STATE 20 - Man2multi.pml:43 - [assert((incritDown<=4))] (0:0:0 - 1) */
		IfNotBlocked
		reached[0][20] = 1;
		spin_assert((now.incritDown<=4), "(incritDown<=4)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 29: /* STATE 21 - Man2multi.pml:44 - [assert((incritUp==0))] (0:0:0 - 1) */
		IfNotBlocked
		reached[0][21] = 1;
		spin_assert((now.incritUp==0), "(incritUp==0)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 30: /* STATE 22 - Man2multi.pml:45 - [incritDown = (incritDown-1)] (0:0:1 - 1) */
		IfNotBlocked
		reached[0][22] = 1;
		(trpt+1)->bup.oval = now.incritDown;
		now.incritDown = (now.incritDown-1);
#ifdef VAR_RANGES
		logval("incritDown", now.incritDown);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 31: /* STATE 23 - Man2multi.pml:48 - [downTemp = down] (0:0:1 - 1) */
		IfNotBlocked
		reached[0][23] = 1;
		(trpt+1)->bup.oval = ((P0 *)this)->_1_downTemp;
		((P0 *)this)->_1_downTemp = now.down;
#ifdef VAR_RANGES
		logval("PD:downTemp", ((P0 *)this)->_1_downTemp);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 32: /* STATE 24 - Man2multi.pml:49 - [downTemp = (downTemp-1)] (0:0:1 - 1) */
		IfNotBlocked
		reached[0][24] = 1;
		(trpt+1)->bup.oval = ((P0 *)this)->_1_downTemp;
		((P0 *)this)->_1_downTemp = (((P0 *)this)->_1_downTemp-1);
#ifdef VAR_RANGES
		logval("PD:downTemp", ((P0 *)this)->_1_downTemp);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 33: /* STATE 25 - Man2multi.pml:50 - [down = downTemp] (0:0:1 - 1) */
		IfNotBlocked
		reached[0][25] = 1;
		(trpt+1)->bup.oval = now.down;
		now.down = ((P0 *)this)->_1_downTemp;
#ifdef VAR_RANGES
		logval("down", now.down);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 34: /* STATE 26 - Man2multi.pml:51 - [((down==0))] (0:0:0 - 1) */
		IfNotBlocked
		reached[0][26] = 1;
		if (!((now.down==0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 35: /* STATE 27 - Man2multi.pml:17 - [upSem = (upSem+1)] (0:0:1 - 1) */
		IfNotBlocked
		reached[0][27] = 1;
		(trpt+1)->bup.oval = now.upSem;
		now.upSem = (now.upSem+1);
#ifdef VAR_RANGES
		logval("upSem", now.upSem);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 36: /* STATE 35 - Man2multi.pml:54 - [-end-] (0:0:0 - 1) */
		IfNotBlocked
		reached[0][35] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}

