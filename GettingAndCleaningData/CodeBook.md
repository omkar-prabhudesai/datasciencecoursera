##Codebook for project Smart Phone Data Analysis
#### 1. Link to download dataset
     http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#### 2. Activities and Subjects
  *The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Total 6 activities were
  under consideration for this experiment.* 
  Subject - Integer identifier for volunteer.  
  Activities -
      1. WALKING  
      2. WALKING_UPSTAIRS  
      3. WALKING_DOWNSTAIRS  
      4. SITTING  
      5. STANDING  
      6. LAYING  
  **wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
  The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.**

#### 3. Mean and standard deviation
**Original data captured has 561 different feature vectors. For this study, I have selected only 66 features which are related to Mean and Standard Deviation. 
Features are renamed so that they can be easily understood (see below table). Unwanted -, (), _ are removed from feature names. units of features are kept same.**

Original Name | Tidy data set name
------------- | -------------
Subject | Subject
Activity  | Activity
tBodyAcc-mean()-XYZ | TimeBodyAccMeanXYZ
tBodyAcc-std()-XYZ |TimeBodyAccStdDevXYZ
tGravityAcc-mean()-XYZ |TimeGravityAccMeanXYZ
tGravityAcc-std()-XYZ|TimeGravityAccStdDevXYZ
tBodyAccJerk-mean()-XYZ|TimeBodyAccJerkMeanXYZ
fBodyAcc-mean()-XYZ|FreqBodyAccMeanXYZ
fBodyAccJerk-mean()-XYZ|FreqBodyAccJerkMeanXYZ
fBodyBodyGyroMag-mean() | FreqbodyGyroMagMean
