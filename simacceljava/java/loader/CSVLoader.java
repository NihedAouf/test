package loader;

import com.mathworks.engine.MatlabEngine;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException; // Added for getCanonicalPath

public class CSVLoader {
    public static void loadExcel(MatlabEngine eng, String fileName, String variableName) throws Exception {
        // Construct path relative to project root (where JVM is likely started)
        File dataFile = new File("matlab" + File.separator + "data" + File.separator + fileName);
        if (!dataFile.exists() || !dataFile.isFile()) {
            throw new FileNotFoundException("CSVLoader: Data file not found or is not a regular file: " + dataFile.getAbsolutePath());
        }
        System.out.println("CSVLoader: Verified file exists (Java check): " + dataFile.getAbsolutePath());

        // Use canonical path for MATLAB to resolve any relative parts and get a clean absolute path.
        // Replace backslashes with forward slashes for MATLAB compatibility.
        String canonicalPathForMatlab = dataFile.getCanonicalPath().replace("\\", "/");
        System.out.println("CSVLoader: Attempting to readmatrix in MATLAB: " + canonicalPathForMatlab + " into variable " + variableName);
        String cmd = variableName + " = readmatrix('" + canonicalPathForMatlab + "');";
        eng.eval(cmd);
    }

    public static void loadAllExcel(MatlabEngine eng) throws Exception {
        loadExcel(eng, "activeA.csv", "activeA");
        loadExcel(eng, "activeB.csv", "activeB");
        loadExcel(eng, "activeC.csv", "activeC");
        loadExcel(eng, "reactiveA.csv", "reactiveA");
        loadExcel(eng, "reactiveB.csv", "reactiveB");
        loadExcel(eng, "reactiveC.csv", "reactiveC");
    }
}