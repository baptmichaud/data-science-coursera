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

# Load all files to analyze them
activity_label <- read.table("activity_labels.txt", sep=" ", col.names=c("ID", "Variable"), stringsAsFactors = FALSE)
features <- read.table("features.txt", sep=" ", col.names=c("ID", "Feature"), stringsAsFactors = FALSE)
subject_test <- read.table("test/subject_test.txt", col.names="SubjectID")
subject_train <- read.table("train/subject_train.txt", col.names="SubjectID")

# Load tests sets and rename the variables
x_test <- read.table("test/X_test.txt", stringsAsFactors = FALSE)
names(x_test) <- features[, "Feature"]
y_test <- read.table("test/y_test.txt")

# Load train sets and rename the variables
x_train <- read.table("train/X_train.txt", stringsAsFactors = FALSE)
names(x_train) <- features[, "Feature"]
y_train <- read.table("train/y_train.txt")

