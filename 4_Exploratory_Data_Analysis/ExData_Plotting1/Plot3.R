

source("LoadData.R")
png(filename = "Plot3.png", width = 480, height = 480, units = "px")

linecolor <- c("black", "red", "blue")
linelabels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
plot(datafile3$DateTime, datafile3$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")

lines(datafile3$DateTime, datafile3$Sub_metering_1, col = "black")
lines(datafile3$DateTime, datafile3$Sub_metering_2, col = "red")
lines(datafile3$DateTime, datafile3$Sub_metering_3, col = "blue")

legend("topright", col = linecolor, legend=linelabels, lty= "solid", lwd = 1)

dev.off()













