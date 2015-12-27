library(data.table)
##Download and extract the data from URL
dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataUrl,destfile = "projectdata.zip")
unzip("projectdata.zip")

##Load test data set into different tables
df_subj_test <- fread("./UCI HAR Dataset/test/subject_test.txt")
df_X_test <- fread("./UCI HAR Dataset/test/X_test.txt", sep = ' ')
df_Y_test <- fread("./UCI HAR Dataset/test/Y_test.txt")

##Load the training data into different tables
df_subj_train <- fread("./UCI HAR Dataset/train/subject_train.txt")
df_X_train <- fread("./UCI HAR Dataset/train/X_train.txt", sep = ' ')
df_Y_train <- fread("./UCI HAR Dataset/train/Y_train.txt")

##Merge the X test and X train data sets created in above step
df_X_all <- rbind(df_X_test,df_X_train)

## Add column header to above data set
df_features <- fread("./UCI HAR Dataset/features.txt")
df_activity <- fread("./UCI HAR Dataset/activity_labels.txt")
colnames(df_features) <- c("feature id","feature")
colnames(df_activity)<-c("activity id","activity")
colnames(df_X_all) <- df_features$feature

## Select ONLY columns which are mean, standard dev
library(dplyr)
mainTable <- select(df_X_all,matches("mean|std"))
##Bind the subject and activity column
df_subj_all <- rbind(df_subj_test,df_subj_train)
df_Y_all <- rbind(df_Y_test,df_Y_train)
colnames(df_Y_all)[1] <- "activity id"
df_Y_all <- merge(df_Y_all,df_activity, by = "activity id")

mainTable <- cbind(df_subj_all,df_Y_all$activity,mainTable)
colnames(mainTable)[1] <- "subjetc id"
colnames(mainTable)[2] <- "activity type"

write.table(mainTable,file = "tidydata.txt", row.names = FALSE)
