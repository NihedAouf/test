package utils;

import com.mathworks.engine.MatlabEngine;
import java.util.concurrent.ExecutionException;

public class MatlabConnector {
    private static MatlabEngine engine = null;

    // Start MATLAB engine (singleton)
    public static MatlabEngine getEngine() throws InterruptedException, ExecutionException {
        if (engine == null) {
            engine = MatlabEngine.startMatlab();
        }
        return engine;
    }

    // Stop MATLAB engine
    public static void stopEngine() throws Exception {
        if (engine != null) {
            engine.close();
            engine = null;
        }
    }
}
