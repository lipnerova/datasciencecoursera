
# Readme

This repository includes all files created for the 'Getting and Cleaning Data Course Project' assignment of 
the The Johns Hopkins University **Data Science Specialization** courses on Coursera.


## Goal

Tidy up data collected from the accelerometers of Samsung Galaxy S smartphone. 

##### 1. Filter the raw data
+ Merge training & data sets
+ Keep only mean & standard deviation for each measurement

##### 2. Use descriptive names
+ Use descriptive names for the activities in the dataset

##### 3. Create overview subset
+ Create a second dataset with the average of each variable for each activity and each subject
+ Use rules #2


## Sources

Tha data comes from the publicly available [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/index.html). 

+ a full description of the study can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
+ raw data can be downloaded from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


## Files

This repository includes the following files:

+ README.md
+ run_analysis.R: script that tidy up the raw data into a clean, ready to use dataset. see 'Data Analysis' below for more info.
+ CodeBook.md: describes all the variables, the data, and any transformations or work performed to clean up the data.

The **featureInfo** directory includes:

+ activity_label.txt: link between id & label for each of the six measured activities
+ features.txt: the list of all 561 features measured during the experiments 
+ features_info.txt: the decription of each feature. A cleaner description is available in the CodeBook.md

*Note: the raw data is not included in the repository. The download link can be found in 'Sources'.*


## Data Analysis

_Note: for a better understanding of data, please refer to the **Code Book**._

The script included in **run_analysis.R** tidy up the data with the following steps:

#### 0. Download & unzip source files

+ We download & unzip the source files in the '.\data' directory

#### 1. Identify the features to keep

+ We load 'features.txt', which indicates the index & label of each of the 561 features.
+ We apply `grep` to return a 1\*561 vector of TRUE/FALSE values: does the feature label include mean() or std() ?
+ We use this vector to:
  + create a character vector that includes every label we keep
  + identify which columns we load in step.2
	
*Note: we use mean() instead of mean to exclude meanFreq() from our loaded data.*
	
	
#### 2. Load both training & test sets

We apply the same method for both datasets:

+ We load 'X_dataset.txt', with only its relevant columns (faster than dropping unwanted columns afterwards)
+ We load 'y_dataset.txt' & 'subject_dataset.txt'
+ We merge the three datasets using `cbind`


#### 3. Merge the two sets, rename columns, add activity names

+ We merge test set & training set using `rbind`
+ We apply the character vector created in step.1 to the columns names
+ We load 'activity_labels.txt', which indicate the index & label of each of the 6 activities
+ We merge the activity_labels & our complete dataset using `merge`

The **fullSet** dataframe is now ready to use. 

*Note:* 
+ *we do not forget to append names for the columns that appeared during the merge.*
+ *we drop all the temporary files to tidy our dataspace.*


#### 4. Create a dataframe with the average of each variable for each activity and each subject 

We use the reshape2 library to create the new dataframe from our fullSet:

+ We `melt` all our fullSet variables, except the subjects & activities
+ We calculate the variables means for each couple subject/activity using `dcast`

The **fullSetAvg** dataframe is now ready to use. 


