#### Preamble ####
# Purpose: Tests the structure and validity of the simulated NFL dataset.
# Author: Vandan Patel
# Date: December 3, 2024
# Contact: vandanp.patel@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - The tidyverse package must be installed and loaded
#   - Simulated data must have been generated and saved
# Any other information needed? Ensure you are in the correct project directory.

#### Workspace setup ####
library(tidyverse)

simulated_data <- read_csv("data/00-simulated_data/simulated_nfl_data.csv")

# Test if the data was successfully loaded
if (exists("simulated_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}

#### Test data ####

# Check if the dataset has 32 rows (one for each NFL team)
if (nrow(simulated_data) == 32) {
  message("Test Passed: The dataset has 32 rows.")
} else {
  stop("Test Failed: The dataset does not have 32 rows.")
}

# Check if the dataset has 9 columns (team stats and QB stats)
if (ncol(simulated_data) == 9) {
  message("Test Passed: The dataset has 9 columns.")
} else {
  stop("Test Failed: The dataset does not have 9 columns.")
}

# Check if all values in the 'team' column are unique
if (n_distinct(simulated_data$team) == nrow(simulated_data)) {
  message("Test Passed: All values in 'team' are unique.")
} else {
  stop("Test Failed: The 'team' column contains duplicate values.")
}

# Check if the 'playoff_status' column contains only valid statuses
valid_statuses <- c("Made Playoffs", "Missed Playoffs")

if (all(simulated_data$playoff_status %in% valid_statuses)) {
  message("Test Passed: The 'playoff_status' column contains only valid statuses.")
} else {
  stop("Test Failed: The 'playoff_status' column contains invalid statuses.")
}

# Check if there are any missing values in the dataset
if (all(!is.na(simulated_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Check if numeric columns have reasonable values
if (all(simulated_data$total_passing_yards >= 0 & simulated_data$total_passing_yards <= 6000)) {
  message("Test Passed: The 'total_passing_yards' column has reasonable values.")
} else {
  stop("Test Failed: The 'total_passing_yards' column has unreasonable values.")
}

if (all(simulated_data$total_touchdowns >= 0 & simulated_data$total_touchdowns <= 60)) {
  message("Test Passed: The 'total_touchdowns' column has reasonable values.")
} else {
  stop("Test Failed: The 'total_touchdowns' column has unreasonable values.")
}

if (all(simulated_data$total_interceptions >= 0 & simulated_data$total_interceptions <= 30)) {
  message("Test Passed: The 'total_interceptions' column has reasonable values.")
} else {
  stop("Test Failed: The 'total_interceptions' column has unreasonable values.")
}

# Check if the 'total_wins' column has values between 0 and 17
if (all(simulated_data$total_wins >= 0 & simulated_data$total_wins <= 17)) {
  message("Test Passed: The 'total_wins' column has reasonable values.")
} else {
  stop("Test Failed: The 'total_wins' column has unreasonable values.")
}

# Check if there are at least two unique values in 'playoff_status'
if (n_distinct(simulated_data$playoff_status) >= 2) {
  message("Test Passed: The 'playoff_status' column contains at least two unique values.")
} else {
  stop("Test Failed: The 'playoff_status' column contains less than two unique values.")
}

# Check if the 'team' column contains 32 NFL teams
expected_teams <- c(
  "Arizona Cardinals", "Atlanta Falcons", "Baltimore Ravens", "Buffalo Bills",
  "Carolina Panthers", "Chicago Bears", "Cincinnati Bengals", "Cleveland Browns",
  "Dallas Cowboys", "Denver Broncos", "Detroit Lions", "Green Bay Packers",
  "Houston Texans", "Indianapolis Colts", "Jacksonville Jaguars", "Kansas City Chiefs",
  "Las Vegas Raiders", "Los Angeles Chargers", "Los Angeles Rams", "Miami Dolphins",
  "Minnesota Vikings", "New England Patriots", "New Orleans Saints", "New York Giants",
  "New York Jets", "Philadelphia Eagles", "Pittsburgh Steelers", "San Francisco 49ers",
  "Seattle Seahawks", "Tampa Bay Buccaneers", "Tennessee Titans", "Washington Commanders"
)

if (all(simulated_data$team %in% expected_teams)) {
  message("Test Passed: The 'team' column contains all expected NFL teams.")
} else {
  stop("Test Failed: The 'team' column does not contain all expected NFL teams.")
}
