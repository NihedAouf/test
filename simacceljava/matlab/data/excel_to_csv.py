import os
import pandas as pd

# Directory containing the Excel files
data_dir = os.path.dirname(__file__)

for fname in os.listdir(data_dir):
    if fname.lower().endswith('.xlsx'):
        xlsx_path = os.path.join(data_dir, fname)
        csv_path = os.path.splitext(xlsx_path)[0] + '.csv'
        try:
            df = pd.read_excel(xlsx_path, engine='openpyxl')
            df.to_csv(csv_path, index=False)
            os.remove(xlsx_path)
            print(f"Converted and removed: {fname}")
        except Exception as e:
            print(f"Error processing {fname}: {e}")
