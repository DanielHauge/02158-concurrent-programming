package basep;

import java.io.File;

public class Driver {
    public static void main(String[] argv){
        String basePath = new File("").getAbsolutePath();
        String[] args = new String[]{"-R", "10", "-W","10", "-d", "shakespear_20tasks-20threads",basePath+"/shakespear.txt","the", "20", "20"};
        Search.main(args);
    }
}
