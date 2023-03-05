#### Preamble ####
# Purpose: Cleans data for GSS related to respondent information and surveys on financial topics
# Author: Michaela Drouillard & Christina Wei
# Data: 21 February 2023
# Contact: michaela.drouillard@mail.utoronto.ca & christina.wei@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-download_data.R

#### Workspace setup ####
library(tidyverse)

#### Download data ####

# unzip(
#   "inputs/data/raw_respondent_info.zip",
#   exdir = "inputs/data/large_files"
# )

raw_respondent_info =
  read_csv(
    file = "inputs/data/raw_respondent_info.csv",
    show_col_types = FALSE
  )

raw_finance_survey =
  read_csv(
    file = "inputs/data/raw_finance_survey.csv",
    show_col_types = FALSE
  )

## Update demographic data ##

# [work_status] Last week were you working full time, part time, going to school, keeping house, or what?
cleaned_respondent_info =
  raw_respondent_info |>
  mutate("work_status" = case_when(
    wrkstat == 1 ~ 'Full Time',
    wrkstat == 2 ~ 'Part Time',
    wrkstat == 3 ~ 'Temporarily Not Working',
    wrkstat == 4 ~ 'Unemployed',
    wrkstat == 5 ~ 'Retired',
    wrkstat == 6 ~ 'In School',
    wrkstat == 7 ~ 'Keeping House',
    wrkstat == 8 ~ 'Other',
  )) |>
  select (-wrkstat)

# [marital] Are you currently married, widowed, divorced, separated, or have you never been married?
cleaned_respondent_info =
  cleaned_respondent_info |>
  mutate("marital" = case_when(
    marital == 1 ~ 'Married',
    marital == 2 ~ 'Widowed',
    marital == 3 ~ 'Divorced',
    marital == 4 ~ 'Separated',
    marital == 5 ~ 'Never Married',
  ))

# [job_satisfaction] On the whole,how satisfied are you with the work you do?
# If planning to perform trend analysis with this variable, please consult GSS Methodological Report No. 56.
cleaned_respondent_info =
  cleaned_respondent_info |>
  mutate("job_satisfaction" = case_when(
    satjob == 1 ~ 'Very Satisfied',
    satjob == 2 ~ 'Moderately Satisfied',
    satjob == 3 ~ 'A little Dissatisfied',
    satjob == 4 ~ 'Very Dissatisfied',
  )) |>
  select (-satjob)

# [cohort] Birth cohort of respondent.
# Defined based on generations https://caregiversofamerica.com/2022-generation-names-explained/
cleaned_respondent_info =
  cleaned_respondent_info |>
  mutate("cohort_band" = case_when(
    cohort <= 1924 ~ 'Greatest',
    cohort >= 1925 & cohort <= 1945 ~ 'Silent',
    cohort >= 1946 & cohort <= 1964 ~ 'Boomer',
    cohort >= 1965 & cohort <= 1979 ~ 'Gen X',
    cohort >= 1980 & cohort <= 1994 ~ 'Millenials',
    cohort >= 1995 & cohort <= 2012 ~ 'Gen Z'
  ))

# [occupation] Respondent's occupation
cleaned_respondent_info =
  cleaned_respondent_info |>
  mutate("occupation" = case_when(
    occ10 == 10 ~ 'Management, Professional',
    occ10 == 3600 ~ 'Service',
    occ10 == 4700 ~ 'Sales, Office',
    occ10 == 6010 ~ 'Natural Resources, Construction, Maintenance',
    occ10 == 7700 ~ 'Production, Transportation, Material Moving',
    occ10 == 9830 ~ 'Military',
  )) |>
  select(-occ10)

# [degree] Respondent's degree
cleaned_respondent_info =
  cleaned_respondent_info |>
  mutate("degree" = case_when(
    degree == 0 ~ 'Less Than High School',
    degree == 1 ~ 'High School',
    degree == 2 ~ 'Associate/Junior College',
    degree == 3 ~ 'Bachelors',
    degree == 4 ~ 'Graduate',
  ))

# [born] Were you born in this country?
cleaned_respondent_info =
  cleaned_respondent_info |>
  mutate("born" = case_when(
    born == 1 ~ 'Yes',
    born == 2 ~ 'No',
  ))

# [social_class] Most people see themselves as belonging to a particular class. Please tell me which social class you would say you belong to?
cleaned_respondent_info =
  cleaned_respondent_info |>
  mutate("social_class" = case_when(
    class == 1 ~ 'Lower Class',
    class == 2 ~ 'Working Class',
    class == 3 ~ 'Middle Class',
    class == 4 ~ 'Upper Class',
  )) |>
  select(-class)

# [social_class] Most people see themselves as belonging to a particular class. Please tell me which social class you would say you belong to?
cleaned_respondent_info =
  cleaned_respondent_info |>
  mutate("social_class1" = case_when(
    class1 == 1 ~ 'Lower Class',
    class1 == 2 ~ 'Working Class',
    class1 == 3 ~ 'Lower Middle Class',
    class1 == 4 ~ 'Middle Class',
    class1 == 5 ~ 'Upper Middle Class',
    class1 == 6 ~ 'Upper Class',
  )) |>
  select(-class1)

