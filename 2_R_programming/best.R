##The function reads the outcome-of-care-measures.csv file and returns 
##a character vector with the name of the hospital that has the best (i.e. lowest) 
##30-day mortality for the specified outcome in that state. The hospital name is 
##the name provided in the Hospital.Name variable. 

##The outcomes can be one of “heart attack”, “heart failure”, or “pneumonia”. 
##Hospitals that do not have data on a particular outcome should be excluded 
##from the set of hospitals when deciding the rankings. 



best <- function(state, outcome) {
        ## Read outcome data
        ## [2] "Hospital.Name"
        ##[7] "State"
        ##[11] "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
        ##[17] "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"     
        ##[23] "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
        Alldata <- read.csv("outcome-of-care-measures.csv",colClasses = "character")
    outcomes <- c('heart attack', 'heart failure', 'pneumonia')
    outcomeIndex <- c(11, 17, 23)
        


        ## Check that state and outcome are valid
        
   
        if(!state %in% Alldata$State  ) {
        	stop("invalid state")
    }
    
    
    
    
    
    
    if(!outcome %in% outcomes  ) {
    		stop("invalid outcome")
    }
    	

        
        ## Return hospital name in that state with lowest 30-day death
        ## [2] "Hospital.Name"
        ## outcomeIndex = indices of outcomes
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
    return (FilteredData$name[1])

        

} 
