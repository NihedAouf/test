import os
import pandas as pd

# List of relevant CSV files
csv_files = [
    'activeA.csv', 'activeB.csv', 'activeC.csv',
    'reactiveA.csv', 'reactiveB.csv', 'reactiveC.csv'
]

data_dir = os.path.dirname(__file__)
file_paths = [os.path.join(data_dir, f) for f in csv_files]

# Load all CSVs into DataFrames
dfs = [pd.read_csv(fp) for fp in file_paths]

# Assume all CSVs have the same shape
rows, cols = dfs[0].shape

# For each row, if all values across all files and columns are zero, set all columns in activeA to 1.0
for i in range(rows):
    all_zero = True
    # Check all columns in all files for this row
    for df in dfs:
        if (df.iloc[i].to_numpy() != 0).any():
            all_zero = False
            break
    if all_zero:
        dfs[0].iloc[i, :] = 1.0  # Set all columns of activeA to 1.0 for this row
        print(f"Row {i+1}: All zero across all files/columns, set activeA.csv row to 1.0 in all columns")

# Save the updated DataFrames back to CSV
for df, fp in zip(dfs, file_paths):
    df.to_csv(fp, index=False)

print("CSV data updated to ensure at least one nonzero value per simulation.")
