# Getting-and-Cleaning-Data-Course-Project
## Contains the submission for the final project for "Getting and Cleaning Data Course"
This repo contains the following:
- run_analysis.R <- a script to perform the analysis
- output_dataset.txt <- an example of the output from run_analysis.R
- codebook.md <- an explanation of the variables output from the analysis

## Background
Data was collected from the sensors of smartphones. This data was used to investigate the recognition of human activities.
More information on the study can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data used in this analysis was sourced from here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## The analysis
The data contained the measurements from the accelerometers during different activities performed by 30 different subjects. 
The measurements were also summarized by standard deviation and mean.
An analysis of the data was performed and the means of the standard deviations and means were calculated.

The general process of the analysis was as follows:
- Set up R environment (required dplyr package)
- Confirm test data has been downloaded to wd, and download if not
- Read in data to R
- Assemble data table from the various files
- Filter to only include columns relating to standard deviation or mean 
- Edit data table to include recognizable variabe names
- Arrange the data table and calculate the mean for each subject/activity combination, for each column
- Return the results as a datatable.

## The output
run_analysis.R returns a datatable containing the calculated means for each subject/activity/variable.
run_analysis.R usage is as follows:
```{r}
x <- run_analysis()
```
The file output_dataset.txt is an example of the result. It can be read into R using the read.table command.
```{r}
x <- read.table("output_dataset.txt")
```
