# Getting and Cleaning Week4 Assignment
Peer-graded assignment for Data Science course

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

In this project, collected data was retrieved and cleaned so that it can be used for later analysis.

This repository contains the following files:

* README.md: provides an overview of the data set and how it was created. 
* CodeBook.md:describes the contents of the data set (data, variables and transformations used to generate the data).
* script.R: script used to create the data set.
* tidy_activity.csv: contains extracted tidy data set.
* tidy_activity_mean.csv: contains mean_extracted tidy data set.

The source data set that this project was based on was obtained from the Human Activity Recognition Using Smartphones Data Set, which describes how the data was initially collected as follows:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

Train and test data were first merged together to create one data set, then the measurements on the mean and standard deviation were extracted for each measurement (81 variables extracted from the original 563), and then the measurements were averaged for each subject and activity, resulting in the final data set.

Creating the data set

The R script script.R can be used to create the data set. It retrieves the source data set and transforms it to produce the final data set by implementing the following steps (see the Code book for details, as well as the comments in the script itself):

1. Download and unzip source data if it doesn't exist. Read data. 
2. Merge the training and the test sets to create one data set. 
3. Extract only the measurements on the mean and standard deviation for each measurement. 
4. Use descriptive activity names to name the activities in the data set. 
5. Appropriately label the data set with descriptive variable names. 
6. Create a second, independent tidy set with the average of each variable for each activity and each subject. 
7. Write the data set to the tidy_activity.csv and tidy_activity_mean.csv file. The used R version was 4.1.3.

This script requires the dplyr package
