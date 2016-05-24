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

### Notes

Features are normalized and bounded within [-1,1].

Each feature vector is a row on the text file.

### References & Licence

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

## Variables



## Dataset analysis steps

This part explains how i have analyze the dataset and how i understand it.

Firstly, we need to initialize the working directory, download the dataset and unzip it

```javascript
# Create a working folder
if(!file.exists("~/getdata-project")) { 
        dir.create("~/getdata-project") 
}

datasetUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
datasetZip <- "~/getdata-project/getdata-project.zip"

# Download the messy dataset
if(!file.exists(datasetZip)) {
        download.file(datasetUrl, destfile=datasetZip, method="libcurl", mode="wb")
        message("The dataset has been downloaded")
} else { 
        message("The dataset has been downloaded previously, using old dataset")
}

# Unzip the dataset
unzip(datasetZip, exdir="~/getdata-project")
setwd("~/getdata-project/UCI HAR Dataset")
```

We have now a unzipped messy dataset

```javascript
> list.files()
[1] "activity_labels.txt" "features.txt"        "features_info.txt"  
[4] "README.txt"          "test"                "train"              
```

---

We can now load sets and analyze their structures.

The first one is the __activity_labels.txt__ file, this is a space separated file with 6 observations and two columns: ID and Variable. 

__During this step, I have renamed the column names to something more descriptive because there is no header in the file__

```javascript
> activity_label <- read.table("activity_labels.txt", sep=" ", col.names=c("ID", "Variable"), stringsAsFactors = FALSE)
> str(activity_label)
'data.frame':	6 obs. of  2 variables:
 $ ID      : int  1 2 3 4 5 6
 $ Variable: chr  "WALKING" "WALKING_UPSTAIRS" "WALKING_DOWNSTAIRS" "SITTING" ...
> activity_label
  ID               Name
1  1            WALKING
2  2   WALKING_UPSTAIRS
3  3 WALKING_DOWNSTAIRS
4  4            SITTING
5  5           STANDING
6  6             LAYING

```

---

The next file contains the 561 features vectors name measure. 

If you analyze the head of this file, you can see that a Feature is composed by a Signal, a Variable and an Axis
At the tail of this file, you can see additional signal and another variable called angle.

Based on this small analysis, it could be interesing to tidy this data frame by splitting signal, variables and axis into different columns. 
We will do this after analysing all the files.

__this step, I have renamed the column names to something more descriptive because there is no header in the file__

```javascript
> features <- read.table("features.txt", sep=" ", col.names=c("ID", "Feature"), stringsAsFactors = FALSE)
> str(features)
'data.frame':	561 obs. of  2 variables:
 $ ID     : int  1 2 3 4 5 6 7 8 9 10 ...
 $ Feature: chr  "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z" "tBodyAcc-std()-X" 
> head(features)
  ID           Feature
1  1 tBodyAcc-mean()-X
2  2 tBodyAcc-mean()-Y
3  3 tBodyAcc-mean()-Z
4  4  tBodyAcc-std()-X
5  5  tBodyAcc-std()-Y
6  6  tBodyAcc-std()-Z
> tail(features)
     ID                              Feature
556 556 angle(tBodyAccJerkMean),gravityMean)
557 557     angle(tBodyGyroMean,gravityMean)
558 558 angle(tBodyGyroJerkMean,gravityMean)
559 559                 angle(X,gravityMean)
560 560                 angle(Y,gravityMean)
561 561                 angle(Z,gravityMean)
```

---

The train and test folders contains the same structure of files. We will check if the files contains same structure (subject_train.txt and subject_test.txt for example)

Let's begin with subject_train.txt and subject_test.txt files !
You will see that the structure is the same and contains a lot of observations and one variable which is the subject ID

```javascript
> subject_train <- read.table("train/subject_train.txt", col.names="SubjectID")
> str(subject_train)
'data.frame':	7352 obs. of  1 variable:
 $ SubjectID: int  1 1 1 1 1 1 1 1 1 1 ...
> head(subject_train)
  SubjectID
1         1
2         1
3         1
4         1
5         1
6         1
> subject_test <- read.table("test/subject_test.txt", col.names="SubjectID")
> str(subject_test)
'data.frame':	2947 obs. of  1 variable:
 $ SubjectID: int  2 2 2 2 2 2 2 2 2 2 ...
```

---

Now, lets analyze the X and Y files.

If you load the x_test.txt file, we can observe that:
* the number of observations is equal to the number of observation in subject_test.txt
* the number of variables is equal to the number of features.

__We can set the names of the variables__

```javascript
> x_test <- read.table("test/X_test.txt", stringsAsFactors = FALSE)
> str(x_test)
'data.frame':	2947 obs. of  561 variables:
 $ V1  : num  0.257 0.286 0.275 0.27 0.275 ...
 $ V2  : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
names(x_test) <- features[, "Feature"]
```

The Y file contains the activity label assigned to each observations. You can check it by using the factor() function to gets available Levels

```javascript
> y_test <- read.table("test/y_test.txt")
> str(y_test)
'data.frame':	2947 obs. of  1 variable:
 $ V1: int  5 5 5 5 5 5 5 5 5 5 ...
> factor(y_test)
...Levels: 1 2 3 4 5 6
```

The train sets have been loaded in the same way

```javascript
x_train <- read.table("train/X_train.txt", stringsAsFactors = FALSE)
names(x_train) <- features[, "Feature"]
y_train <- read.table("train/y_train.txt")
```

### We have finished to analyze the dataset. 

### Let's now transform it and create a tidy dataset!

## Transformation steps 

_in progress_

