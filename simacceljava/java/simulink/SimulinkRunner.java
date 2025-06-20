

package simulink;

import com.mathworks.engine.MatlabEngine;

public class SimulinkRunner {
    public static void runSimulinkModel(MatlabEngine eng, String modelName) throws Exception {
        eng.eval("sim('" + modelName + "')");
    }
}
