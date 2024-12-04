#### Preamble ####
# Purpose: Model the relationship between QB/team metrics and team success
# Author: Vandan Patel
# Date: December 3, 2024
# Contact: vandanp.patel@mail.utoronto.ca
# License: MIT
# Pre-requisites: Cleaned data in the appropriate format
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)

#### Read cleaned data ####
qb_data <- read_parquet("data/02-analysis_data/cleaned_starting_qb_stats_2023.parquet")
team_data <- read_parquet("data/02-analysis_data/cleaned_team_stats_2023.parquet")

# Merge QB and Team Data
analysis_data <- qb_data |> 
  left_join(team_data, by = "posteam") |> 
  mutate(
    avg_score_differential = coalesce(avg_score_differential.x, avg_score_differential.y),
    playoff_status = as.factor(playoff_status),  # Convert to factor
    total_wins = as.numeric(total_wins),  # Ensure numeric type
    avg_score_differential = as.numeric(avg_score_differential)  # Ensure numeric type
  ) |> 
  select(
    passer_player_name, posteam, total_passing_yards, total_touchdowns, 
    total_interceptions, games_played.x, total_team_score, total_opponent_score,
    avg_score_differential,  # Unified column
    total_points_scored, total_points_allowed, total_wins, playoff_status
  ) |> 
  rename(games_played = games_played.x)

# Verify merged data
str(analysis_data)

#### Models ####

# Total Wins Model
wins_model <- stan_glm(
  formula = total_wins ~ total_passing_yards + total_touchdowns + total_interceptions +
    total_points_scored + avg_score_differential,
  data = analysis_data,
  family = gaussian(),
  prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
  prior_intercept = normal(location = 0, scale = 5, autoscale = TRUE),
  prior_aux = exponential(rate = 1, autoscale = TRUE),
  seed = 853
)

# Playoff Qualification Model
playoff_model <- stan_glm(
  formula = playoff_status ~ total_passing_yards + total_touchdowns + total_interceptions +
    total_points_scored + avg_score_differential,
  data = analysis_data,
  family = binomial(),
  prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
  prior_intercept = normal(location = 0, scale = 5, autoscale = TRUE),
  seed = 853
)

# Point Differential Model
point_diff_model <- stan_glm(
  formula = avg_score_differential ~ total_passing_yards + total_touchdowns + total_interceptions +
    total_points_scored + total_points_allowed,
  data = analysis_data,
  family = gaussian(),
  prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
  prior_intercept = normal(location = 0, scale = 5, autoscale = TRUE),
  prior_aux = exponential(rate = 1, autoscale = TRUE),
  seed = 853
)

#### Save Models ####
saveRDS(wins_model, "models/wins_model.rds")
saveRDS(playoff_model, "models/playoff_model.rds")
saveRDS(point_diff_model, "models/point_diff_model.rds")
