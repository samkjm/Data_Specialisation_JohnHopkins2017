
Remove everything from the workspace<br />
rm(list = ls())<br />

# Qn1
The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:<br />

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv<br />

and load the data into R. The code book, describing the variable names is here:<br />

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf<br />

Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of the 123 element of the resulting list?<br />

## Solutions to Qn1
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv "<br />
download.file(fileUrl, destfile = "qn1_Idaho.csv") <br /><br />

read file into dataframe<br />
qn1_Idaho<- read.csv("qn1_Idaho.csv",header = TRUE,quote = "\"'",dec = ".")<br /><br />


splitwgtp = strsplit(names(qn1_Idaho),"wgtp")<br /><br />

[[116]]<br />
[1] ""  "8"<br />

[[117]]<br />
[1] ""  "9"<br />

[[118]]<br />
[1] ""   "10"<br />

[[119]]<br />
[1] ""   "11"<br />

[[120]]<br />
[1] ""   "12"<br />

[[121]]<br />
[1] ""   "13"<br />

[[122]]<br />
[1] ""   "14"<br />

[[123]]<br />
[1] ""   "15"<br />

[[124]]<br />
[1] ""   "16"<br />

[[125]]<br />
[1] ""   "17"<br /><br />







# Qn2
Load the Gross Domestic Product data for the 190 ranked countries in this data set:<br />

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv<br />

Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?<br />

Original data sources:<br />

http://data.worldbank.org/data-catalog/GDP-ranking-table<br />


## Solutions to Qn2
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv" <br />
download.file(fileUrl, destfile = "GDP.csv") <br />

read file into dataframe and tidy data<br />
GDP <- read.csv("GDP.csv",header = TRUE,dec = ".",skip=4, nrows = 190)<br />
include header, specify decimal point, skip the number of lines of the data file to skip before beginning to read data, nrows the maximum number of rows to read in.<br />
https://stat.ethz.ch/R-manual/R-devel/library/utils/html/read.table.html<br />
head(GDP)<br />
    X X.1 X.2            X.3          X.4 X.5 X.6 X.7 X.8 X.9<br />
1 USA   1  NA  United States  16,244,600       NA  NA  NA  NA<br />
2 CHN   2  NA          China   8,227,103       NA  NA  NA  NA<br />
3 JPN   3  NA          Japan   5,959,718       NA  NA  NA  NA<br />
4 DEU   4  NA        Germany   3,428,131       NA  NA  NA  NA<br />
5 FRA   5  NA         France   2,612,878       NA  NA  NA  NA<br />
6 GBR   6  NA United Kingdom   2,471,784       NA  NA  NA  NA<br />
<br />
GDP2 <- GDP[ , c(1,2,4,5)]<br />
names(GDP2)<-c("CountryCode", "Ranking", "CountryNames", "gdpval")<br />
GDP2$gdpval <- gsub(",", "", GDP2$gdpval)<br />
GDP3 <- (GDP2$gdpval)<br />
GDP4 <- as.numeric(GDP3)<br />
mean(GDP4, na.rm= TRUE)<br />

# Qn3
In the data set from Question 2 what is a regular expression that would allow you to count the number of countries whose name begins with "United"? Assume that the variable with the country names in it is named countryNames. How many countries begin with United?

## Solutions to Qn3
United <- grepl("^United", GDP2$CountryNames)<br />

summary(United)<br />
   Mode   FALSE    TRUE <br />
logical     187       3 <br /><br />





# Qn4
Load the Gross Domestic Product data for the 190 ranked countries in this data set:<br />

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv<br />

Load the educational data from this data set:<br />

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv<br />

Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available, how many end in June?<br />

Original data sources:<br />

http://data.worldbank.org/data-catalog/GDP-ranking-table<br />

http://data.worldbank.org/data-catalog/ed-stats<br />

## Solutions to Qn4


fileGDP <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv "<br />
download.file(fileGDP, destfile = "fileGDP.csv") <br /><br />
GDP<- read.csv("fileGDP.csv",header = TRUE,dec = ".",skip=4, nrows = 190)<br /><br />


fileEdu <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv "<br />
download.file(fileEdu, destfile = "fileEdu.csv") <br />
Edu<- read.csv("fileEdu.csv",header = TRUE,dec = ".")<br /><br />

merger <- merge(GDP, Edu, by.x = "X", by.y = "CountryCode")<br />
write.csv(merger, file = "GDPxEdu.csv", sep = "\t")<br /><br />

grep vs grepl<br />
https://awakeningdatascientist.wordpress.com/2015/07/20/r-of-the-day-grep-and-grepl/<br />
length(grep("*Fiscal year end: June",merger$Special.Notes))<br /><br />







# Qn5
You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for publicly traded companies on the NASDAQ and NYSE. Use the following code to download data on Amazon's stock price and get the times the data was sampled.


library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)


## Solutions to Qn5

install.packages("quantmod")

library(quantmod)

Do you want to install from sources the package which needs compilation?
y/n: n

amzn = getSymbols("AMZN",auto.assign=FALSE)

...
...
2017-06-23   1002.54   1004.62   998.02    1003.74     2879100       1003.74
2017-06-26   1008.50   1009.80   992.00     993.98     3386200        993.98
2017-06-27    990.69    998.80   976.00     976.78     3782400        976.78
2017-06-28    978.55    990.68   969.21     990.33     3737600        990.33
2017-06-29    979.00    987.56   965.25     975.93     4303000        975.93
2017-06-30    980.12    983.47   967.61     968.00     3357200        968.00
2017-07-03    972.79    974.49   951.00     953.66     2909100        953.66
2017-07-05    961.53    975.00   955.25     971.40     3653000        971.40
2017-07-06    964.66    974.40   959.02     965.14     3259600        965.14
2017-07-07    969.55    980.11   969.14     978.76     2582600        978.76
2017-07-10    985.00    999.44   983.50     996.47     3502300        996.47
2017-07-11    993.00    995.99   983.72     994.13     2982726        994.13



sampleTimes = index(amzn)


[2617] "2017-05-24" "2017-05-25" "2017-05-26" "2017-05-30" "2017-05-31" "2017-06-01" "2017-06-02" "2017-06-05"
[2625] "2017-06-06" "2017-06-07" "2017-06-08" "2017-06-09" "2017-06-12" "2017-06-13" "2017-06-14" "2017-06-15"
[2633] "2017-06-16" "2017-06-19" "2017-06-20" "2017-06-21" "2017-06-22" "2017-06-23" "2017-06-26" "2017-06-27"
[2641] "2017-06-28" "2017-06-29" "2017-06-30" "2017-07-03" "2017-07-05" "2017-07-06" "2017-07-07" "2017-07-10"
[2649] "2017-07-11"

library(lubridate)
sampleTimes = ymd(sampleTimes)round_date(sampleTimes, "year")
Year2012 <- subset(sampleTimes, year(sampleTimes) == 2012)
length(Year2012) ## [1] 250
Find out number of Mondays in this subset
length(which(wday(Y2012, label = T) == "Mon")) ## [1] 47


