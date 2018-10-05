# Code Book for tidy_data.txt

## Dataset Description
This project summarizes data on Human Activity Recognition Using Smartphones Data Set, made publicly availble through the UCI Machine Learning Repository.
More information on the dataset can be found at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Tidy_Data contains 180 observations and 82 variables. There is one record per subject number and activity type. 

The first two variables contain identifying information about the records: 

- SubjectNumber takes the values of 1:30. There are 6 records per SubjectNumber
- Activity_Type consists of six different types of activites: walking, walking upstairs, walking downstairs, sitting, standing, and laying

The remaining 79 variables contain averages by measurement. This dataset only reports on averages for features related to the mean or standard deviation of a measurement

The following measurement types appear three times. The character in the last position of the variable name indicates what direction (X, Y, or Z) the measurement was obtained. 

The prefix 't' denotes time and the measurements were captured at a constant rate of 50 Hz. 
Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz 
to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals 
(tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. : 
- tBodyAcc.mean...<XYZ> 
- tBodyAcc.std...<XYZ>
- tGravityAcc.mean...<XYZ> 
- tGravityAcc.std...<XYZ>
- tBodyAccJerk.mean...<XYZ> 
- tBodyAccJerk.std...<XYZ>
- tBodyGyro.mean...<XYZ>
- tBodyGyro.std...<XYZ>
- tBodyGyroJerk.mean...<XYZ>
- tBodyGyroJerk.std...<XYZ>

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
- tBodyAccMag.mean.. 
- tBodyAccMag.std.. 
- tGravityAccMag.mean.. 
- tGravityAccMag.std..
- tBodyAccJerkMag.mean.. 
- tBodyAccJerkMag.std.. 
- tBodyGyroMag.mean.. 
- tBodyGyroMag.std.. 
- tBodyGyroJerkMag.mean.. 
- tBodyGyroJerkMag.std.. 

Finally a Fast Fourier Transform (FFT) was applied to measurements with a prefix 'f': 
- fBodyAcc.mean...<XYZ>
- fBodyAcc.std...<XYZ>
- fBodyAcc.meanFreq...X 
- fBodyAccJerk.mean...X 
- fBodyAccJerk.std...X 
- fBodyAccJerk.meanFreq...X 
- fBodyGyro.mean...X 
- fBodyGyro.std...X 
- fBodyGyro.meanFreq...X
- fBodyAccMag.mean.. 
- fBodyAccMag.std.. 
- fBodyAccMag.meanFreq.. 
- fBodyBodyAccJerkMag.mean.. 
- fBodyBodyAccJerkMag.std.. 
- fBodyBodyAccJerkMag.meanFreq..
- fBodyBodyGyroMag.mean.. 
- fBodyBodyGyroMag.std.. 
- fBodyBodyGyroMag.meanFreq.. 
- fBodyBodyGyroJerkMag.mean.. 
- fBodyBodyGyroJerkMag.std.. 
- fBodyBodyGyroJerkMag.meanFreq..

## Data Transformation

The following steps were performed in run_analysis.R to create tidy_data.txt

- Download and unzip files into working directory
- Read in Activity Labels and Activity Feature information
- Prepare training and test data by labeling the dataset and selecting measurements of interest (those related to means and standard deviations)
- Merges the training and the test sets to create one data set.
- Create a summary dataset called tidy_data.txt that contains averages of each measurement by activity type and subject
- Uses descriptive activity names to name the activities in the data set
- Writes out the final dataset to the working directory
