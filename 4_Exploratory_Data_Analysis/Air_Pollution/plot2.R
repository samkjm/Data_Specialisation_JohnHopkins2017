## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (
## 𝚏ips𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

source("LoadData.R")

BaltimoreNEI <- NEI[NEI$fips=="24510", ]
BaltimoreTotal <- aggregate(Emissions ~ year, BaltimoreNEI, sum)


png(filename = "Plot2.png", width = 480, height = 480, units = "px")

barplot(
  BaltimoreTotal$Emissions,
  names.arg=BaltimoreTotal$year,
  xlab="Year",
  ylab="PM2.5 Emissions (Tons)",
  main="Total PM2.5 Emissions From All Sources in Baltimore City"
)

dev.off()