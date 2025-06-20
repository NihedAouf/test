import com.mathworks.engine.MatlabEngine;
import utils.MatlabConnector;
import logic.SimLogic;

public class Main {
    public static void main(String[] args) {
        try {
            // Start MATLAB engine using MatlabConnector
            MatlabEngine eng = MatlabConnector.getEngine();

            // Run all simulations
            SimLogic.runSimulations(eng);

            // Stop MATLAB engine
            MatlabConnector.stopEngine();
            System.out.println("✅ Full simulation sequence completed.");
        } catch (Exception e) {
            e.printStackTrace();
            System.exit(1);
        }
    }
}
