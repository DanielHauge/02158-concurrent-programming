//Implementation of Alley class with inner alley (skeleton)
//CP Lab 3
//Course 02158 Concurrent Programming, DTU, Fall 2021

//Hans Henrik Lovengreen     Oct 25, 2021

public class DoubleAlley extends Alley {
   

    private int up;
    private int down;
    private int innerUp;
    DoubleAlley() {
        up = 0;
        down = 0;
        innerUp = 0;
    }

    

    @Override
    /* Block until car no. may enter alley */
    public synchronized void enter(int no) throws InterruptedException {
        if (no < 3){
            while (innerUp > 0){
                wait();
            }
            down++;
        }
        else if (no < 5) {
            while (up > 0){
                wait();
            }
            down++;
        } 
        else {
            while (down > 0){
                wait();
            }
            up++;
            innerUp++;
        }

    }

    @Override
    /* Register that car no. has left the alley */
    public synchronized void leave(int no) {
        if (no < 5) {
            down--;
        } else {
            up--;
        }
        notifyAll();
    }
    
    @Override
    /* Register that car no. has left the inner alley */
    public synchronized void leaveInner(int no) {
        if (no > 4) {
            innerUp--;
            notifyAll();
        }
    }

}
