## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

source("LoadData.R")
install.packages("ggplot2")
library("ggplot2")

## The SCC levels ( SCC.Level.Four) go from generic to specific.


CoalSource <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE)
CombustionSource <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
CoalCombustion <- (CoalSource & CombustionSource)
CoalCombSCC <- SCC[CoalCombustion, ]$SCC ##extract the relevant SCC digits
CoalCombNEI <- NEI[NEI$SCC %in% CoalCombSCC, ] ## extract the relevant NEI



png(filename = "Plot4.png", width = 480, height = 480, units = "px")


ggplot(CoalCombNEI,aes(factor(year),Emissions/10^5)) +
  geom_bar(stat="identity",fill="pink2",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="Year", y=expression(paste("Total PM"[2.5], " Emission (x", 10^{5}, " Tons)")))+ 
  labs(title=expression(paste("PM"[2.5], " Coal Combustion Source Emissions Across US from 1999-2008")))
  )
  

dev.off()
