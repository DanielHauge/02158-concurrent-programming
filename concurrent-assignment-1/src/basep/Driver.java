package basep;

import java.io.File;

public class Driver {
    public static void main(String[] argv){
        String basePath = new File("").getAbsolutePath();
        String[] args = new String[]{basePath+"/lorem.txt","ipsum"};
        Search.main(args);
    }
}
