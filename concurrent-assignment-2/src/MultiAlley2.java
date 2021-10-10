//Attempted implementation of Alley class with multiple cars
//Mandatory assignment 2
//Course 02158 Concurrent Programming, DTU, Fall 2021

//Hans Henrik Lovengreen     Sep 29, 2021

public class MultiAlley2 extends Alley {

    int up, down;
    Semaphore upSem, downSem;
    
    protected MultiAlley2() {
        up = 0;   down = 0;
        upSem   = new Semaphore(1);
        downSem = new Semaphore(1);
    }

    /* Block until car no. may enter alley */
    public void enter(int no) throws InterruptedException {
        if (no < 5) {
            downSem.P();
            Thread.sleep(100);
            if (down == 0) {
                Thread.sleep(800);
                upSem.P();
            }
            down++;
            downSem.V();
        } else {
            Thread.sleep(100);
            upSem.P();
            if (up == 0) {
                downSem.P();
            }   
            Thread.sleep(300);
            up++;
            Thread.sleep(400);
            upSem.V();
        }

     }

    /* Register that car no. has left the alley */
    public void leave(int no) {
        if (no < 5) {
            down--;
            if (down == 0) upSem.V();    // enable up-going cars again
        } else {
            up--; 
            if (up == 0) downSem.V();    // enable down-going cars again
        }
    }

}
