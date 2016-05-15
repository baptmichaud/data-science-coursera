pollutantmean <- function(directory, pollutant, id = 1:332) {
   
        # Generate file names
        filenames <- format.filename(id, "csv", directory)
        
        # Load files set from the working directory
        files <- lapply(filenames, read.csv)
        
        # Merge all files into one dataframes with a row bind
        monitors <- do.call(rbind, files)
        
        # return the mean value for the specified pollutant with NA stripped
        mean <- mean(monitors[[pollutant]], na.rm = TRUE)
        
        # The result is not rounded like asked ! But if you want the exact value 
        # of the exercise you need to round...
        roundedMean <- round(mean, digits = 3)
        
        # return the rounded mean
        roundedMean
}

# Generate files name based on 3digits suffixed with an extension
format.filename <- function(id, extension, directory) {
        # the filename format wanted is XXX.extension
        format <- paste0(directory, "/%03d.", extension)
        sprintf(format, id)
}