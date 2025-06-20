package loader;

import com.mathworks.engine.MatlabEngine;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException; // Added for getCanonicalPath

public class MATLoader {
    public static void loadMAT(MatlabEngine eng, String fileName) throws Exception {
        // Construct path relative to project root (where JVM is likely started)
        File dataFile = new File("matlab" + File.separator + "data" + File.separator + fileName);
        if (!dataFile.exists() || !dataFile.isFile()) {
            throw new FileNotFoundException("MATLoader: Data file not found or is not a regular file: " + dataFile.getAbsolutePath());
        }
        System.out.println("MATLoader: Verified file exists (Java check): " + dataFile.getAbsolutePath());

        // Use canonical path for MATLAB to resolve any relative parts and get a clean absolute path.
        // Replace backslashes with forward slashes for MATLAB compatibility.
        String canonicalPathForMatlab = dataFile.getCanonicalPath().replace("\\", "/");
        System.out.println("MATLoader: Attempting to load in MATLAB: " + canonicalPathForMatlab);
        eng.eval("load('" + canonicalPathForMatlab + "');");
    }

    public static void loadAllMAT(MatlabEngine eng) throws Exception {
        loadMAT(eng, "ResistanceDeLigne.mat");
        loadMAT(eng, "CapacitanceDeLigne.mat");
        loadMAT(eng, "InductanceDeLigne.mat");
        loadMAT(eng, "DistanceDeLigne.mat");
        loadMAT(eng, "variable.mat"); // Added based on CollectionAG806_808.m
    }
}