# About this Repository
This repository contains files for the course project for the Coursera Getting and Cleaning Data Course.  

## Files included
1. CodeBook.md    - this file
2. run_analysis.R - The R Script used to process and derive the tidy data
3. final_data.txt - The final tidy data

## About the Source Data

Source Data was downloaded from this location:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  


## How the Data was Processed
The Data was processed using the run_analysis.R script.  Please see this file was detailed processing steps.  In summary, the data was processed as follows:

1. Read the data files into R objects
2. Merged the training and the test sets to create one data set.
3. Extracted only the measurements on the mean and standard deviation for each measurement. 
4. Used descriptive activity names to name the activities in the data set
5. Appropriately labelled the data set with descriptive variable names. 
6. From the data set in step 5, created a second, independent tidy data set with the average of each variable for each activity and each subject.

## More Information
Please refer to the CodeBook.md file for additional details
