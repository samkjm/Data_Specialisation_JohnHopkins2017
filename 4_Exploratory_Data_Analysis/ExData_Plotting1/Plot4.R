source("LoadData.R")
png(filename = "Plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2, 2))

## row_number, col_number

## 1,1
plot(datafile3$DateTime, datafile3$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## 1, 2
plot(datafile3$DateTime, datafile3$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")


## 2, 1
linecolor <- c("black", "red", "blue")
linelabels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
plot(datafile3$DateTime, datafile3$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")

lines(datafile3$DateTime, datafile3$Sub_metering_1, col = "black")
lines(datafile3$DateTime, datafile3$Sub_metering_2, col = "red")
lines(datafile3$DateTime, datafile3$Sub_metering_3, col = "blue")

legend("topright",bty = "n", col = linecolor, legend=linelabels, lty= "solid", lwd = 1) ## bty is box style, here there is none. 



## 2, 2
plot(datafile3$DateTime, datafile3$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")







dev.off()
