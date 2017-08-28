# Of the four types of sources indicated by the type
 # (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.


source("LoadData.R")
install.packages("ggplot2")

library("ggplot2")
library(plyr)



 

BaltimoreNEI <- NEI[NEI$fips=="24510", ]
BaltimoreTotal <- aggregate(Emissions ~ year, BaltimoreNEI, sum)
BaltimoreByType <- ddply(BaltimoreNEI, .(type, year), summarize, Emissions = sum(Emissions))


png(filename = "Plot3line.png", width = 480, height = 480, units = "px")


    
    
    
ggplot(BaltimoreByType,aes(factor(year),Emissions, group = type, color=type)) +
  geom_line(stat="identity") +
  geom_point(stat="identity") +
  theme_bw() +  scale_colour_discrete(name  ="Pollution Source Types") +
  labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))



dev.off()