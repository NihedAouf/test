import pandas as pd
import numpy as np
import glob
import os

def fix_xlsx_file(filepath):
    try:
        df = pd.read_excel(filepath, engine='openpyxl')
        changed = False
        if df.isnull().values.any() or np.isinf(df.values).any():
            df = df.replace([np.nan, np.inf, -np.inf], 0)
            changed = True
        if changed:
            df.to_excel(filepath, index=False, engine='openpyxl')
            print(f"Fixed NaN/Inf in: {os.path.basename(filepath)}")
        else:
            print(f"No NaN/Inf found in: {os.path.basename(filepath)}")
    except Exception as e:
        print(f"Error processing {filepath}: {e}")

if __name__ == "__main__":
    xlsx_files = glob.glob("*.xlsx")
    for xlsx_file in xlsx_files:
        fix_xlsx_file(xlsx_file)
