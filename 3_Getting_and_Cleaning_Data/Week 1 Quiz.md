# Qn1
The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
and load the data into R. The code book, describing the variable names is here:
https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
How many properties are worth $1,000,000 or more?
## Solutions to Qn1
Change working directory on R <br />
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv" <br />
download.file(url=fileUrl,destfile="IdahoHousing.csv",mode="w",method="curl")<br />
IdahoHousing <- read.csv("IdahoHousing.csv")<br />
head(IdahoHousing) # check if data loads<br />

Accoding to Code book, VAL with 24 = any house more than $1000000.<br />
#Following piece of code is trying to get count on house price >$1000000 whose value is not NA<br /> length(IdahoHousing$VAL[!is.na(IdahoHousing$VAL) & IdahoHousing$VAL==24])<br />
or<br />
nrow(subset(IdahoHousing, VAL == 24))




# Qn2
Use the data you loaded from Question 1. Consider the variable FES in the code book. Which of the "tidy data" principles does this variable violate?

## Solutions to Qn2
FES        1
    Family type and employment status<br />
b .N/A (GQ/vacant/not a family)<br />
1 .Married-couple family: Husband and wife in LF<br />
2 .Married-couple family: Husband in labor force, wife
             .not in LF<br />
           3 .Married-couple family: Husband not in LF,
.wife in LF<br />
4 .Married-couple family: Neither husband nor wife in
.LF<br />
5 .Other family: Male householder, no wife present, in
.LF<br />
6 .Other family: Male householder, no wife present,
.not in LF<br />
7 .Other family: Female householder, no husband
             .present, in LF<br />
8 .Other family: Female householder, no husband
             .present, not in LF<br /><br />
             
             
 in LF / or not in LF. -> FES depends on another variable (in or not in LF)<br />
 
The FES definition breaks the 'Tidy data has one variable per column' principle.<br />



# Qn3
Download the Excel spreadsheet on Natural Gas Aquisition Program here:
https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx
Read rows 18-23 and columns 7-15 into R and assign the result to a variable called dat What is the value of sum(dat$Zip*dat$Ext,na.rm=T) ?

## Solutions to Qn3
ALOT of problems with rJava and Mac.<br />
Troubleshooted the Java configuration with reference to the following websites:<br />
https://stackoverflow.com/questions/35179151/cannot-load-r-xlsx-package-on-mac-os-10-11<br />
https://stackoverflow.com/questions/44081227/trouble-installing-and-loading-rjava-on-mac-el-capitan<br />
http://charlotte-ngs.github.io/2016/01/MacOsXrJavaProblem.html<br />
http://www.owsiak.org/?p=3671<br /><br />

After that:<br />
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"<br />
download.file(url=fileUrl1, destfile="GAS.xlsx", mode="w", method="curl")<br />
install.package("rJava")<br />
install.package('xlsx")<br />
library(xlsx)<br />
rowI <- 18:23<br />
colI <- 7:15<br />
dat <- read.xlsx(file="GAS.xlsx", sheetIndex=1, rowIndex = 18:23, colIndex = 7:15, header=TRUE)<br />
sum(dat$Zip*dat$Ext,na.rm=T)<br />






# Qn4
Read the XML data on Baltimore restaurants from here:
https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml
How many restaurants have zipcode 21231?

## Solutions to Qn4
library(XML)<br />
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"<br />
dataurl <- xmlTreeParse(file=fileUrl,useInternal=TRUE)<br />
rootNode <- xmlRoot(dataurl)<br />
xmlName(rootNode) ## response<br />
zipcode <- xpathSApply(rootNode,"//zipcode",xmlValue)<br />
length(zipcode[zipcode==21231])<br />




# Qn5
The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
Using the fread() command load the data into an R object DT.
Which of the following is the fastest way to calculate the average value of the variable pwgtp15 broken down by sex using
the data.table package?:<br />
1. sapply(split(DT$pwgtp15,DT$SEX),mean)<br /> 2. tapply(DT$pwgtp15,DT$SEX,mean)<br />
3. mean(DT$pwgtp15,by=DT$SEX)<br />
4. DT[,mean(pwgtp15),by=SEX]<br />
5. rowMeans(DT)[DT$SEX==1];rowMeans(DT)[DT$SEX==2]<br />
6. mean(DT[DT$SEX==1,]$pwgtp15);mean(DT[DT$SEX==2,]$pwgtp15)<br /><br />

## Solutions to Qn5
library(data.table)<br />
DT <- fread(input="fsspid.csv", sep=",") <br />
system.time(....input options 1 to 6 here ......) ## see output for user time<br />

