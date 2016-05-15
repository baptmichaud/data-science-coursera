best <- function(state, outcome) {
        
        # Map outcome with column ID position in the outcome file
        outcome.valid= c("heart attack", "heart failure",  "pneumonia")
        outcome.position = c(11, 17, 23)
        names(outcome.position) = outcome.valid
        
        hospital.name.col = 2
        
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        ## Check that state and outcome are valid
        if (!(state %in% unique(data$State))) {
                stop("invalid state")   
        } 
        
        if (!(outcome %in% outcome.valid)) {
                stop("invalid outcome")
        }
        
        # get outcome column to treat
        column <- outcome.position[[outcome]]
        
        # convert character into numeric
        suppressWarnings(data[, column] <- as.numeric(data[, column]))
        
        # Subset the data to get only the data from the wanted state and wanted outcome
        stateData <- data[which(data$State == state), c(hospital.name.col, column)]
        names(stateData) <- c("Hospital.Name", outcome)
        
        # Get the best (lowest) outcome value for the choosen state
        
        # 1st solution: with tapply and with automatic subset + compute all state
        # minValue <- tapply(data[[column]], data$State, min, na.rm = TRUE)[[state]]
        
        # 2nd solution: without tapply and with manual subset 
        # + compute only the wanted state
        minValue <- min(stateData[outcome], na.rm = TRUE)
        
        # Get the hospital name
        bestHospital <- stateData[which(stateData[[outcome]] == minValue), "Hospital.Name"]
        
        # Display the first hospital in alphabetical order
        if(length(bestHospital) > 1) {
                sort(bestHospital)[1]
        }
        else
                bestHospital
}