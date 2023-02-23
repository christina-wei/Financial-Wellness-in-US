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
library(here)

#### Download data ####

# Download & unzip all the GSS data across the years
zip_file = here("inputs/data/large_files/GSS_stata.zip")

download.file("https://gss.norc.org/documents/stata/GSS_stata.zip", zip_file)
unzip(zip_file, exdir = here("inputs/data/large_files"))

# read dta data and write to csv
raw_gss_data = read_dta(here("inputs/data/large_files/gss7221_r3a.dta"))


## Filter and save data related to respondent info and survey questions of interest

# Respondent information
raw_respondent_info =
  raw_gss_data |>
  #select (year,id,wrkstat,hrs1,hrs2,evwork,occ,prestige,wrkslf,wrkgovt,commute,industry,occ80,prestg80,indus80,indus07,occonet,found,occ10,occindv,occstatus,occtag,prestg10,prestg105plus,indus10,indstatus,indtag,marital,martype,agewed,divorce,widowed,spwrksta,sphrs1,sphrs2,spevwork,cowrksta,cowrkslf,coevwork,cohrs1,cohrs2,spocc,sppres,spwrkslf,spind,spocc80,sppres80,spind80,spocc10,spoccindv,spoccstatus,spocctag,sppres10,sppres105plus,spind10,spindstatus,spindtag,coocc10,coind10,paocc16,papres16,pawrkslf,paind16,paocc80,papres80,paind80,paocc10,paoccindv,paoccstatus,paocctag,papres10,papres105plus,paind10,paindstatus,paindtag,maocc80,mapres80,mawrkslf,maind80,maocc10,maoccindv,maoccstatus,maocctag,mapres10,mapres105plus,maind10,maindstatus,maindtag,sibs,childs,age,agekdbrn,educ,paeduc,maeduc,speduc,coeduc,codeg,degree,padeg,madeg,spdeg,major1,major2,dipged,spdipged,codipged,cosector,whenhs,whencol,sector,eftotlt,barate,gradtounder,voedcol,voednme1,voedncol,voednme2,spsector,speftotlt,spbarate,spgradtounder,cobarate,cogradtounder,coeftotlt,sex,race,res16,reg16,mobile16,family16,famdif16,mawork,mawkbaby,mawkborn,mawk16,mawrkgrw,incom16,born,parborn,granborn,hompop,babies,preteen,teens,adults,unrelat,earnrs,income,rincome,income72,income77,rincom77,income82,rincom82,income86,rincom86,income91,rincom91,income98,rincom98,income06,rincom06,income16,rincom16)
  select(year, id, wrkstat, marital, cohort, satjob, occ10, age, degree, born, class1, sexornt, sexbirth1, realinc, realrinc) 

write_csv(
  x = raw_respondent_info,
  file = here("inputs/data/raw_respondent_info.csv")
)

# zip(
#   zipfile = "inputs/data/raw_respondent_info.zip",
#   files = "inputs/data/large_files/raw_respondent_info.csv",
#   extras = '-j'
# )

# Finance related surveys
raw_finance_survey =
  raw_gss_data |>
  select (year,id,confinan,satfin,finalter,finrela)

write_csv(
  x = raw_finance_survey,
  file = here("inputs/data/raw_finance_survey.csv")
)
