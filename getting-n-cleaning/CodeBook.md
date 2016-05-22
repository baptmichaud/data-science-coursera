# Code book

## Purpose

The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis

The data set can be downloaded [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Data and Variables description

### The dataset

The dataset used is called __Human Activity Recognition Using Smartphones Dataset__
I have used the version 1.0 of this dataset during this analysis.

Author comment:
> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 
> For each record it is provided:
> - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
> - Triaxial Angular velocity from the gyroscope. 
> - A 561-feature vector with time and frequency domain variables. 
> - Its activity label. 
> - An identifier of the subject who carried out the experiment.

The dataset includes the following files
* _features_info.txt_: Shows information about the variables used on the feature vector.
* _features.txt_: List of all features.
* _activity_labels.txt_: Links the class labels with their activity name.
* _train/X_train.txt_: Training set.
* _train/y_train.txt_: Training labels.
* _train/subject_train.txt_: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
* _train/Inertial Signals/total_acc_x_train.txt_: The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
* _train/Inertial Signals/body_acc_x_train.txt_: The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
* _train/Inertial Signals/body_gyro_x_train.txt_: The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 
* _test/X_test.txt_: Test set.
* _test/y_test.txt_: Test labels.

### Notes

Features are normalized and bounded within [-1,1].
Each feature vector is a row on the text file.

### References & Licence

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.


## Why this data set is not tidy ?

_in progress_

## Transformation steps 

_in progress_

