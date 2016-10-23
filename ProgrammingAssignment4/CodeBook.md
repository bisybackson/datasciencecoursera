---
title: "UCI HAR Code book"
author: "Deon Erasmus"
date: "2016-10-23"
output:
  html_document:
    keep_md: yes
---

## Project Description
Abstract: Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

The purpose of this project is to demonstrate ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

##Study design and data processing
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

###Collection of the raw data
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.

###Notes on the original (raw) data 
The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

##Creating the tidy datafile
From the assignment instructions, the data should be prepared as such:

You should create one R script called run_analysis.R that does the following.

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###Guide to create the tidy data file
The approach and packages selected for this assignment was made for memory and processing efficiency. The data.table package is used to read data, and as far as possible, data was added to existing objects instead of the load/merge approach which creates redundant objects.

The tidy dataset is created and exported in a tall and skinny manner, with 'fixed' variables in the first two columns, followed by the averages of the extracted means and standard deviations.

Column names are not normalised beyond removing non-alphanumeric characters present, and dropping case to lower. Further expansion of names to more descriptive ones would have resulted in long, unwieldy names.

###Assumptions
* Initial file path is specified to be "~/DataScienceCoursera". A "rawdata" subdirectory is created herein.
* Since inertial data is not part of tidy dataset to be produced, this is not imported.
* We are treating the activity names as variables, and as such the literals are read in as factors from the data and not reformatted in any way.
* We assumed to *any* columns containing [Mm]ean or std are required for the resultant dataset. This is the safe and conservative approach - subsequent analysts may drop variables that are not required.

###The steps to prepare the tidy data set are as follows:

- Prepare the environment by loading dplyr and data.table packages. Data.table makes processing much faster, and dplyr is required for selecting and summarising required data.
- Download and extract the dataset to location specified by 'filepath'
- Load the metadata (labels for activity and features) from text files into variables
- Read the test and training datasets into data.table objects
- Set column names according to features.txt
- Add columns containing subject ID and activity performed
- Merge test and training data
- Replace activity values with descriptive label
- Extract only columns containing "[Mm]ean" or "std" in the header
- Summarise dataset for all features by activity and subject

###Description of the features in the dataset

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of (quoted) variables of the resultant tidy dataset are:

"activity"
"subject"
"tbodyaccmeanx"
"tbodyaccmeany"
"tbodyaccmeanz"
"tbodyaccstdx"
"tbodyaccstdy"
"tbodyaccstdz"
"tgravityaccmeanx"
"tgravityaccmeany"
"tgravityaccmeanz"
"tgravityaccstdx"
"tgravityaccstdy"
"tgravityaccstdz"
"tbodyaccjerkmeanx"
"tbodyaccjerkmeany"
"tbodyaccjerkmeanz"
"tbodyaccjerkstdx"
"tbodyaccjerkstdy"
"tbodyaccjerkstdz"
"tbodygyromeanx"
"tbodygyromeany"
"tbodygyromeanz"
"tbodygyrostdx"
"tbodygyrostdy"
"tbodygyrostdz"
"tbodygyrojerkmeanx"
"tbodygyrojerkmeany"
"tbodygyrojerkmeanz"
"tbodygyrojerkstdx"
"tbodygyrojerkstdy"
"tbodygyrojerkstdz"
"tbodyaccmagmean"
"tbodyaccmagstd"
"tgravityaccmagmean"
"tgravityaccmagstd"
"tbodyaccjerkmagmean"
"tbodyaccjerkmagstd"
"tbodygyromagmean"
"tbodygyromagstd"
"tbodygyrojerkmagmean"
"tbodygyrojerkmagstd"
"fbodyaccmeanx"
"fbodyaccmeany"
"fbodyaccmeanz"
"fbodyaccstdx"
"fbodyaccstdy"
"fbodyaccstdz"
"fbodyaccmeanfreqx"
"fbodyaccmeanfreqy"
"fbodyaccmeanfreqz"
"fbodyaccjerkmeanx"
"fbodyaccjerkmeany"
"fbodyaccjerkmeanz"
"fbodyaccjerkstdx"
"fbodyaccjerkstdy"
"fbodyaccjerkstdz"
"fbodyaccjerkmeanfreqx"
"fbodyaccjerkmeanfreqy"
"fbodyaccjerkmeanfreqz"
"fbodygyromeanx"
"fbodygyromeany"
"fbodygyromeanz"
"fbodygyrostdx"
"fbodygyrostdy"
"fbodygyrostdz"
"fbodygyromeanfreqx"
"fbodygyromeanfreqy"
"fbodygyromeanfreqz"
"fbodyaccmagmean"
"fbodyaccmagstd"
"fbodyaccmagmeanfreq"
"fbodybodyaccjerkmagmean"
"fbodybodyaccjerkmagstd"
"fbodybodyaccjerkmagmeanfreq"
"fbodybodygyromagmean"
"fbodybodygyromagstd"
"fbodybodygyromagmeanfreq"
"fbodybodygyrojerkmagmean"
"fbodybodygyrojerkmagstd"
"fbodybodygyrojerkmagmeanfreq"
"angletbodyaccmeangravity"
"angletbodyaccjerkmeangravitymean"
"angletbodygyromeangravitymean"
"angletbodygyrojerkmeangravitymean"
"anglexgravitymean"
"angleygravitymean"
"anglezgravitymean"

##Sources and acknowledgements
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/