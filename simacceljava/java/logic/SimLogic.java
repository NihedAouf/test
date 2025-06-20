package logic;

import com.mathworks.engine.MatlabEngine;
import loader.CSVLoader;
import loader.MATLoader;
import simulink.SimulinkRunner;
import output.OutputSaver;

public class SimLogic {
    public static void runSimulations(MatlabEngine eng) throws Exception {
        // Step 1: MATLAB working directory
        System.out.println("SimLogic: Changing MATLAB CWD to 'matlab'");
        eng.eval("cd('matlab')");

        // Get the result of 'pwd' using feval.
        // The ClassCastException (String cannot be cast to Object[]) suggests that
        // eng.feval("pwd") might be returning a String directly in your environment,
        // instead of an Object[] containing the String.
        Object rawPwdResult = eng.feval("pwd");
        String matlabCurrentDir = "";
        if (rawPwdResult instanceof String) {
            matlabCurrentDir = (String) rawPwdResult;
        } else if (rawPwdResult instanceof Object[]) {
            Object[] pwdArray = (Object[]) rawPwdResult;
            if (pwdArray.length > 0 && pwdArray[0] instanceof String) {
                matlabCurrentDir = (String) pwdArray[0];
            } else {
                System.err.println("SimLogic: WARNING - feval('pwd') returned an Object[] but it was empty or its first element was not a String.");
            }
        } else if (rawPwdResult != null) {
            System.err.println("SimLogic: WARNING - feval('pwd') returned an unexpected type: " + rawPwdResult.getClass().getName());
        } else {
            System.err.println("SimLogic: WARNING - feval('pwd') returned null.");
        }
        System.out.println("SimLogic: MATLAB CWD is now: " + matlabCurrentDir);

        // Step 2: Load all .xlsx and .mat files
        System.out.println("SimLogic: Loading Excel files...");
        CSVLoader.loadAllExcel(eng);
        System.out.println("SimLogic: Excel files loaded.");
 
        System.out.println("SimLogic: Loading MAT files...");
        MATLoader.loadAllMAT(eng);
        System.out.println("SimLogic: MAT files loaded.");

        // Assign expected MATLAB variable names after loading MAT files
        eng.eval("ResistanceDeLigne = R_300;");      // From ResistanceDeLigne.mat
        eng.eval("CapacitanceDeLigne = C_300;");     // From CapacitanceDeLigne.mat
        eng.eval("InductanceDeLigne = L_300;");      // From InductanceDeLigne.mat
        eng.eval("DistanceDeLigne = Ltot_806_808;"); // From DistanceDeLigne.mat (choose as needed)
        // variable is already present in variable.mat

        // === DIAGNOSTIC START: Check if critical .mat variables are loaded ===
        String[] criticalMatVariables = {"ResistanceDeLigne", "InductanceDeLigne", "CapacitanceDeLigne", "DistanceDeLigne", "variable"};
        for (String varName : criticalMatVariables) {
            try {
                Object rawExistResult = eng.feval("exist", varName, "var");
                Double exists = null;
                if (rawExistResult instanceof Double) {
                    exists = (Double) rawExistResult;
                } else if (rawExistResult instanceof Object[]) {
                    Object[] existArray = (Object[]) rawExistResult;
                    if (existArray.length > 0 && existArray[0] instanceof Double) {
                        exists = (Double) existArray[0];
                    }
                }
                if (exists != null) {
                    if (exists == 1.0) {
                        System.out.println("SimLogic: DIAGNOSTIC - Variable '" + varName + "' EXISTS in MATLAB workspace.");
                    } else {
                        System.out.println("SimLogic: DIAGNOSTIC - Variable '" + varName + "' DOES NOT EXIST in MATLAB workspace (exist returned " + exists + ").");
                    }
                } else {
                    System.out.println("SimLogic: DIAGNOSTIC - Could not reliably determine if '" + varName + "' exists. 'exist' command returned: " + (rawExistResult != null ? rawExistResult.getClass().getName() : "null"));
                }
            } catch (Exception e_diag) {
                System.err.println("SimLogic: DIAGNOSTIC - Error during MATLAB 'exist' check for variable '" + varName + "': " + e_diag.getMessage());
            }
        }
        // System.out.println("SimLogic: DIAGNOSTIC - Listing all variables in MATLAB workspace (output may go to MATLAB console or stdout):");
        // eng.eval("whos"); // Uncomment to see all variables in MATLAB's output
        // === DIAGNOSTIC END ===

        // Step 3: Set constants
        double f = 50;
        double w = 2 * Math.PI * f;
        eng.putVariable("f", f);
        eng.putVariable("w", w);

        // Load active and reactive matrices from MATLAB
        double[][] activeA = (double[][]) eng.getVariable("activeA");
        double[][] reactiveA = (double[][]) eng.getVariable("reactiveA");

        // Step 4: Loop through simulations
        int simCount = activeA.length; // number of simulations (rows)
        for (int i = 0; i < simCount; i++) { // 0-based for Java, matches Python
            double P = activeA[i][2];    // adjust column index as needed
            double QL = reactiveA[i][2]; // adjust column index as needed
            double QC = 0;               // or use your capacitive matrix if you have one
            if (P == 0 && QL == 0 && QC == 0) {
                System.out.println("[SKIP] All of P, QL, QC are zero for this simulation. Skipping simulation " + (i+1));
                continue;
            }
            System.out.println("▶️ Simulation " + (i+1) + "/" + simCount);
            eng.eval("Z_index = " + (i+1) + ";");
            // Set variables for this simulation, as in CollectionAG806_808.m and CourantCCabc.m
            eng.eval("Vstation = variable(" + (i+1) + ", 1);");
            eng.eval("Ustation = variable(" + (i+1) + ", 2);");
            eng.eval("RF1 = variable(" + (i+1) + ", 6);");
            eng.eval("disdef = variable(" + (i+1) + ", 7);");
            eng.eval("Dpha = 0;");
            eng.eval("Dphb = -120;");
            eng.eval("Dphc = 120;");
            eng.eval("frequence = 60;");
            eng.eval("Qc844 = [100e3 100e3 100e3];");
            eng.eval("Qc848 = [150e3 150e3 150e3];");

            eng.eval("R = ResistanceDeLigne(Z_index,:);");
            eng.eval("L = InductanceDeLigne(Z_index,:);");
            eng.eval("C = CapacitanceDeLigne(Z_index,:);");
            eng.eval("Distance = DistanceDeLigne;");

            // Debug: print all key variables to help find NaN/Inf
            System.out.println("[DEBUG] Vstation=" + eng.getVariable("Vstation"));
            System.out.println("[DEBUG] Ustation=" + eng.getVariable("Ustation"));
            System.out.println("[DEBUG] RF1=" + eng.getVariable("RF1"));
            System.out.println("[DEBUG] disdef=" + eng.getVariable("disdef"));
            System.out.println("[DEBUG] Dpha=" + eng.getVariable("Dpha"));
            System.out.println("[DEBUG] Dphb=" + eng.getVariable("Dphb"));
            System.out.println("[DEBUG] Dphc=" + eng.getVariable("Dphc"));
            System.out.println("[DEBUG] frequence=" + eng.getVariable("frequence"));
            System.out.println("[DEBUG] Qc844=" + java.util.Arrays.toString((double[]) eng.getVariable("Qc844")));
            System.out.println("[DEBUG] Qc848=" + java.util.Arrays.toString((double[]) eng.getVariable("Qc848")));
            System.out.println("[DEBUG] R=" + java.util.Arrays.toString((double[]) eng.getVariable("R")));
            System.out.println("[DEBUG] L=" + java.util.Arrays.toString((double[]) eng.getVariable("L")));
            System.out.println("[DEBUG] C=" + java.util.Arrays.toString((double[]) eng.getVariable("C")));
            System.out.println("[DEBUG] Distance=" + eng.getVariable("Distance"));

            // MATLAB workspace NaN/Inf check
            eng.eval("disp('--- MATLAB NaN/Inf check ---');");
            eng.eval("vars = whos; for k=1:length(vars), v=eval(vars(k).name); if isnumeric(v) && (any(isnan(v(:))) || any(isinf(v(:)))), disp(['NaN/Inf in ', vars(k).name]); end; end");

            eng.eval("Z = (R + 1i*w*L) .* Distance;");
            eng.eval("Y = 1i*w*C .* Distance;");
            eng.eval("Z0 = sqrt(Z ./ Y);");
            eng.eval("Va = 220 * exp(1i*0);");
            eng.eval("Vb = 220 * exp(-1i*2*pi/3);");
            eng.eval("Vc = 220 * exp(1i*2*pi/3);");
            eng.eval("V = [Va; Vb; Vc];");

            SimulinkRunner.runSimulinkModel(eng, "Model");
            eng.eval("Iabc = [Ia'; Ib'; Ic'];");
            OutputSaver.saveCurrents(eng, i+1);
        }

        System.out.println("✅ All simulations completed and results saved.");
    }
}
