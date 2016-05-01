getwd()
setwd("C:/Users/reneel/Documents/DataScience Module/Module3/UCI HAR Dataset")
#source: the zip file https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

features<- read.table("features.txt")
activity<- read.table("activity_labels.txt", header = FALSE)

#Read train data
Subject_Train <- read.table("train/subject_train.txt", header = FALSE)
Activity_YTrain <- read.table("train/y_train.txt", header = FALSE)
Feature_XTrain <- read.table("train/X_train.txt", header = FALSE)

#Read test data
Subject_Test <- read.table("test/subject_test.txt", header = FALSE)
Activity_YTest <- read.table("test/y_test.txt", header = FALSE)
Feature_XTest <- read.table("test/X_test.txt", header = FALSE)

#Q1- Merge the training and the test sets to create one data set

Subject<- rbind(Subject_Train, Subject_Test)
Activities<- rbind(Activity_YTrain, Activity_YTest)
Features<- rbind(Feature_XTrain, Feature_XTest)

#Name the column 
colnames(Features) <- t(features[2])

#Add column activity and subject 
colnames(Activities) <- "Activity"
colnames(Subject) <- "Subject"

cleanedData <- cbind(Features,Activities,Subject)

#Q2- Extracts only the measurements on the mean and standard deviation for each measurement
measure_mean_std <- grep(".*Mean.*|.*Std.*", names(cleanedData), ignore.case=TRUE)

#Activity and subject columns
Act_sub_column <- c(measure_mean_std, 562, 563)

extractData<- cleanedData[,Act_sub_column]


#Q3- Uses descriptive activity names to name the activities in the data set

extractData$Activity <- as.character(extractData$Activity)
for (i in 1:6){
  extractData$Activity[extractData$Activity == i] <- as.character(activity[i,2])
}

#Set the activity variable in the data as a factor
extractData$Activity<- as.factor(extractData$Activity)


#Q4- Appropriately labels the data set with descriptive variable names. 

#Acc can be replaced with Accelerometer
#Gyro can be replaced with Gyroscope
#BodyBody can be replaced with Body
#Mag can be replaced with Magnitude
#Character 'f' can be replaced with Frequency
#Character 't' can be replaced with Time

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


#Q5- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Set the subject variable in the data as a factor

extractData$Subject <- as.factor(extractData$Subject)
extractData <- data.table(extractData)

#tidycleanedData as a set with average for each activity and subject
tidycleanedData <- aggregate(. ~Subject + Activity, extractData, mean)

#Order tidycleanedData according to subject and activity
tidycleanedData <- tidycleanedData[order(tidycleanedData$Subject,tidycleanedData$Activity),]

#Write tidycleanedData into a text file
write.table(tidycleanedData, file = "tidy_dataset.txt", row.names = FALSE)
