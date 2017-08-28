
downloadURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
downloadfile <- "household_power_consumption.zip"
textfile <- "household_power_consumption.txt"

if (!file.exists(textfile)) {
  download.file(downloadURL, downloadfile, method = "curl")
  unzip(downloadfile, overwrite = T)
}

datafile <- read.table(textfile, header=TRUE, sep=";", na.strings="?")

datafile2 <- datafile[datafile$Date %in% c("1/2/2007","2/2/2007"),]

DateTime <- strptime(paste(datafile2$Date, datafile2$Time, sep=" "),"%d/%m/%Y %H:%M:%S")

datafile3 <- cbind(DateTime, datafile2[,3:9])
write.csv(datafile3, file = "PowerConsumptionData.csv", row.names = FALSE)

