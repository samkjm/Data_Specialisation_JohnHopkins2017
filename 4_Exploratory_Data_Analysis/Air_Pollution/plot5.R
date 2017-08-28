## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?


source("LoadData.R")
install.packages("ggplot2")

library("ggplot2")

## The SCC levels ( SCC.Level.Four) go from generic to specific.
VehicleSource <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
VehicleSCC <- SCC[VehicleSource,]$SCC ##extract the relevant SCC digits
VehicleNEI <- NEI[NEI$SCC %in% VehicleSCC,] ## extract the relevant NEI
BaltimoreVehicleNEI <- VehicleNEI[VehicleNEI$fips==24510,] ## extract the relevant NEI in Baltimore
BaltimoreVehicleTotal <- aggregate(Emissions ~ year, BaltimoreVehicleNEI, sum)



png(filename = "Plot5.png", width = 570, height = 480, units = "px")

barplot(
  BaltimoreVehicleTotal$Emissions,
  names.arg=BaltimoreVehicleTotal$year,
  xlab="Year",
  ylab="PM2.5 Emissions (Tons)",
  main="Total PM2.5 Emissions from Motor Vehicle Sources in Baltimore City"
)

dev.off()

