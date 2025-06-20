import scipy.io
import numpy as np
import os

def fix_mat_file(filepath):
    data = scipy.io.loadmat(filepath)
    changed = False
    for key in data:
        if isinstance(data[key], np.ndarray):
            arr = data[key]
            if np.any(np.isnan(arr)) or np.any(np.isinf(arr)):
                arr = np.nan_to_num(arr, nan=0.0, posinf=0.0, neginf=0.0)
                data[key] = arr
                changed = True
    if changed:
        scipy.io.savemat(filepath, data)
        print(f"Fixed NaN/Inf in: {os.path.basename(filepath)}")
    else:
        print(f"No NaN/Inf found in: {os.path.basename(filepath)}")

if __name__ == "__main__":
    import glob
    mat_files = glob.glob("*.mat")
    for mat_file in mat_files:
        fix_mat_file(mat_file)
