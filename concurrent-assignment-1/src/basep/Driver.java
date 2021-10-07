package basep;

import java.awt.*;
import java.io.File;

public class Driver {
    public static void main(String[] argv){

        String word = "Denmark";
        String Repeats = "10";
        String WarmupRounds = "10";
        String TxtFile = "/shakespear.txt";

        /* Ran with cachedthreadpool.
        RunWith("1", "1",word, Repeats, WarmupRounds, TxtFile);
        RunWith("1", "2",word, Repeats, WarmupRounds, TxtFile);
        RunWith("1", "4",word, Repeats, WarmupRounds, TxtFile);
        RunWith("1", "8",word, Repeats, WarmupRounds, TxtFile);
        RunWith("1", "10",word, Repeats, WarmupRounds, TxtFile);
        RunWith( "1", "15",word, Repeats, WarmupRounds, TxtFile);
        RunWith("1", "20",word, Repeats, WarmupRounds, TxtFile);
        */
        /* Ran with fixedthreadpool*/
        RunWith("1", "1",word, Repeats, WarmupRounds, TxtFile);
        RunWith( "1", "8",word, Repeats, WarmupRounds, TxtFile);
        RunWith("2", "8",word, Repeats, WarmupRounds, TxtFile);
        RunWith( "4", "4",word, Repeats, WarmupRounds, TxtFile);
        RunWith( "8", "2",word, Repeats, WarmupRounds, TxtFile);
        RunWith("8", "8",word, Repeats, WarmupRounds, TxtFile);
        RunWith("8", "16",word, Repeats, WarmupRounds, TxtFile);
        RunWith("20", "20",word, Repeats, WarmupRounds, TxtFile);
        /**/

    }

    public static void RunWith(String threads, String tasks,String word, String Repeats, String WarmupRounds, String TxtFile ){
        String basePath = new File("").getAbsolutePath();
        String[] args = new String[]{"-R", Repeats, "-W",WarmupRounds, "-d", "shakespear_"+tasks+"tasks-"+threads+"threads",basePath + TxtFile,word, tasks, threads};
        Search.main(args);
    }
}
