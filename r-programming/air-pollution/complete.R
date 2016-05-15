complete <- function(directory, id = 1:332) {
        
        # Nested function to compute nobs and fill the result dataframe
        compute.nobs <- function(file) {
                
                # nobs is equal to the total number of line with sulfate 
                # & nitrate != NA
                computed.nobs <- sum(complete.cases(file))
                computed.nobs
        } 

        # Generate file names
        filenames <- format.filename(id, "csv", directory)
        
        # Load files set from the working directory
        files <- lapply(filenames, read.csv)

        # Compute all nobs for all wanted files
        nobs <- sapply(files, compute.nobs)
        
        # return a data frame
        data.frame(id, nobs)
}

# Generate files name based on 3digits suffixed with an extension
format.filename <- function(id, extension, directory) {
        # the filename format wanted is XXX.extension
        format <- paste0(directory, "/%03d.", extension)
        sprintf(format, id)
}