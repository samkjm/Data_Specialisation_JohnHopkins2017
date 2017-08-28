# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). Which city has seen greater changes over time in motor vehicle emissions?


source("LoadData.R")
install.packages("ggplot2")

library("ggplot2")

## The SCC levels ( SCC.Level.Four) go from generic to specific.
VehicleSource <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
VehicleSCC <- SCC[VehicleSource,]$SCC ##extract the relevant SCC digits
VehicleNEI <- NEI[NEI$SCC %in% VehicleSCC,] ## extract the relevant NEI

BaltimoreVehicleNEI <- VehicleNEI[VehicleNEI$fips==24510,] ## extract the relevant NEI in Baltimore
BaltimoreVehicleTotal <- aggregate(Emissions ~ year, BaltimoreVehicleNEI, sum)
BaltimoreVehicleTotal$City <- "Baltimore, MD"
BaltimoreVehicleTotal[2:4,"Change"] <- diff(BaltimoreVehicleTotal$Emissions)
BaltimoreVehicleTotal$Change[1] <- 0

CaliforniaVehicleNEI <- VehicleNEI[VehicleNEI$fips=="06037",] ## extract the relevant NEI in California
CaliforniaVehicleTotal <- aggregate(Emissions ~ year, CaliforniaVehicleNEI, sum)
CaliforniaVehicleTotal$City<- "Los Angeles, CA"
CaliforniaVehicleTotal[2:4,"Change"] <- diff(CaliforniaVehicleTotal$Emissions)
CaliforniaVehicleTotal$Change[1] <- 0

BothChange <- rbind(BaltimoreVehicleTotal,CaliforniaVehicleTotal)



png(filename = "Plot6_RelativeChange_Unnormalized.png", width = 570, height = 480, units = "px")

ggplot(data=BothChange, aes(x=year, y=Change, group=City, color=City)) +
 theme_bw() +
 geom_line() + geom_point() + xlab("Year") + ylab("Change in Emissions") + ggtitle("Motor Vehicle PM2.5 Emissions Changes: Baltimore vs. LA")


dev.off()
