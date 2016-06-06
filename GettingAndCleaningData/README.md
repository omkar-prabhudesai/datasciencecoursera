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
dfSelectedFeatures <- dfFeatures[grepl("mean\\(\\)|std\\(\\)",featureName)]
```
##### 9. To select the features from dtAll tables we will need to map selected feature names to columns starting with V1,V2....Vn because dtAll table contains columns with these names
```
vfeatures <- paste0("V",dfSelectedFeatures$featureId)
columns <- c(key(dtAll),vfeatures)
```
##### 10. Select the columns from step 9
```
dtAll <- select(dtAll,dfSelectedFeatures$featureId)
```
##### 11. Read acivity labes from activity_labels.txt
```
dfActivityLables <- fread("./UCI HAR Dataset/activity_labels.txt")
setnames(dfActivityLables,names(dfActivityLables),c("activityNum","activityName"))
```
##### 12. merge activities with main table i.e. dtAll 
```
dtAll <- merge(dtAll,dfActivityLables, by="activityNum",all.x = T)
setkey(dtAll,subject,activityNum,activityName)
```
##### 13. Reshape the table.
```
dtAll <- melt(dtAll,key(dtAll),variable.name = "featureId")
dtAll <- merge(dtAll , dfSelectedFeatures[, list(featureId, featureName)], by="featureId", all.x=TRUE)
```
##### 14. Do some beautification on feature names to remove (), _, -
```
dtAll$featureName <- gsub('-mean',"Mean",dtAll$featureName)
dtAll$featureName <- gsub('[-()]', '', dtAll$featureName)
dtAll$featureName <- gsub('^t', 'TimeDomain_', dtAll$featureName)
dtAll$featureName <- gsub('^f', 'FreqencyDomain_', dtAll$featureName)
dtAll$featureName <- gsub('Acc', 'Accelerometer', dtAll$featureName)
dtAll$featureName <- gsub('Gyro', 'Gyroscope', dtAll$featureName)
dtTidy <- aggregate(dtAll$value,by=list(activity = dtAll$activityName, subject = dtAll$subject),FUN=mean)
colnames(dtTidy)[3] <- "Mean"
```
##### 15. Write the tidy dataset
```
write.table(dtTidy,file = "tidydata.txt", row.names = FALSE)
```

