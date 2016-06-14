#### This file will describe How the run_Analysis.R is works.

##### 1. Download and extract data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip into current working directory.
```
dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataUrl,destfile = "projectdata.zip")
unzip("projectdata.zip")
```

##### 2. Load the testing data sets into different variables
```
dfSubjectTest <- fread("./UCI HAR Dataset/test/subject_test.txt")
dfTest <- fread("./UCI HAR Dataset/test/X_test.txt", sep = ' ')
dfActivityTest <- fread("./UCI HAR Dataset/test/Y_test.txt")
```
##### 3. Load the training datasets into different variables
```
dfSubjectTrain <- fread("./UCI HAR Dataset/train/subject_train.txt")
dfTrain <- fread("./UCI HAR Dataset/train/X_train.txt", sep = ' ')
dfActivityTrain<- fread("./UCI HAR Dataset/train/Y_train.txt")
```
##### 4. Merge the subject test and subject train data sets created in above step
```
dfSubjectAll <- rbind(dfSubjectTest,dfSubjectTest)
setnames(dfSubjectAll,"V1","subject")
```
##### 5. Merge the activity train and activity test data
```
dfActivityAll <- rbind(dfActivityTest,dfActivityTrain)
setnames(dfActivityAll,"V1","activityNum")
```
##### 6. Merge Test (i.e. X_test and X_train) and Train data
```
dtAll <- rbind(dfTest,dfTrain)

dfSubjectAll <- cbind(dfSubjectAll,dfActivityAll)
dtAll <- cbind(dfSubjectAll,dtAll)
setkey(dtAll,subject,activityNum)
```
##### 7. Add column header to above data set
```
dfFeatures <- fread("./UCI HAR Dataset/features.txt")
setnames(dfFeatures,names(dfFeatures),c("featureId","featureName"))
```
##### 8.Select only those measurement from features which are for mean and std
```
dfSelectedFeatures <- dfFeatures[grepl("(mean|std)\\(\\)",featureName)]
```
##### 9.Now select these columns
```
library(dplyr)
dtAll <- select(dtAll,dfSelectedFeatures$featureId)
```
######Assign column names which are selected 
```
colnames(dtAll) <- dfSelectedFeatures$featureName
```
##### 10. Merge the subject and activity columns with main table i.e. dtAll
```
dfSubject_Activity_All <- cbind(dfSubjectAll,dfActivityAll)
dtAll <- cbind(dfSubject_Activity_All,dtAll)
setkey(dtAll,subjectId,activityId)
```
##### 11. Read the activity names and merge it with main table. And then convert table from wide to narrow format
```
dfActivityLables <- fread("./UCI HAR Dataset/activity_labels.txt")
setnames(dfActivityLables,names(dfActivityLables),c("activityId","activityName"))
dtAll <- merge(dtAll,dfActivityLables, by="activityId",all.x = T)
setkey(dtAll,subjectId,activityId,activityName)
```
######reshape the table
```
dtAll <- melt(dtAll,key(dtAll),variable.name = "featureName")
```
#### 12.Cleanup feature names and aggregate the data by activity, subject and features and calculate mean.
```
dtAll$featureName <- gsub('-mean',"Mean",dtAll$featureName)
dtAll$featureName <- gsub('[-()]', '', dtAll$featureName)
dtAll$featureName <- gsub('^t', 'Time', dtAll$featureName)
dtAll$featureName <- gsub('^f', 'Freq', dtAll$featureName)
dtAll$featureName <- gsub('-std', 'StdDev', dtAll$featureName)
dtAll$featureName <- gsub('-', '', dtAll$featureName)
dtAll$featureName <- gsub('BodyBody', 'Body', dtAll$featureName)

dtTidy <- aggregate(dtAll$value,by=list(activity = dtAll$activityName, subject = dtAll$subject, features = dtAll$featureName),FUN=mean)
colnames(dtTidy)[4] <- "Mean"
write.table(dtTidy,file = "tidydata.txt", row.names = FALSE)
```

