rankhospital <- function(state, outcome, num = "best") {
	## Read outcome data
	## [2] "Hospital.Name"
          ##[7] "State"
          ##[11] "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
          ##[17] "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"     
          ##[23] "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
	Alldata <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
     outcomes <- c('heart attack', 'heart failure', 'pneumonia')
     outcomeIndex <- c(11, 17, 23)
     
     
	## Check that state and outcome are valid
	
	if(!state %in% Alldata$State  ) {
        	stop("invalid state")
    }
    
    
    if(!outcome %in% outcomes  ) {
    		stop("invalid outcome")
    }
    
    
    
	## Return hospital name in that state with the given rank 30-day death rate
	## [2] "Hospital.Name"
        ## outcomeIndex= indices of outcomes
        ## hospitals = State, outcome_deaths
    i <- outcomeIndex[match(outcome, outcomes)]
    FilteredData <- Alldata[Alldata$State == state, c(2, i)] 
    
    # change data type from character to numeric , only second column
    names(FilteredData) <- c("name", "deaths")
    FilteredData[, 2] <- suppressWarnings(as.numeric(FilteredData[, 2]))
    
    # Remove rows with NA
    FilteredData <- FilteredData[!is.na(FilteredData$deaths), ]

    
    # Order by Deaths and then HospitalName
    FilteredData = FilteredData[order(FilteredData$deaths, FilteredData$name),]
    
    
    # Return
    if (num == "best") {
    	return (FilteredData$name[1])
    } 
    else if (num == "worst") {
    	return (FilteredData$name[nrow(FilteredData)])
    }
    else {
    	num <- as.numeric(num)
    	return (FilteredData$name[num])

    }
    
    
    
    
    # To account for errors
    if(class(num) == "numeric" && num > nrow(FilteredData)){
    	return(NA)
    }
    else if(class(num) == "numeric" && is.na(num)){
    	stop("invalid num")
    }

	
	
}
