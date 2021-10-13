import javax.sound.midi.Soundbank;

//Skeleton implementation of an Alley class  using passing-the-baton
//Mandatory assignment 2
//Course 02158 Concurrent Programming, DTU, Fall 2021

//Hans Henrik Lovengreen     Sep 29, 2021

public class BatonAlley extends Alley {

    private BatonAlley.innerByteClass up;
    private BatonAlley.innerByteClass down;

    private BatonAlley.innerByteClass upWaiting;
    private BatonAlley.innerByteClass downWaiting;

    private Semaphore eSem;
    private Semaphore upSem;
    private Semaphore downSem;

    protected BatonAlley() {

        eSem = new Semaphore(1);
        upSem = new Semaphore(0);
        downSem = new Semaphore(0);

        up = new innerByteClass();
        down = new innerByteClass();
        upWaiting = new innerByteClass();
        downWaiting = new innerByteClass();
    }

    private static void enterAlley(Semaphore e, innerByteClass own, innerByteClass opposite, innerByteClass waiting,
            Semaphore waitSem) throws InterruptedException {
        e.P();
        if (opposite.b > 0) {
            waiting.b++;
            e.V();
            waitSem.P();
        } else if (opposite.b <= 0) {
            // skip
        }
        own.b++;
        if (waiting.b > 0) {
            waiting.b--;
            waitSem.V();
        } else if (waiting.b <= 0) {
            e.V();
        }
    }

    private static void exitAlley(Semaphore e, innerByteClass own, innerByteClass oppositeWait, Semaphore oppositeSem)
            throws InterruptedException {
        e.P();
        own.b--;
        if (own.b == 0 && oppositeWait.b > 0) {
            oppositeWait.b--;
            oppositeSem.V();
        } else if (own.b != 0 || oppositeWait.b <= 0) {
            e.V();
        }
    }

    /* Block until car no. may enter alley */
    public void enter(int no) throws InterruptedException {
        if (no < 5) {
            enterAlley(eSem, down, up, downWaiting, downSem);
        } else {
            enterAlley(eSem, up, down, upWaiting, upSem);
        }
    }

    /* Register that car no. has left the alley */
    public void leave(int no) throws InterruptedException {
        if (no < 5) {
            exitAlley(eSem, down, upWaiting, upSem);
        } else {
            exitAlley(eSem, up, downWaiting, downSem);
        }
    }

    private class innerByteClass {
        public byte b;

        public innerByteClass() {
            this.b = 0;
        }
    }
}
