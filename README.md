# Getting-and-Cleaning-Data
This is a repository for the Getting and Cleaning Data course project.

#Course Project
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project is available at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This project aims to come out with tidy data set by cleaning and extracting usable data from the above zip file. By doing that,create one R script called run_analysis.R that does the following: 

1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement. 
3) Uses descriptive activity names to name the activities in the data set.
4) Appropriately labels the data set with descriptive variable names.

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

In this repository, you will find:

1) run_analysis.R : the R-code run on the data set

2) tidy_dataset.txt : the clean data extracted from the original data using run_analysis.R

3) CodeBook.md : the CodeBook reference to the variables in tidy_dataset.txt

4) README.md : the analysis of the code in run_analysis.R

#Getting Started

1) Unzip the source (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) into a folder on your local drive 

2) Put run_analysis.R into UCI HAR Dataset folder

3) In RStudio: setwd to UCI HAR Dataset folder

#Read Supporting Metadata

The supporting metadata in this data are the name of the features and the name of the activities. They are loaded into variables features and activity.
```
features<- read.table("features.txt")
activity<- read.table("activity_labels.txt", header = FALSE)
```

#Read Train Data
```
Subject_Train <- read.table("train/subject_train.txt", header = FALSE)
Activity_YTrain <- read.table("train/y_train.txt", header = FALSE)
Feature_XTrain <- read.table("train/X_train.txt", header = FALSE)
```

#Read test data
```
Subject_Test <- read.table("test/subject_test.txt", header = FALSE)
Activity_YTest <- read.table("test/y_test.txt", header = FALSE)
Feature_XTest <- read.table("test/X_test.txt", header = FALSE)
```

# 1) Merge the training and the test sets to create one data set

Combine the respective data in training and test data sets corresponding to subject, activity and features. The results are stored in Subject, Activities and Features.
```
Subject<- rbind(Subject_Train, Subject_Test)
Activities<- rbind(Activity_YTrain, Activity_YTest)
Features<- rbind(Feature_XTrain, Feature_XTest)
```

#Name the column 

The column features can be named from the metadata
```
colnames(Features) <- t(features[2])
```

#Adding column activity and subject and merge the data

The data in features, activity and subject are merged nowand stored in variable namd cleanedData 
```
colnames(Activities) <- "Activity"
colnames(Subject) <- "Subject"
cleanedData <- cbind(Features,Activities,Subject)
```

#2) Extracts only the measurements on the mean and standard deviation for each measurement

Extract the column indices that have either mean or standard in them.
```
measure_mean_std <- grep(".*Mean.*|.*Std.*", names(cleanedData), ignore.case=TRUE)
```
Add activity and subject columns to the list
```
Act_sub_column <- c(measure_mean_std, 562, 563)
```
Create extractData with the selected columns in Act_sub_column
```
extractData<- cleanedData[,Act_sub_column]
```

# 3) Uses descriptive activity names to name the activities in the data set

We need to change its type to character so that it can accept activity names which are taken from metadata activity.
```
extractData$Activity <- as.character(extractData$Activity)
for (i in 1:6){
  extractData$Activity[extractData$Activity == i] <- as.character(activity[i,2])
}
```
Set the activity variable in the data as a factor
```
extractData$Activity<- as.factor(extractData$Activity)
```

# 4) Appropriately labels the data set with descriptive variable names. 

By examining extractData, the following acronyms can be replaced:

* Acc can be replaced with Accelerometer
* Gyro can be replaced with Gyroscope
* BodyBody can be replaced with Body
* Mag can be replaced with Magnitude
* Character f can be replaced with Frequency
* Character t can be replaced with Time

```
names(extractData)<-gsub("Acc", "Accelerometer", names(extractData))
names(extractData)<-gsub("Gyro", "Gyroscope", names(extractData))
names(extractData)<-gsub("BodyBody", "Body", names(extractData))
names(extractData)<-gsub("Mag", "Magnitude", names(extractData))
names(extractData)<-gsub("^t", "Time", names(extractData))
names(extractData)<-gsub("^f", "Frequency", names(extractData))
names(extractData)<-gsub("tBody", "TimeBody", names(extractData))
names(extractData)<-gsub("-mean()", "Mean", names(extractData), ignore.case = TRUE)
names(extractData)<-gsub("-std()", "STD", names(extractData), ignore.case = TRUE)
names(extractData)<-gsub("-freq()", "Frequency", names(extractData), ignore.case = TRUE)
names(extractData)<-gsub("angle", "Angle", names(extractData))
names(extractData)<-gsub("gravity", "Gravity", names(extractData))
```

# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Set the subject variable in the data as a factor
```
extractData$Subject <- as.factor(extractData$Subject)
extractData <- data.table(extractData)
```

Create tidycleanedData as a data set with average for each activity and subject.  
```
tidycleanedData <- aggregate(. ~Subject + Activity, extractData, mean)
```
Arrange the entries in tidycleanedData
```
tidycleanedData <- tidycleanedData[order(tidycleanedData$Subject,tidycleanedData$Activity),]
```
Write tidycleanedData into a text file (tidy_dataset.txt)
```
write.table(tidycleanedData, file = "tidy_dataset.txt", row.names = FALSE)
```
