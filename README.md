# Analysis of Financial Wellness in the United States

## Overview of Paper

This paper analyzes data from US General Social Survey (GSS) to understand the state of financial wellness within the United States. Specifically, we look at the survey questions related to financial satisfaction, changes in financial situation, comparing financial situation with others, and self-identifed social class.

## File Structure

The repo is structured as the following:

-   `inputs/data` contains the raw data sources form GSS.

-   `inputs/info` contains reference information related to GSS data, such as the codebook and methodological primer.

-   `outputs/data` contains the cleaned data to be used in our report

-   `outputs/paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper.

-   `scripts` contains the R scripts used to simulate, download, clean and validate data, as well as helper functions used in these routines.

## How to Run

1.  Run `scripts/01-download_data.R` to download raw data

2.  Run `scripts/02-data_cleaning.R` to generate cleaned data

3.  Run `scripts/03-test_data.R` to validate data integrity

4.  Run `outputs/paper/covid_clinic.qmd` to generate the PDF of the paper
