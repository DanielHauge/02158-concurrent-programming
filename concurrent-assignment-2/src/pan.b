	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC PU */

	case 3: /* STATE 3 */
		;
		now.upSem = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 5: /* STATE 8 */
		;
		now.downSem = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 7: /* STATE 15 */
		;
		((P1 *)this)->_2_upTemp = trpt->bup.oval;
		;
		goto R999;

	case 8: /* STATE 16 */
		;
		now.up = trpt->bup.oval;
		;
		goto R999;

	case 9: /* STATE 17 */
		;
		now.upSem = trpt->bup.oval;
		;
		goto R999;

	case 10: /* STATE 20 */
		;
		now.incritUp = trpt->bup.oval;
		;
		goto R999;
;
		;
		;
		;
		
	case 13: /* STATE 23 */
		;
		now.incritUp = trpt->bup.oval;
		;
		goto R999;

	case 14: /* STATE 24 */
		;
		((P1 *)this)->_2_upTemp = trpt->bup.oval;
		;
		goto R999;

	case 15: /* STATE 25 */
		;
		now.up = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 17: /* STATE 27 */
		;
		now.downSem = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 19: /* STATE 37 */
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC PD */

	case 20: /* STATE 3 */
		;
		now.downSem = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 22: /* STATE 8 */
		;
		now.upSem = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 24: /* STATE 15 */
		;
		((P0 *)this)->_1_downTemp = trpt->bup.oval;
		;
		goto R999;

	case 25: /* STATE 16 */
		;
		now.down = trpt->bup.oval;
		;
		goto R999;

	case 26: /* STATE 17 */
		;
		now.downSem = trpt->bup.oval;
		;
		goto R999;

	case 27: /* STATE 20 */
		;
		now.incritDown = trpt->bup.oval;
		;
		goto R999;
;
		;
		;
		;
		
	case 30: /* STATE 23 */
		;
		now.incritDown = trpt->bup.oval;
		;
		goto R999;

	case 31: /* STATE 24 */
		;
		((P0 *)this)->_1_downTemp = trpt->bup.oval;
		;
		goto R999;

	case 32: /* STATE 25 */
		;
		now.down = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 34: /* STATE 27 */
		;
		now.upSem = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 36: /* STATE 37 */
		;
		p_restor(II);
		;
		;
		goto R999;
	}

