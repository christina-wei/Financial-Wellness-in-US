#### Preamble ####
# Purpose: Downloads and saves data from US General Social Survey
# Author: Michaela Drouillard & Christina Wei
# Data: 21 February 2023
# Contact: michaela.drouillard@mail.utoronto.ca & christina.wei@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Data source: https://gss.norc.org/


#### Workspace setup ####
library(tidyverse)
library(haven) # for reading DTA files

#### Download data ####

# Download & unzip all the GSS data across the years
zip_file <- "inputs/data/large_files/GSS_stata.zip"

download.file("https://gss.norc.org/documents/stata/GSS_stata.zip", zip_file)
unzip(zip_file, exdir = "inputs/data/large_files")

# read dta data and write to csv
raw_gss_data <- read_dta("inputs/data/large_files/gss7221_r3a.dta")


## Filter and save data related to respondent info and survey questions

# Respondent information
raw_respondent_info <-
  raw_gss_data |>
  select(
    year,
    id,
    wrkstat,
    cohort,
    satjob,
    occ10,
    age,
    degree,
    class,
    class1,
    sexbirth1,
    marital,
    realinc,
    income16
  )

write_csv(
  x = raw_respondent_info,
  file = "inputs/data/raw_respondent_info.csv"
)

# Finance related surveys
raw_finance_survey <-
  raw_gss_data |>
  select(year, id, confinan, satfin, finalter, finrela)

write_csv(
  x = raw_finance_survey,
  file = "inputs/data/raw_finance_survey.csv"
)
