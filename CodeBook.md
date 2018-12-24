# Code Book

The following describes the datasets manipulated by C3Script.R, and the output datasets achieved by running this code.

The original data represents data collected from the accelerometers from the Samsung Galaxy S smartphone.  This is considered raw data.


## Raw Data

The raw data was broke down into training and test datasets.  Each of these consisted of:
- a list of subject identifiers ('subjects');
- a list of activity identifiers ('activity IDs');
- a list of readings taken from the subjects while performing the activities represented by the activity IDs ('readings').

As these datasets had the same number of rows, it was assumed that the data could be matched up by rows.

Separate to these were:
- a dataset matching identifiers for the six values of activity IDs, to descriptions of the activities they represent ('activities').
These were the activities the subjects were performing while the data was being collected;
- a dataset describing the quantities measured ('features').

The readings described in 'features' are described in the appendix of this document.


## Transformations

The following transformations were applied to the raw datasets to create the tidy datasets, and can be attributed to the following lines of the R script:
- The subjects, activity IDs, and readings were concatenated into training and test datasets.  The features dataset was used to label the columns of these.  (Lines 7-34.)
- The resulting training and test datasets, having the same number of columns, were appended to each other.  
Note that the above step had already differentiated those in the training set and those in the test set in its 'observation number' column.  
(Lines 36-37.)
- The readings which were means and standard deviations of the quantities measured only were isolated.  
(This ignored those that were mean frequency calculations.)  (Lines 39-44.)
- The activities table was used to replace the activity IDs, to aid comprehension.  (Lines 46-53.)
- The original column headings were replaced by more descriptive titles.  
These are explained in the 'tidy data' section of this document.  (Lines 55-126.)

This created the 'results_by_record' dataset, which preserves the individual measurements.  To translate to the 'results_by_subject_and_activity' dataset, the following transformations were applied to results_by_record:
- The columns were averaged by subject ID and activity, removing the observation number column.  
This included the standard deviation columns, due to lack of clarity in the original task description.  
These can easily by removed if so desired.  (Lines 128-134.)
- The columns were renamed, to have 'average_' added to each one, to aid comprehension.  (Lines 136-142.)

The results_by_subject_and_activity is then output into text format in lines 144-145.


## Tidy Data

There are two tidy datasets: results_by_record summarises the data by observation, while results_by_subject_and_activity summarises the data by subject and activity.  The latter is submitted for the purposes of this assignment.

The tidy data is named to aid comprehension.  The column titles (subject ID and activity aside) follow the following rules:
- starting with 'average' to denote the final step in the transformations above;
- followed by the tool used to take the measurement: body accelerometer, gravity accelerometer, or gyroscope;
- if the reading was a Jerk signal, this then follows in the column name;
- identification of whether this was a time domain signal, or whether a fast Fourier transform ('FFT') was applied;
- the direction of measurement (X Y or Z, or whether the overall magnitude was measured instead;
- finally, whether this is the average of the observation means or standard deviations.



### Appendix

Below, some information is provided on the raw data.  The information has been copied from the original documentation.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

- mean(): Mean value
- std(): Standard deviation
(Other data was omitted.)
