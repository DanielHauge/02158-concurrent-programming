package basep;

/*
 * Concurrent Programming Lab 1 (Swing version)
 */

import java.awt.*;
import java.util.*;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadPoolExecutor;

import javax.swing.JTextField;

class Task extends Thread {

    JTextField tf; // Textfield to be used by this task

    public Task(JTextField t) {
        tf = t;
    }

    void setMyText(final String s) {
        /*
         * Checks if called by GUI thread (= dispatch thread) or not. Although
         * using invokeLater is always sound, calling setText directly is more
         * efficient when called by the GUI thread.
         */
        if (EventQueue.isDispatchThread()) {
            // On GUI thread -- OK to set text directly
            tf.setText(s);
        } else {
            // not on GUI thread -- put update request on event queue
            EventQueue.invokeLater(() -> {
                tf.setText(s);
            });
        }
    }

    public void run() {
        int cols = tf.getColumns();

        boolean useCPU = false; // Set true to consume CPU-cycles

        int basespeed = 5000; // millisecs to do task
        int variation = (useCPU ? 0 : 60); // Speed variation in percent

        long delay = Math.round(((Math.random() - 0.5) * variation / 50 + 1.0) * basespeed / cols);

        String s = "";

        setMyText(s);
        while (s.length() < cols) {
            if (Thread.interrupted()){
                return;
            }
            if (useCPU) {
                for (int j = 0; j < 1000000 * delay; j++) {
                    if (Thread.interrupted()){
                        return;
                    }
                }
            } else {
                try {
                    Thread.sleep(delay);
                } catch (InterruptedException e) {
                    return;
                }
            }

            s = s + "#";
            setMyText(s);
        }
    }
}

public class TaskControl {

    static final int N = 6; // Number of Textfields

    static int h = 0; // Number of 'hello'-s
    public static void stop(Thread[] ts, Integer i, TaskDisplay d){
        Thread t = ts[i];
        if (t != null){
            t.interrupt();
            d.println("Så stoppede threaden: " + i);
        }
    }

    public static void main(String[] argv) {
        try {

            // Create window with N JTextFields: (d.tf[0], ... , d.tf[N-1])
            TaskDisplay d = new TaskDisplay("Task Control", N);

            d.println("Type command (x to exit):");
            Thread[] ts = new Thread[5];



            // Main command interpretation loop
            W: while (true) {

                char c = d.getKey();

                switch (c) {

                case 'x':
                    for (int i = 0; i < ts.length; i++) {
                        Thread t = ts[i];
                        if (t != null && t.isAlive()){
                            d.println("Hov hov, tråd er i brug. venter lige..");
                            t.join();
                        }
                    }
                    break W;

                case 'h':
                    d.println("Hello " + (h++));
                    break;

                case 't':
                    for (int i = 0; i < ts.length; i++) {
                        Thread t = ts[i];
                        if (t == null || !t.isAlive()){
                            Task task = new Task(d.tf[i]);
                            ts[i] = new Thread(() -> task.run()) ;
                            ts[i].start();

                            d.println("Task "+i+ " is ready. Task started.");
                            continue W;
                        }
                    }
                    d.println("Hov hov, alle tråde er brugt.");


                    break;
                    case '1':
                        stop(ts, 0, d);
                        break;
                    case '2':
                        stop(ts, 1, d);
                        break;
                    case '3':
                        stop(ts, 2, d);
                        break;
                    case '4':
                        stop(ts, 3, d);
                        break;
                    case '5':
                        stop(ts, 4, d);
                        break;


                default:
                    d.println("Don't know '" + c + "'");
                }
            }

            d.println("Program terminates");

            Thread.sleep(500);
            System.exit(0);

        } catch (Exception e) {
            System.out.println("Exception in Task Control: " + e);
            e.printStackTrace();
        }
    }
}
