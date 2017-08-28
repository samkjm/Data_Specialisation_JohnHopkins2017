

source("LoadData.R")
png(filename = "Plot2.png", width = 480, height = 480, units = "px")
plot(datafile3$DateTime, datafile3$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()


