import pandas as pd

# Load your Excel files
activeA = pd.read_excel('activeA.xlsx', engine='openpyxl')
activeB = pd.read_excel('activeB.xlsx', engine='openpyxl')
activeC = pd.read_excel('activeC.xlsx', engine='openpyxl')
reactiveA = pd.read_excel('reactiveA.xlsx', engine='openpyxl')
reactiveB = pd.read_excel('reactiveB.xlsx', engine='openpyxl')
reactiveC = pd.read_excel('reactiveC.xlsx', engine='openpyxl')

# List of blocks/phases to check: (row, col, label)
blocks = [
    (8, 12, '816-824 D-I (1)-A', activeA, reactiveA),
    (8, 12, '816-824 D-I (1)-B', activeB, reactiveB),
    (8, 12, '816-824 D-I (1)-C', activeC, reactiveC),
    # Add more (row, col, label, active, reactive) as needed for other blocks/phases
]

num_sims = len(activeA)
for i in range(num_sims):
    for row, col, label, active, reactive in blocks:
        try:
            P = active.iloc[row, col]
            QL = reactive.iloc[row, col]
            QC = 0  # Add capacitive matrix if needed
            if P == 0 and QL == 0 and QC == 0:
                print(f"Skip simulation {i+1} for block {label}: all P, QL, QC are zero")
            else:
                print(f"Run simulation {i+1} for block {label}: P={P}, QL={QL}, QC={QC}")
        except Exception as e:
            print(f"Error in simulation {i+1} for block {label}: {e}")