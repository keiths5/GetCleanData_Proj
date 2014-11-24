GetCleanData_Proj
=================

Coursera Data Scientest - GetClanData Project

The two files provided are:
  1) run_analysis.R - code
  2) code_book.txt  - definition of rows and columns in the provided tidy dataset

For this code to run, it is assumed that the zip file:
getdata-projectfiles-UCI HAR Dataset.zip was downloaded and unzipped.
The folder "UCI HAR Dataset" is a sub-folder from the current project folder.

The run_analysis.R code does the following:
1) reads in the test heading file (same as train heading file)
2) read in the test and train data files and creates a data frame, this data frame only has 6 columns - mean and std for each X, Y, and Z measurement
3) adds the headings to the test and train data frame
4) reads in the test and train activity frame
5) binds the activity data frame onto the test and train measurement data frame
6) creates the required tidy summary of mean for each of the measurements and activities.
7) creates the row and column names for the tidy summary file
8) writes out the tidy summary file.