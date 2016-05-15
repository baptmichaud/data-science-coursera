corr <- function(directory, threshold = 0) {
        
        # Get all files of the directory
        filenames <- list.files(directory, pattern = ".csv", all.files = FALSE, full.names = TRUE)
        
        # Load files set from the working directory
        #files <- lapply(filenames, read.csv)
        
        # initialize results
        results <- numeric()
        idx <- 1
        
        # foreach file
        for(z in seq_along(filenames)) {
                
                file <- read.csv(filenames[z])
                
                # compute the number of complete case
                nobs <- sum(complete.cases(file))

                # check if the threshold is reach and launch the corr
                if(nobs > threshold)
                {
                        correlation <- cor(file$sulfate, file$nitrate, use = "complete.obs")
                        results[idx] <- correlation
                        idx <- idx + 1
                }
        }
        # <- cor(use = "complete.obs")       
        
        results
}