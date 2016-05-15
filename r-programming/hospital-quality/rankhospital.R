rankhospital <- function(state, outcome, num = "best") {
        
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
        stateData <- data[which(data$State == state & !is.na(data[[column]])), c(hospital.name.col, column)]
        names(stateData) <- c("Hospital.Name", "Rate")
        
        # Sort data by best Rate, then if tie by Hospital.Name
        stateData <- stateData[order(stateData[, "Rate"], stateData[,"Hospital.Name"]),]
        
        if(is.character(num) & num == "best")
                stateData[1,"Hospital.Name"]
        else if (is.character(num) & num == "worst")
                stateData[nrow(stateData), "Hospital.Name"]
        else if (is.numeric(num) & num <= nrow(stateData))
                stateData[num, "Hospital.Name"]
        else
                NA
                
}