# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). Which city has seen greater changes over time in motor vehicle emissions?


source("LoadData.R")
install.packages("ggplot2")

library("ggplot2")

## The SCC levels ( SCC.Level.Four) go from generic to specific.
VehicleSource <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
VehicleSCC <- SCC[VehicleSource,]$SCC ##extract the relevant SCC digits
VehicleNEI <- NEI[NEI$SCC %in% VehicleSCC,] ## extract the relevant NEI
BaltimoreVehicleNEI <- VehicleNEI[VehicleNEI$fips==24510,] ## extract the relevant NEI in Baltimore
CaliforniaVehicleNEI <- VehicleNEI[VehicleNEI$fips=="06037",] ## extract the relevant NEI in California
BaltimoreVehicleTotal <- aggregate(Emissions ~ year, BaltimoreVehicleNEI, sum)
CaliforniaVehicleTotal <- aggregate(Emissions ~ year, CaliforniaVehicleNEI, sum)
BothTotal <- rbind(BaltimoreVehicleTotal,CaliforniaVehicleTotal)


png(filename = "Plot6.png", width = 570, height = 480, units = "px")

barplot(
  BaltimoreVehicleTotal$Emissions,
  names.arg=BaltimoreVehicleTotal$year,
  xlab="Year",
  ylab="PM2.5 Emissions (Tons)",
  main="Total PM2.5 Emissions from Motor Vehicle Sources in Baltimore City"
)

dev.off()
