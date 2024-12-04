##### Preamble ####
# Purpose: Simulates a dataset of NFL teams and quarterbacks
# Author: Vandan Patel
# Date: December 3, 2024
# Contact: vandanp.patel@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Simulated dataset reflects key metrics for analysis


#### Workspace setup ####
library(tidyverse)
set.seed(853)


#### Simulate data ####

# Team names
teams <- c(
  "Arizona Cardinals", "Atlanta Falcons", "Baltimore Ravens", "Buffalo Bills",
  "Carolina Panthers", "Chicago Bears", "Cincinnati Bengals", "Cleveland Browns",
  "Dallas Cowboys", "Denver Broncos", "Detroit Lions", "Green Bay Packers",
  "Houston Texans", "Indianapolis Colts", "Jacksonville Jaguars", "Kansas City Chiefs",
  "Las Vegas Raiders", "Los Angeles Chargers", "Los Angeles Rams", "Miami Dolphins",
  "Minnesota Vikings", "New England Patriots", "New Orleans Saints", "New York Giants",
  "New York Jets", "Philadelphia Eagles", "Pittsburgh Steelers", "San Francisco 49ers",
  "Seattle Seahawks", "Tampa Bay Buccaneers", "Tennessee Titans", "Washington Commanders"
)

# Simulated dataset
simulated_data <- tibble(
  team = teams,
  passer_player_name = paste("Player", 1:length(teams)),  # Simulate QB names
  total_passing_yards = round(rnorm(length(teams), mean = 4000, sd = 500)), # Simulate passing yards
  total_touchdowns = round(rnorm(length(teams), mean = 30, sd = 5)), # Simulate passing touchdowns
  total_interceptions = round(rnorm(length(teams), mean = 12, sd = 3)), # Simulate interceptions
  total_points_scored = round(rnorm(length(teams), mean = 350, sd = 50)), # Simulate total points scored
  total_points_allowed = round(rnorm(length(teams), mean = 330, sd = 50)), # Simulate total points allowed
  avg_score_differential = total_points_scored - total_points_allowed, # Calculate score differential
  total_wins = sample(0:17, size = length(teams), replace = TRUE, prob = dbinom(0:17, size = 17, prob = 0.5)), # Simulate wins
  playoff_status = ifelse(total_wins >= 9, "Made Playoffs", "Missed Playoffs") # Simulate playoff qualification
)


#### Save data ####
write_csv(simulated_data, "data/00-simulated_data/simulated_nfl_data.csv")

