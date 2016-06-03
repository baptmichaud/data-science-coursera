# Getting and Cleaning Data - Course Project

Welcome to my Course Project repository for the Getting and Cleaning Data Course on Coursera.

This repository contains 2 files:

* __run_analysis.R__ : an R script that transform a messy data set into a tidy dataset
* __CodeBook.md__ : a code book that describes the variables, the data, and any transformations or work that i performed to clean up the data into the **run_analysis.R** file
* __tidy_data.txt__ : the result of the run_analysis.R script

__Open the Code Book to know the variables and the process__

## Purpose of this analysis

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . 
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained: [Go to UCI website](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)


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

Requirement 1) The first step is to merge the test sets and train sets

```javascript
testingData <- cbind(x_test, subject_test, y_test)
trainingData <- cbind(x_train, subject_train, y_train)
allData <- rbind(trainingData, testingData)
```

Requirement 2) Extracts only the measurements on the mean and standard deviation for each measurement + subjectID (562) and activityID (563)

```javascript
featuresWanted <- c(grep("mean|std", features$feature))
columnsWanted <- c(featuresWanted, 562, 563)
# Filter the data
allData <- allData[,columnsWanted]
```

Requirement 3) Uses descriptive activity names to name the activities in the data set

```javascript
allData <- merge(allData, activity_label, by.x="activityID", by.y="ID")
```

Requirement 4) Appropriately labels the data set with descriptive variable names.

```javascript
colnames(allData) <- c("activityID", features[featuresWanted, "feature"], "subjectID", "activity")
```

Requirement 5) From the data set in step 4, creates a second, independent  tidy data set with the average of each variable for each activity and each subject

```javascript
id_labels <- c("subjectID", "activityID", "activity")
measures <- setdiff(colnames(allData), id_labels)
# Melt the data by subject and activity
meltedData <- melt(allData, id = id_labels, measure_labels = measures)
# Compute the mean
tidy_data <- dcast(meltedData, subjectID + activity ~ variable, mean)
# Save the data
write.table(tidy_data, file = "./tidy_data.txt")
```
