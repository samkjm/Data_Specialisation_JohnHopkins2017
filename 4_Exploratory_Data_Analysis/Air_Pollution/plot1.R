## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from 
## all sources for each of the years 1999, 2002, 2005, and 2008.
source("LoadData.R")

Total <- aggregate(Emissions ~ year,NEI, sum)


# head(Total)
  # year Emissions
# 1 1999   7332967
# 2 2002   5635780
# 3 2005   5454703
# 4 2008   3464206


png(filename = "Plot1.png", width = 480, height = 480, units = "px")

barplot(
  (Total$Emissions)/10^6,
  names.arg=Total$year,
  xlab="Year",
  ylab="PM2.5 Emissions (million Tons)",
  main="Total PM2.5 Emissions From All Sources in US"
)

dev.off()