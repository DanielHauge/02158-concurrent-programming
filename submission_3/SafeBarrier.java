import javax.imageio.plugins.tiff.ExifInteroperabilityTagSet;

//Implementation of a basic Barrier class (skeleton)
//Mandatory assignment 3
//Course 02158 Concurrent Programming, DTU, Fall 2021

//Hans Henrik Lovengreen     Oct 28, 2021

class SafeBarrier extends Barrier {
    boolean active, exit;
    int arrived = 0;

    public SafeBarrier(CarDisplayI cd) {
        super(cd);
    }

    @Override
    public synchronized void sync(int no) throws InterruptedException {

        if (!active)
            return;

        while (active && exit) {
            wait();
        }
        arrived++;

        if (arrived == 9) {
            exit = true;
            notifyAll();
        }

        while (active && !exit) {
            wait();
        }
        arrived--;

        if (arrived == 0) {
            exit = false;
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
        notifyAll();
    }

    @Override
    public synchronized void set(int k) {
        for (int i = 0; i < k; i++) {
            notify();
        }
    }
}
