=========================================================
Course project: Getting and cleaning data
=========================================================
Author: Victor V. Bucha
=========================================================

Course project cleans dataset "Human Activity Recognition Using Smartphones Dataset" in accordiance with course tasks: 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Input dataset should be downloaded and unziped in working folder. Source dataset located here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


The repository includes following files:
=========================================

- 'run_Analysis.R': Script for dataset loading and processing 
- 'tidy_dataset.txt': output dataset created by script
- 'CodeBool.MD': a code book that describes the variables and the data
- 'README.MD': This file

How to run script: 
=========================
1) Unpack UCI HAR dataset to working folder. Unzip creates "UCI HAR Daaset" folder by default
2) Modify 'data_dir' variable located in 'run_Analysis.R'. It should contain a path to input dataset
3) Run script in R
4) Script will do processing through 1-5 steps and create 'tidy_dataset.txt' file as an output


