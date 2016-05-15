rankall <- function(outcome, num = "best") {
        outcomes = c("heart attack"=11, "heart failure"=17, "pneumonia"=23)
        hospital.name.col = 2
        state.col = 7
        
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character", stringsAsFactors = FALSE)
        
        ## Check that state and outcome are valid
        if (!(outcome %in% names(outcomes))) {
                stop("invalid outcome")
        }
        
        suppressWarnings(data[, outcomes[[outcome]]] <- as.numeric(data[, outcomes[[outcome]]]))
        
        # Rename the outcome col with "Rate"
        names(data)[outcomes[[outcome]]] <- "Rate"
        
        # Subset data to keep only the outcome and the hospital name
        statesData <- subset(data, !is.na(Rate), c(hospital.name.col, outcomes[[outcome]], state.col))
        names(statesData) <- c("Hospital.Name", "Rate", "State")
        
        # Split by State
        statesData <- split(statesData, statesData$State)

        results <- data.frame("Hospital.Name"=character(), "State"=character(), stringsAsFactors = FALSE) 

        colNames <- c("Hospital.Name", "State")
        for(stateData in statesData){
                
                stateData <- stateData[order(stateData[, "Rate"], stateData[,"Hospital.Name"]),]
                
                if(is.character(num) & num == "best")
                        results <- rbind(results, stateData[1, colNames])
                else if (is.character(num) & num == "worst")
                        results <- rbind(results, stateData[nrow(stateData), colNames])
                else if (is.numeric(num) & num <= nrow(stateData))
                        results <- rbind(results, stateData[num, colNames])
                else
                        results <- rbind(results, data.frame("Hospital.Name"=NA,"State"=stateData[1,"State"]))
        }
        
        results
}
