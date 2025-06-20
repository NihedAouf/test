package output;

import com.mathworks.engine.MatlabEngine;

import java.io.FileWriter;
import java.io.IOException;

public class OutputSaver {
    public static void saveCurrents(MatlabEngine eng, int index) throws Exception {
        double[] Ia = eng.getVariable("Ia");
        double[] Ib = eng.getVariable("Ib");
        double[] Ic = eng.getVariable("Ic");
        double[][] Iabc = eng.getVariable("Iabc");

        String base = "results/output_" + String.format("%02d", index);

        try (FileWriter writer = new FileWriter(base + "_IaIbIc.csv")) {
            writer.write("Ia,Ib,Ic\n");
            for (int i = 0; i < Ia.length; i++) {
                writer.write(Ia[i] + "," + Ib[i] + "," + Ic[i] + "\n");
            }
            System.out.println("💾 Saved: " + base + "_IaIbIc.csv");
        } catch (IOException e) {
            System.err.println("❌ Error saving IaIbIc: " + e.getMessage());
        }

        try (FileWriter writer = new FileWriter(base + "_Iabc.csv")) {
            for (double[] row : Iabc) {
                for (int j = 0; j < row.length; j++) {
                    writer.write(row[j] + (j < row.length - 1 ? "," : ""));
                }
                writer.write("\n");
            }
            System.out.println("💾 Saved: " + base + "_Iabc.csv");
        } catch (IOException e) {
            System.err.println("❌ Error saving Iabc: " + e.getMessage());
        }
    }
}
