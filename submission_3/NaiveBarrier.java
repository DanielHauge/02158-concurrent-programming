import java.nio.channels.NotYetBoundException;

//Naive implementation of Barrier class
//Mandatory assignment 3
//Course 02158 Concurrent Programming, DTU, Fall 2021

//Hans Henrik Lovengreen     Oct 28, 2021

class NaiveBarrier extends Barrier {

    int arrived = 0;
    boolean active = false;
    int threshold = 9;

    public NaiveBarrier(CarDisplayI cd) {
        super(cd);
    }

    @Override
    public synchronized void sync(int no) throws InterruptedException {

        if (!active)
            return;

        // Thread.sleep(4000); // added to test barrier deactivaction

        arrived++; // move to synchronized block
   
        if (arrived < threshold) { // added while condition to wait queue
            wait();
        } else {
            arrived = 0;
            notifyAll();
        }

    }

    @Override
    public synchronized void on() {
        active = true;
    }

    @Override
    public synchronized void off() {
        active = false;
        arrived = 0;
        notifyAll();
    }

    @Override
    public synchronized void set(int k) {
        threshold = k;
    }
}