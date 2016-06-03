# Code book

## Purpose

The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. 

The goal is to prepare tidy data that can be used for later analysis

The data set can be downloaded [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The output result is a file called __tidy_data.txt__

## Data and Variables description

### The dataset

The dataset used is called __Human Activity Recognition Using Smartphones Dataset__

I have used the version 1.0 of this dataset during this analysis.

Author comment:
> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
> Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 
> Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
> The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window).
> The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. 
> The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 
> For each record it is provided:
> - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
> - Triaxial Angular velocity from the gyroscope. 
> - A 561-feature vector with time and frequency domain variables. 
> - Its activity label. 
> - An identifier of the subject who carried out the experiment.

The dataset includes the following files

| File | Description |
| ---- | ----------- | 
| features_info.txt | Shows information about the variables used on the feature vector. |
| features.txt | List of all 561 features |
| activity_labels.txt | Links the class labels with their activity name |
| train/X_train.txt | Training set |
| train/y_train.txt | Training labels |
| train/subject_train.txt | Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30 |
| test/X_test.txt | Test set |
| test/y_test.txt | Test labels |
| test/subject_test.txt | Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30 |
| test/Inertial Signals/total_acc_x_test.txt | The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis |
| test/Inertial Signals/body_acc_x_test.txt | The body acceleration signal obtained by subtracting the gravity from the total acceleration |
| test/Inertial Signals/body_gyro_x_test.txt | The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second |
| train/Inertial Signals/total_acc_x_train.txt | The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis |
| train/Inertial Signals/body_acc_x_train.txt | The body acceleration signal obtained by subtracting the gravity from the total acceleration |
| train/Inertial Signals/body_gyro_x_train.txt | The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second |

_The Inertial Signals will not be used._

## Variables

Below, the description of all variables used in the run_analysis.R script:

| Variable | Description | Type |
| -------- | ----------- | ---- |
| datasetUrl | URL used to download the dataset | character |
| datasetZip | File path to save the dataset downloaded | character |
| activity_label | Data frame containing the activity extracted from the file 'activity_labels.txt' | Data Frame |
| features | Data frame containing the features extracted from the file 'features.txt' | Data Frame |
| x_test | Data frame containing the data extracted from the file 'x_test.txt' | Data Frame |
| subject_test | Data frame containing the data extracted from the file 'subject_test.txt | Data Frame |
| y_test | Data frame containing the data extracted from the file 'y_test.txt' | Data Frame |
| testingData | Data frame containing the merge of x_test, subject_test and y_test Data Frame | Data Frame |
| x_train | Data frame containing the data extracted from the file 'x_train.txt' | Data Frame |
| subject_train | Data frame containing the data extracted from the file 'subject_train.txt | Data Frame |
| y_train | Data frame containing the data extracted from the file 'y_train.txt' | Data Frame |
| trainingData | Data frame containing the merge of x_train, subject_train and y_train Data Frame | Data Frame |
| allData | Data Frame containing the merge of testingData and trainingData filtered by the variable columnsWanted | Data Frame |
| featuresWanted | Vector of all features Index that we want to keep (based on the regex 'mean|std') | Vector(int) |
| columnsWanted | Vector of all columns Index that we want to keep | Vector(num) |
| id_labels | Vector of all columns containing the Observation ID (subjectID, activityID, activity) | Vector(char) |
| measures | Vector of all variables measured (total:79) | Vector(char) |
| meltedData | Result of the melt between id_labels and measures variables | Data Frame |
| tidy_data | Tidy data set containing the cast of the molten Data Frame (meltedData) | Data Frame |

### Notes

Features are normalized and bounded within [-1,1].

Each feature vector is a row on the text file.

### References & Licence

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
