//Basic implementation of Alley class (skeleton)
//CP Lab 3
//Course 02158 Concurrent Programming, DTU, Fall 2021

//Hans Henrik Lovengreen     Oct 25, 2021

public class BasicAlley extends Alley {
   
    private int up;
    private int down;
    BasicAlley() {
        up = 0;
        down = 0;
    }

    

    @Override
    /* Block until car no. may enter alley */
    public synchronized void enter(int no) throws InterruptedException {
        
        if (no < 5) {
            while (up > 0){
                wait();
            }
            down++;
        } else {
            while (down > 0){
                wait();
            }
            up++;
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
    
 
}
