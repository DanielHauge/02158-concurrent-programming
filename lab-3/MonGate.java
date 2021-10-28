//Monitor implementation of Gate (skeleton)
//CP Lab 3
//Course 02158 Concurrent Programming, DTU, Fall 2021

//Hans Henrik Lovengreen     Oct 25, 2021


public class MonGate extends Gate {

    private boolean isopen = false;


    public synchronized void pass() throws InterruptedException {
        while (!isopen){
            wait();
        }
    }

    public synchronized void open() {
        isopen = true;
        notifyAll();
    }

    public synchronized void close() {
        isopen = false;
    }

}
