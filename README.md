# Getting and Cleaning Data Final Project

## Project Description
This is the Readme document for the Getting and Cleaning Data Final Project. This explains how to use the run_analysis.R script to generate the tidydata.txt file.

## Raw Data
The raw data can be found from the below link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_analysis.R script will create a directory titled "UCI HAR Dataset" and download the zip files into the directory. 

## The run_analysis Script
This script will take the raw data and generate a new tidydata text file. The script does the following:
* Downloads the file and reads the relevant sub-files:
** x_test.txt
** x_train.txt
** y_test.txt
** y_train.txt
** subject_test.txt
** subject_train.txt

* Merges all of the data into one data set

* Uses descriptive activity names to name the activities in the data set and appropriately labels the data set with descriptive variable names.

* Extracts mean and standard deviation observations

* Creates a new dataset with the average of each variable for each activity and each subject titled tidydata.txt

## Tidydata.txt
Resulting table from the run_analysis script. Data is tidy because:
* Each variable forms a column -- there are 68 columns
* Each observation forms a row -- there are 180 rows
* The observational unit is in one table


