#1. Merges the training and the test sets to create one data set.
#- 'train/X_train.txt': Training set.
#- 'test/X_test.txt': Test set. 

# training and test sets
trainingSet <- read.table("./UCI HAR Dataset/train/X_train.txt")
testSet <- read.table("./UCI HAR Dataset/test/X_test.txt")
dataSet <- rbind(trainingSet,testSet)

# Features = column names
features <- read.table("./UCI HAR Dataset/features.txt")
names(dataSet) <- features[,2]

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
meanFeature <- regexpr("mean()",names(dataSet)) != -1
notMeanFreqFeature <- regexpr("meanFreq",names(dataSet)) == -1
stdFeature <- regexpr("std()",names(dataSet)) != -1
meanOrStdFeature <- (meanFeature & notMeanFreqFeature) | stdFeature
meanOrStDataSet <- dataSet[,meanOrStdFeature]

# Labels
trainingLabels <- read.table("./UCI HAR Dataset/train/y_train.txt")
testLabels <- read.table("./UCI HAR Dataset/test/y_test.txt")
labels <- rbind(trainingLabels,testLabels)

# 3. Uses descriptive activity names to name the activities in the data set
# activity_labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
indx2 <- pmatch(labels[,1],activity_labels[,1],duplicates.ok = TRUE)
labels$activityLabels <- activity_labels[indx2,2]
meanOrStDataSet$activityLabels <- labels$activityLabels

# 4. Appropriately labels the data set with descriptive variable names. 
# Already done.

# Subjects
trainingSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")
testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")
Subjects <- rbind(trainingSubjects,testSubjects)
meanOrStDataSet$Subjects <- Subjects[,1]

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(reshape2)
DataSetMelt <- melt(meanOrStDataSet, id = c("activityLabels","Subjects"))
AverageDataSet <- dcast(DataSetMelt,Subjects + activityLabels ~ variable, mean)
write.table(AverageDataSet, "AverageDataSet.txt", row.name=FALSE, quote=F)
