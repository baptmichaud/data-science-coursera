library(dplyr)
library(data.table)
library(reshape2)

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
        message("The dataset has been downloaded previously, using old files")
}

# Unzip the dataset
if(!file.exists("~/getdata-project/UCI HAR Dataset")) {
        unzip(datasetZip, exdir="~/getdata-project")
}

# Set working directory
setwd("~/getdata-project/UCI HAR Dataset")

# Load references tables
activity_label <- read.table("activity_labels.txt", sep=" ", col.names=c("ID", "variable"), stringsAsFactors = FALSE)
features <- read.table("features.txt", sep=" ", col.names=c("ID", "feature"), stringsAsFactors = FALSE)

# Load test data
x_test <- read.table("test/X_test.txt")

# Map Subject to test set
subject_test <- read.table("test/subject_test.txt", col.names="subjectID")
y_test <- read.table("test/y_test.txt", col.names="activityID")
testingData <- cbind(x_test, subject_test, y_test)

# Load train data
x_train <- read.table("train/X_train.txt")

# Map subjects to train set
subject_train <- read.table("train/subject_train.txt", col.names="subjectID")
y_train <- read.table("train/y_train.txt", col.names = "activityID")
trainingData <- cbind(x_train, subject_train, y_train)

# Requirement 1) 
# Merge the two datasets with dplyr
allData <- rbind(trainingData, testingData)

# Req 2) Extracts only the measurements on the mean and standard deviation 
#        for each measurement + subjectID (562) and activityID (563)
featuresWanted <- c(grep("mean|std", features$feature))
columnsWanted <- c(featuresWanted, 562, 563)

# Filter the data
allData <- allData[,columnsWanted]

# Req 3) Uses descriptive activity names 
#        to name the activities in the data set
allData <- merge(allData, activity_label, by.x="activityID", by.y="ID")

# Req 4) Appropriately labels the data set with descriptive variable names.
colnames(allData) <- c("activityID", features[featuresWanted, "feature"], "subjectID", "activity")

# Req 5) From the data set in step 4, creates a second, independent 
#        tidy data set with the average of each variable 
#        for each activity and each subject
id_labels <- c("subjectID", "activityID", "activity")
measures <- setdiff(colnames(allData), id_labels)

# Melt the data by subject and activity
meltedData <- melt(allData, id = id_labels, measure_labels = measures)

# Compute the mean
tidy_data <- dcast(meltedData, subjectID + activity ~ variable, mean)

# Save the data
write.table(tidy_data, file = "./tidy_data.txt")