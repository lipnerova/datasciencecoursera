
# Code Book

This code book aims to describe all the variables, the data, and any transformations or work performed to clean up the data. 


## Study

*Note: This paragraph is based on the study readme.md file.*

The raw data comes from the recordings of 30 subjects performing activities of daily living (ADL) 
while carrying a waist-mounted smartphone (Samsung Galaxy S II) with embedded inertial sensors.

+ **Age bracket:** [19-48 years]
+ **Activities:** 
  + walking
  + walking upstairs
  + walking downstairs
  + sitting
  + standing
  + laying
+ **Activities classification:** manual from video recordings
+ **Sensors:** embedded accelerometer & gyroscope
+ **Measurements:**
  + 3-axial linear acceleration
  + 3-axial angular velocity

The obtained dataset has been randomly partitioned into two sets:
+ **training data:** 70% of the volunteers
+ **test data:** 30% of the volunteers

## Raw Data Overview

There are several files for each dataset, each with the same number of records (one per window sample). They must be grouped to have the complete picture.

+ **subject_dataset.txt:** subject who performed the activity for each window sample. *Its range is from 1 to 30.*
+ **y_dataset.txt:** activity performed for each window sample. *Its range is from 1 to 6.*
+ **X_dataset.txt:** a 561-feature vector with time and frequency domain variables.

Raw Measurements are also available in the Inertial Signals/ folder, but we will not use them:

+ **total_acc_axis_dataset.txt:** The acceleration signal from the accelerometer axis. *In standard gravity units 'g'.*
+ **body_acc_axis_dataset.txt:**  The body acceleration signal (total acceleration minus gravity).
+ **body_gyro_axis_dataset.txt:** The angular velocity from the gyroscope axis. *In radians/second.*

*Note: for inertial signals, there is one file for each axis X, Y, Z. In these files, each row is a 128-feature vector.*


## Focus on the 561-feature vector

All the features come from the accelerometer and gyroscope 3-axial raw signals, captured at a constant rate of 50 Hz.


#### Time Domain Signals: 5\*40 + 5\*13 = 265 features

These **raw signals** have been:
+ filtered to remove noise
+ for the acceleration, filtered again to split body and gravity acceleration signals
+ for the body linear acceleration and angular velocity, derived in time to obtain Jerk signals

This results in the following **three-dimensional time domain signals**:

+ tBodyAcc-XYZ
+ tGravityAcc-XYZ
+ tBodyAccJerk-XYZ
+ tBodyGyro-XYZ
+ tBodyGyroJerk-XYZ

Then the **magnitude** of these three-dimensional signals were calculated using the Euclidean norm:

+ tBodyAccMag
+ tGravityAccMag
+ tBodyAccJerkMag
+ tBodyGyroMag
+ tBodyGyroJerkMag

For each of these time signals, the following set of **variables** have been estimated:


Variable      | XYZ | Mag | Description
------------- | --: | --: | :----------------------------------------------------------------------------
mean()        |  3  |  1  | Mean value
std()         |  3  |  1  | Standard deviation
mad()         |  3  |  1  | Median absolute deviation 
max()         |  3  |  1  | Largest value in array
min()         |  3  |  1  | Smallest value in array
sma()         |  1  |  1  | Signal magnitude area
energy()      |  3  |  1  | Energy measure. Sum of the squares divided by the number of values
iqr()         |  3  |  1  | Interquartile range 
entropy()     |  3  |  1  | Signal entropy
arCoeff()     | 12  |  4  | Autorregresion coefficients with Burg order equal to 4
correlation() |  3  |  -  | Correlation coefficient between two signals (XY, XZ, YZ)
**Total**     | **40** | **13**  | **_Total number of features for each signal (XYZ - Mag)_**

*Note:*
+ *XYZ=3 means there is one value per axis, except for the correlation: there is one value for XY, one for XZ and one for YZ*
+ *XYZ=12 means there are 4 coefficients per axis*


#### Frequency Domain Signals: 3\*79 + 4\*13 = 289 features

A Fast Fourier Transform (FFT) was applied to some of these signals, producing **frequency domain signals**:

+ fBodyAcc-XYZ
+ fBodyAccJerk-XYZ
+ fBodyGyro-XYZ
+ fBodyAccMag
+ fBodyAccJerkMag
+ fBodyGyroMag
+ fBodyGyroJerkMag

For each of these time signals, the following set of **variables** have been estimated:

Variable      | XYZ | Mag | Description
------------- | --: | --: | :----------------------------------------------------------------------------
mean()        |  3  |  1  | Mean value
std()         |  3  |  1  | Standard deviation
mad()         |  3  |  1  | Median absolute deviation 
max()         |  3  |  1  | Largest value in array
min()         |  3  |  1  | Smallest value in array
sma()         |  1  |  1  | Signal magnitude area
energy()      |  3  |  1  | Energy measure. Sum of the squares divided by the number of values. 
iqr()         |  3  |  1  | Interquartile range 
entropy()     |  3  |  1  | Signal entropy
maxInds()     |  3  |  1  | Index of the frequency component with largest magnitude
meanFreq()    |  3  |  1  | Weighted average of the frequency components to obtain a mean frequency
skewness()    |  3  |  1  | Skewness of the frequency domain signal 
kurtosis()    |  3  |  1  | Kurtosis of the frequency domain signal 
bandsEnergy() | 42  |  -  | Energy of a frequency interval within the 64 bins of the FFT of each window
**Total** | **79**  | **13**  | **_Total number of features for each signal (XYZ - Mag)_**
							
*Note: XYZ=3 means there is one value per axis*


#### Additional Angle Features: 7\*1 = 7 features

Additional vectors were obtained by averaging the signals in a signal window sample. These are used to measure **angles with gravityMean**:

+ tBodyAccMean
+ tBodyAccJerkMean
+ tBodyGyroMean
+ tBodyGyroJerkMean
+ X, ,Y, Z

Variable      |  -  | Description
------------- | --: | :---------------------------------------------------------------------------
angle()       |  1  | Angle between two vectors.
**Total** |  **1**  |**_Total number of features_**


