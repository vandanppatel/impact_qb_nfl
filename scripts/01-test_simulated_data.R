#### Preamble ####
# Purpose: Tests the structure and validity of the simulated dataset
# Author: Vandan Patel
# Date: December 3, 2024
# Contact: vandanp.patel@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - The pandas library must be installed and imported.
# - The simulated dataset (e.g., 'simulated_data.csv') must be available in the `data` folder.

#### Workspace setup ####
import pandas as pd

# Load the dataset
try:
  analysis_data = pd.read_csv("data/00-simulated_data/simulated_data.csv")
print("Test Passed: The dataset was successfully loaded.")
except FileNotFoundError:
  raise Exception("Test Failed: The dataset could not be loaded.")

#### Test data ####

# Check if the dataset has 151 rows
if len(analysis_data) == 151:
  print("Test Passed: The dataset has 151 rows.")
else:
  raise Exception("Test Failed: The dataset does not have 151 rows.")

# Check if the dataset has 3 columns
if analysis_data.shape[1] == 3:
  print("Test Passed: The dataset has 3 columns.")
else:
  raise Exception("Test Failed: The dataset does not have 3 columns.")

# Check if all values in the 'division' column are unique
if analysis_data['division'].is_unique:
  print("Test Passed: All values in 'division' are unique.")
else:
  raise Exception("Test Failed: The 'division' column contains duplicate values.")

# Check if the 'state' column contains only valid state names
valid_states = [
  "New South Wales", "Victoria", "Queensland", "South Australia",
  "Western Australia", "Tasmania", "Northern Territory",
  "Australian Capital Territory"
]

if set(analysis_data['state']).issubset(valid_states):
  print("Test Passed: The 'state' column contains only valid Australian state names.")
else:
  raise Exception("Test Failed: The 'state' column contains invalid state names.")

# Check if the 'party' column contains only valid party names
valid_parties = ["Labor", "Liberal", "Greens", "National", "Other"]

if set(analysis_data['party']).issubset(valid_parties):
  print("Test Passed: The 'party' column contains only valid party names.")
else:
  raise Exception("Test Failed: The 'party' column contains invalid party names.")

# Check if there are any missing values in the dataset
if analysis_data.isnull().values.any():
  raise Exception("Test Failed: The dataset contains missing values.")
else:
  print("Test Passed: The dataset contains no missing values.")

# Check if there are no empty strings in 'division', 'state', and 'party' columns
if all(analysis_data[['division', 'state', 'party']].applymap(lambda x: x.strip() != "").all()):
  print("Test Passed: There are no empty strings in 'division', 'state', or 'party'.")
else:
  raise Exception("Test Failed: There are empty strings in one or more columns.")

# Check if the 'party' column has at least two unique values
if analysis_data['party'].nunique() >= 2:
  print("Test Passed: The 'party' column contains at least two unique values.")
else:
  raise Exception("Test Failed: The 'party' column contains less than two unique values.")