# [sexual_orientation] 
cleaned_respondent_info =
  cleaned_respondent_info |>
  mutate("sexual_orientation" = case_when(
    sexornt == 1 ~ 'Homosexual',
    sexornt == 2 ~ 'Bisexual',
    sexornt == 3 ~ 'Heterosexual',
  )) |>
  select(-sexornt)

# [gender] 
cleaned_respondent_info =
  cleaned_respondent_info |>
  mutate("gender" = case_when(
    sexbirth1 == 1 ~ 'Male',
    sexbirth1 == 2 ~ 'Female',
  )) |>
  select(-sexbirth1)

# [family_income_band]
cleaned_respondent_info =
  cleaned_respondent_info |>
  mutate("family_income_bands" = case_when(
    realinc < 15000 ~ '<$15K',
    realinc >= 15000 & realinc < 25000 ~ '$15K-$25K',
    realinc >= 25000 & realinc < 35000 ~ '$25K-$35K',
    realinc >= 35000 & realinc < 50000 ~ '$35K-$50K',
    realinc >= 50000 & realinc < 75000 ~ '$50K-$75K',
    realinc >= 75000 & realinc < 100000 ~ '$75K-$100K',
    realinc >= 100000 ~ '>$100K',
  ))

# [respondent_income_band]
cleaned_respondent_info =
  cleaned_respondent_info |>
  mutate("respondent_income_bands" = case_when(
    realrinc < 15000 ~ '<$15K',
    realrinc >= 15000 & realrinc < 25000 ~ '$15K-$25K',
    realrinc >= 25000 & realrinc < 35000 ~ '$25K-$35K',
    realrinc >= 35000 & realrinc < 50000 ~ '$35K-$50K',
    realrinc >= 50000 & realrinc < 75000 ~ '$50K-$75K',
    realrinc >= 75000 & realrinc < 100000 ~ '$75K-$100K',
    realrinc >= 100000 ~ '>$100K',
  ))

# [age_band]
cleaned_respondent_info = 
  cleaned_respondent_info |>
  mutate("age_band" = case_when(
    age >= 18 & age <= 29 ~ '18-29',
    age >= 30 & age <= 39 ~ '30-39',
    age >= 40 & age <= 49 ~ '40-49',
    age >= 50 & age <= 64 ~ '50-64',
    age >= 65 & age <= 79 ~ '65-79',
    age >= 79 ~ '>=80'
  ))

# cleaned_respondent_info |> select(age_band) |> distinct()

# temp = cleaned_respondent_info |>
#   select(year, realinc) |>
#   group_by(year, realinc) |>
#   summarize(n = n())


## Update finance survey values ##

# [confidence_in_banks] Confidence in banks and financial institutions.
# (I am going to name some institutions in this country. As far as the people running this institution are concerned, would you say you have a great deal of confidence, only some confidence, or hardly any confidence at all in them?) Banks and financial institutions
# 1 - a great deal; 2 - only some; 3 - hardly any
cleaned_finance_survey = 
  raw_finance_survey |>
  mutate("confidence_in_banks" = case_when(
    confinan == 1 ~ 'A Great Deal',
    confinan == 2 ~ 'Only Some',
    confinan == 3 ~ 'Hardly Any',
  )) |>
  select (-confinan)
 
# [financial_satisfaction] Satisfaction with financial situation.
# We are interested in how people are getting along financially these days. So far as you and your family are concerned, would you say that you are pretty well satisfied with your present financial situation, more or less satisfied, or not satisfied at all?
# 1 - pretty well satisfied; 2 - more or less satisfied; 3 - not satisfied at all
cleaned_finance_survey = 
  cleaned_finance_survey |>
  mutate("financial_satisfaction" = case_when(
    satfin == 1 ~ 'Pretty Well Satisfied',
    satfin == 2 ~ 'More or Less Satisfied',
    satfin == 3 ~ 'Not Satisfied At All',
  )) |>
  select (-satfin)

# [financial_change] During the last few years, has your financial situation been getting better, worse, or has it stayed the same?
# 1 - getting better; 2 - getting worse; 3 - stayed the same
cleaned_finance_survey = 
  cleaned_finance_survey |>
  mutate("financial_change" = case_when(
    finalter == 1 ~ 'Getting Better',
    finalter == 2 ~ 'Getting Worse',
    finalter == 3 ~ 'Stayed the Same',
  )) |>
  select (-finalter)

# [financial_compare] Compared with American families in general, would you say your family income is far below average, below average, average, above average, or far above average? (PROBE: Just your best guess.)
# 1 - far below average; 2 - below average; 3 - average; 4 - above average; 5 - far above average
cleaned_finance_survey = 
  cleaned_finance_survey |>
  mutate("financial_compare" = case_when(
    finrela == 1 ~ 'Far Below Average',
    finrela == 2 ~ 'Below Average',
    finrela == 3 ~ 'Average',
    finrela == 4 ~ 'Above Average',
    finrela == 5 ~ 'Far Above Average',
  )) |>
  select (-finrela)

#### Save data ####

write_csv(
  x = cleaned_respondent_info,
  file = "outputs/data/cleaned_respondent_info.csv"
)

write_csv(
  x = cleaned_finance_survey,
  file = "outputs/data/cleaned_finance_survey.csv"
)
