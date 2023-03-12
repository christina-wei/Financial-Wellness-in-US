#### Preamble ####
# Purpose: Validate cleaned datasets for both respondent and survey data
# Author: Christina Wei
# Data: 12 March 2023
# Contact: christina.wei@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
  # 01-download_data.R
  # 02-data_cleaning.R

#### Workspace setup ####
library(tidyverse)

#### Read in cleaned data ####

cleaned_respondent_info = read_csv(
  file = here("outputs/data/cleaned_respondent_info.csv"),
  show_col_types = FALSE
)

cleaned_finance_survey = read_csv(
  file = here("outputs/data/cleaned_finance_survey.csv"),
  show_col_types = FALSE
)

#### Data Validation ####

# NA threshold - less than 10% of data
threshold = 0.1
num_NA_threshold = nrow(cleaned_respondent_info) * threshold 
num_NA_threshold_2021 = nrow(filter(cleaned_respondent_info, year == 2021)) * threshold

## Respondent info ##

# year
class(cleaned_respondent_info$year) == "numeric"
min(cleaned_respondent_info$year) <= 1972
max(cleaned_respondent_info$year) >= 2021
sum(is.na(cleaned_respondent_info$year)) == 0 #no N/As for year

# cohort
class(cleaned_respondent_info$cohort) == "numeric"
max(cleaned_respondent_info |>
  select(cohort) |>
  filter(cohort != 9999)) <= as.numeric(format(Sys.Date(), format = "%Y")) - 18
min(cleaned_respondent_info$cohort, na.rm = TRUE) >= 1972 - 100
sum(is.na(cleaned_respondent_info$cohort)) < num_NA_threshold

# cohort_band
sum(is.na(cleaned_respondent_info$cohort_band)) ==
  sum(is.na(cleaned_respondent_info$cohort)) +
  sum(cleaned_respondent_info$cohort == 9999, na.rm = TRUE)
sum(!(unique(cleaned_respondent_info$cohort_band) %in%
        c("Boomer",
          "Greatest",
          "Silent",
          "Gen X",
          "Millenials",
          "Gen Z",
          NA))) == 0

# age
class(cleaned_respondent_info$age) == "numeric"
max(cleaned_respondent_info$age, na.rm = TRUE) <= 120
min(cleaned_respondent_info$age, na.rm = TRUE) >= 18
sum(is.na(cleaned_respondent_info$age)) < num_NA_threshold

# age_band
sum(is.na(cleaned_respondent_info$age)) == 
  sum(is.na(cleaned_respondent_info$age_band))
sum(!(unique(cleaned_respondent_info$age_band) %in%
        c("18-29",
          "30-39",
          "40-49",
          "50-64",
          "65-79",
          ">=80",
          NA))) == 0

# degree
class(cleaned_respondent_info$degree) == "character"
sum(!(unique(cleaned_respondent_info$degree) %in%
  c("Bachelors",
    "Less Than High School",
    "High School",
    "Graduate",
    "Associate/Junior College",
    NA))) == 0
sum(is.na(cleaned_respondent_info$degree)) < num_NA_threshold

# marital
class(cleaned_respondent_info$marital) == "character"
sum(!(unique(cleaned_respondent_info$marital) %in%
        c("Never Married",
          "Married",
          "Divorced",
          "Widowed",
          "Separated",
          NA))) == 0
sum(is.na(cleaned_respondent_info$marital)) < num_NA_threshold

# social_class
class(cleaned_respondent_info$social_class) == "character"
sum(!(unique(cleaned_respondent_info$social_class) %in%
        c("Lower Class",
          "Working Class",
          "Upper Class",
          "Middle Class",
          NA))) == 0
sum(is.na(cleaned_respondent_info$social_class)) < num_NA_threshold

# social_class1
class(cleaned_respondent_info$social_class1) == "character"
sum(!(unique(cleaned_respondent_info$social_class1) %in%
        c("Lower Class",
          "Working Class",
          "Upper Class",
          "Middle Class",
          "Lower Middle Class",
          "Upper Middle Class",
          NA))) == 0

# gender
class(cleaned_respondent_info$gender) == "character"
sum(!(unique(cleaned_respondent_info$gender) %in%
        c("Male",
          "Female",
          NA))) == 0
sum(is.na(cleaned_respondent_info |>
  filter(year == 2021) |>
  select(gender))) < num_NA_threshold_2021

# income
class(cleaned_respondent_info$income) == "character"
sum(!(unique(cleaned_respondent_info$income) %in%
        c("<$10K",
          "$10K-$20K",
          "$20K-$30K",
          "$30K-$40K",
          "$40K-$50K",
          "$50K-$60K",
          "$60K-$75K",
          "$75K-$90K",
          "$90K-$110K",
          "$110K-$130K",
          "$130K-$150K",
          "$150K-$170K",
          ">$170K",
          NA))) == 0


## Survey results ##

# year
class(cleaned_finance_survey$year) == "numeric"
min(cleaned_finance_survey$year) <= 1972
max(cleaned_finance_survey$year) >= 2021

# financial_satisfaction
class(cleaned_finance_survey$financial_satisfaction) == "character"
sum(!(unique(cleaned_finance_survey$financial_satisfaction) %in%
        c("Not Satisfied At All",
          "More or Less Satisfied",
          "Pretty Well Satisfied",
          NA))) == 0
sum(is.na(cleaned_finance_survey$financial_satisfaction)) < num_NA_threshold

# financial_change
class(cleaned_finance_survey$financial_change) == "character"
sum(!(unique(cleaned_finance_survey$financial_change) %in%
        c("Getting Better",
          "Stayed the Same",
          "Getting Worse",
          NA))) == 0
sum(is.na(cleaned_finance_survey$financial_change)) < num_NA_threshold

# financial_compare
class(cleaned_finance_survey$financial_compare) == "character"
sum(!(unique(cleaned_finance_survey$financial_compare) %in%
        c("Average",
          "Above Average",
          "Below Average",
          "Far Above Average",
          "Far Below Average",
          NA))) == 0
sum(is.na(cleaned_finance_survey$financial_compare)) < num_NA_threshold
