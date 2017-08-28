##The function reads the outcome-of-care-measures.csv file and returns a 2-column data frame containing the hospital in each state that has the ranking specified in num. For example the function call rankall("heart attack", "best") would return a data frame containing the names of the hospitals that are the best in their respective states for 30-day heart attack death rates. The function should return a value for every state (some may be NA). The first column in the data frame is named hospital, which contains the hospital name, and the second column is named state, which contains the 2-character abbreviation for the state name. Hospitals that do not have data on a particular outcome should be excluded from the set of hospitals when deciding the rankings. ##



rankall <- function(outcome, num = "best") {
	## Read outcome data
	## [2] "Hospital.Name"
          ##[7] "State"
          ##[11] "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
          ##[17] "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"     
          ##[23] "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"

	Alldata <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
	outcomes <- c('heart attack', 'heart failure', 'pneumonia')
	outcomeIndex <- c(11, 17, 23)


	
	## Check that outcome is valid
	
    
    	if(!outcome %in% outcomes  ) {
    		stop("invalid outcome")
    	}



	## For each state, find the hospital of the given rank
	## 1st col : [2] "Hospital.Name"
	## 2nd col : [7] "State"
	##  3rd col : i = outcome
	i <- outcomeIndex[match(outcome, outcomes)]
    	FilteredData <- Alldata[ , c(2, 7,  i)] 
    
   	 # change data type from character to numeric , only second column
   	 names(FilteredData) <- c("name", "state", "deaths")
    	FilteredData[, 3] <- suppressWarnings(as.numeric(FilteredData[, 3]))
    
    	# Remove rows with NA
   	FilteredData <- FilteredData[!is.na(FilteredData$deaths), ]
   	
   	
   	
   	## For each state, find the hospital of the given rank
   	FilteredData_s = split(FilteredData, FilteredData$state)
   	FilteredData_byState = lapply(FilteredData_s, function(dat, num){
   		# Order by Deaths, and then order by HospitalName
   		dat = dat[order(dat$deaths, dat$name), ]
   		# Return
  	 	 if (num == "best") {
    			return (dat$name[1])
   	 	} 
    		else if (num == "worst") {
    			return (dat$name[nrow(dat)])
    		}
    		else {
    			num <- as.numeric(num)
    			return (dat$name[num])

    		}
    		
    		
    		# To account for errors
    		if(class(num) == "numeric" && num > nrow(dat)){
    			return(NA)
    		}
    		else if(class(num) == "numeric" && is.na(num)){
    			stop("invalid num")
    		}


   		
   	}, num)

    

    
	
	
	## Return a data frame with the hospital names and the (abbreviated) state name
	return ( data.frame(hospital=unlist(FilteredData_byState), state=names(FilteredData_byState)) )

	
} 

