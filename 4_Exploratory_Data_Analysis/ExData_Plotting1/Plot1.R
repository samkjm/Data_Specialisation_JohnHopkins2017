

source("LoadData.R")
png(filename = "Plot1.png", width = 480, height = 480, units = "px")
hist(datafile3$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylim = c(0, 1200))
