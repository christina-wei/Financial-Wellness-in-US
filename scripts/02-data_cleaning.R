#### Preamble ####
# Purpose: Cleans data .. [UPDATE ..]
# Author: Michaela Drouillard & Christina Wei
# Data: 21 February 2023
# Contact: michaela.drouillard@mail.utoronto.ca & christina.wei@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-download_data.R

#### Workspace setup ####
library(tidyverse)

#### Download data ####

unzip(
  "inputs/data/raw_respondent_info.zip",
  exdir = here("inputs/data/large_files")
)

raw_respondent_info =
  read_csv(
    file = "inputs/data/large_files/raw_respondent_info.csv",
    show_col_types = FALSE
  )

raw_finance_surve =
  read_csv(
    file = "inputs/data/raw_finance_survey.csv",
    show_col_types = FALSE
  )

#### Clean data ####
# [...UPDATE THIS...]

#### Save data ####
# [...UPDATE THIS...]