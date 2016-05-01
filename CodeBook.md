#Getting and Cleaning Data Course Project - CodeBook

#Description

Additional information about the variables, data and transformations used in the course project for the Getting and Cleaning Data course.

#Dataset
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#Input from Data Set

The input data containts the following data files:

* X_train.txt contains variable features that are intended for training.
* y_train.txt contains the activities corresponding to X_train.txt.
* subject_train.txt contains information on the subjects from whom data is collected.
* X_test.txt contains variable features that are intended for testing.
* y_test.txt contains the activities corresponding to X_test.txt.
* subject_test.txt contains information on the subjects from whom data is collected.
* activity_labels.txt contains metadata on the different types of activities.
* features.txt contains the name of the features in the data sets.

#Transformations of the Data set

* features.txt is read into features.
* activity_labels.txt is read into activity.
* X_train.txt is read into Feature_XTrain.
* y_train.txt is read into Activity_YTrain.
* subject_train.txt is read into Subject_Train.
* X_test.txt is read into Feature_XTest.
* y_test.txt is read into Activity_YTest.
* subject_test.txt is read into Subject_Test.
* The subjects in training and test set data are merged to form subject.
* The activities in training and test set data are merged to form activity.
* The features of test and training are merged to form features.
* The name of the features are set in features from features.
* features, activity and subject are merged to form cleanedData.
* Indices of columns that contain std or mean, activity and subject are taken into Act_sub_column.
* extractData is created with data from columns in Act_sub_column.
* Activity column in extractData is updated with descriptive names of activities taken from activity. 
* Activity column is expressed as a factor variable.
* Acronyms in variable names in extractData, like 'Acc', 'Gyro', 'Mag', 't' and 'f' are replaced with descriptive labels such as 'Accelerometer', 'Gyroscpoe', 'Magnitude', 'Time' and 'Frequency'.
* tidycleanedData is created as a set with average for each activity and subject of extractData. 
* Entries in tidycleanedData are ordered based on activity and subject.
* The data in tidycleanedData is written into tidy_dataset.txt.

#Output
The clean and tidy data is written into tidy_dataset.txt. The header line contains the names of the variables. It contains the mean and standard deviation values of the data contained in the input files. The header is restructued in an understandable manner.
