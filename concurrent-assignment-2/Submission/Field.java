//Prototype implementation of Field class
//Mandatory assignment 2
//Course 02158 Concurrent Programming, DTU, Fall 2021

//Hans Henrik Lovengreen     Sep 29, 2021

public class Field {

    public static final int MAX_ROWS = 11;
    public static final int MAX_COLUMNS = 12;

    private Semaphore[][] Locks;
    public Field() {
        Locks = new Semaphore[MAX_ROWS][MAX_COLUMNS]; // TODO: Constanter for max og min pos
        for (int i = 0; i < MAX_ROWS; i++) {
            for (int j = 0; j < MAX_COLUMNS; j++) {
                Locks[i][j] = new Semaphore(1);
            }
        }
    }

    /* Block until car no. may safely enter tile at pos */
    public void enter(int no, Pos pos) throws InterruptedException {
        Locks[pos.col][pos.row].P();
    }

    /* Release tile at position pos */
    public void leave(Pos pos) {
        Locks[pos.col][pos.row].V();
    }

}
