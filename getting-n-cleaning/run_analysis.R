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