#### Preamble ####
# Purpose: Simulates data for survey results regarding financial attitudes
# Author: Christina Wei
# Data: 12 March 2023
# Contact: christina.wei@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Assumptions:
  # Assume there are survey results for each year from 1970 to 2022
  # Assume there are 10 participant responses each year
  # Assign financial satisfactions at random (equal weight to each answer)
  # Assign social class at random (equal weight to each answer)

#### Workspace setup ####
library(tidyverse)


#### Simulate data ####

## Enumerations of data values & assumptions

sim_financial_satisfaction = c("Not Satisfied", "Neutral", "Satisfied")
sim_social_status = c("Lower Class", "Working Class", "Middle Class", "Upper Class")
sim_gender = c("Male", "Female", "Other")
sim_years = 1970:2022
num_participants = 10
total_size = num_participants * length(sim_years)

## Simulation

set.seed(311) #random seed

simulated_data = 
  tibble(
    year = rep(sim_years, each = num_participants),
    participant_id = rep(1:num_participants, times = length(sim_years)),
    age = floor(runif(n = total_size,
                min = 18,
                max = 100)),
    gender = sample(x = sim_gender,
                    size = total_size,
                    replace = TRUE),
    financial_satisfaction = sample(x = sim_financial_satisfaction,
                                    size = total_size,
                                    replace = TRUE),
    social_status = sample(x = sim_social_status,
                           size = total_size,
                           replace = TRUE),
  )

## View and test characteristics of simulated data

mean(simulated_data$age)
min(simulated_data$year) == 1970
max(simulated_data$year) == 2022

simulated_data |>
  group_by(gender) |>
  count()

simulated_data |>
  group_by(financial_satisfaction) |>
  count()

simulated_data |>
  group_by(social_status) |>
  count()