package basep;

import java.io.File;

public class Driver {
    public static void main(String[] argv){
        String basePath = new File("").getAbsolutePath();
        String[] args = new String[]{"-R", "10", "-W","10",basePath+"/xtest.txt","xxxx", "8", "8"};
        Search.main(args);
    }
}
