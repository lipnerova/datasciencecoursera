
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

## Raw Data

##### Overview

There are several files for each dataset, each with the same number of records (one per window sample). They must be grouped to have the complete picture.

+ **subject_dataset.txt:** subject who performed the activity for each window sample. *Its range is from 1 to 30.*
+ **y_dataset.txt:** activity performed for each window sample. *Its range is from 1 to 6.*
+ **X_dataset.txt:** a 561-feature vector with time and frequency domain variables.

Raw Measurements are also available in the Inertial Signals/ folder, but we will not use them:

+ **total_acc_axis_dataset.txt:** The acceleration signal from the accelerometer axis. *In standard gravity units 'g'.*
+ **body_acc_axis_dataset.txt:**  The body acceleration signal (total acceleration minus gravity).
+ **body_gyro_axis_dataset.txt:** The angular velocity from the gyroscope axis. *In radians/second.*

*Note: for inertial signals, there is one file for each axis X, Y, Z. In these files, each row is a 128-feature vector.*


##### Focus on the 561-feature vector

Name | Lunch order | Spicy      | Owes
------- | ---------------- | ---------- | ---------:
Joan  | saag paneer | medium | $11
Sally  | vindaloo        | mild       | $14
Erin   | lamb madras | HOT      | $5

