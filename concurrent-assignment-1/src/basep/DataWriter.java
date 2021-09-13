package basep;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

public class DataWriter {
    public static void WriteDataToFile(String runName,List<Double> results) throws IOException {
        FileWriter f = new FileWriter(runName+".csv");
        f.write("x,y");
        int i = 0;
        for (Double result : results) {
            f.append("\n"+i+","+result);
            i++;
        }
        f.flush();

        FileWriter plot = new FileWriter(runName+".gnuplot");
        plot.write(
                "set datafile separator ','\n" +
                "set ylabel \"Seconds\" # label for the Y axis\n"+
                "set xlabel 'Run' # label for the X axis\n"+
                "plot \""+runName+".csv\" using 1:2 with lines, '' using 1:3 with lines");
        plot.flush();

    }
}
