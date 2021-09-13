package basep;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

public class DataWriter {
    public static void WriteDataToFile(String runName,List<Double> results, List<Double> fastResults) throws IOException {
        FileWriter f1 = new FileWriter(runName+"1.csv");
        f1.write("\"Time\",\"Single run\",\"secondYAxisValue\",");
        int i = 0;
        for (Double result : results) {
            f1.append("\n"+(i+1)+","+result);
            i++;
        }
        f1.flush();

        FileWriter f2 = new FileWriter(runName+"2.csv");
        f2.write("\"Time\",\"Multi run\",\"secondYAxisValue\",");
        i = 0;
        for (Double result : fastResults) {
            f2.append("\n"+(i+1)+","+result);
            i++;
        }
        f2.flush();

        FileWriter plot = new FileWriter(runName+".gnuplot");
        plot.write(
                "set datafile separator ','\n" +
                "set ylabel \"Seconds\" # label for the Y axis\n"+
                "set xlabel 'Run' # label for the X axis\n"+
                       "set key autotitle columnhead\n" +
                "plot \""+runName+"1.csv\" using 1:2 with lines, '' using 1:3 with lines\n"+
                "replot \""+runName+"2.csv\" using 1:2 with lines, '' using 1:3 with lines"
        );
        plot.flush();

    }
}
