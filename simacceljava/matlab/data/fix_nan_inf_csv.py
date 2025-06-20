import pandas as pd
import numpy as np
import glob
import os

def fix_csv_file(filepath):
    df = pd.read_csv(filepath)
    changed = False
    if df.isnull().values.any() or np.isinf(df.values).any():
        df = df.replace([np.nan, np.inf, -np.inf], 0)
        changed = True
    if changed:
        df.to_csv(filepath, index=False)
        print(f"Fixed NaN/Inf in: {os.path.basename(filepath)}")
    else:
        print(f"No NaN/Inf found in: {os.path.basename(filepath)}")

if __name__ == "__main__":
    csv_files = glob.glob("*.csv")
    for csv_file in csv_files:
        fix_csv_file(csv_file)
