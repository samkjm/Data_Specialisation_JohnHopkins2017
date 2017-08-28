
Remove everything from the workspace<br />
rm(list = ls())<br />

# Qn1
Register an application with the Github API here https://github.com/settings/applications. Access the API to get information on your instructors repositories (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). Use this data to find the time that the datasharing repo was created. What time was it created?

This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). You may also need to run the code in the base R package and not R studio.
## Solutions to Qn1
install.packages(httr.... etc)<br />
library(httr)<br />
library(httpuv)<br />
library(jsonlite)<br />
library(dplyr)<br />

1. Find OAuth settings for github: http://developer.github.com/v3/oauth/<br />
github <- oauth_endpoints("github")<br />
<oauth_endpoint><br />
 authorize: https://github.com/login/oauth/authorize<br />
 access:    https://github.com/login/oauth/access_token<br /><br />


2. Register an application at https://github.com/settings/applications;<br />
Use any URL you would like for the homepage URL (http://github.com is fine)<br />
and http://localhost:1410 as the callback url<br />

Replace your key and secret below.<br />
myapp <- oauth_app("github",<br />
  key = "9a8e19cae7959a097ab1",<br />
  secret = "97356d00c8d9331a1c6af05b3d63ea4aff4d2a8f")<br /><br />



3. Get OAuth credentials<br />
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)<br /><br />

Use a local file ('.httr-oauth'), to cache OAuth access credentials between R sessions?

1: Yes
2: No

Selection: No???


4. Use API<br />
gtoken <- config(token = github_token)<br />
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)<br />
stop_for_status(req)<br />
content(req)<br /><br />



json1 = content(req)<br />
json2 = jsonlite::fromJSON(toJSON(json1))<br />
json2[1,1:4]<br />

json2[json2$full_name == "jtleek/datasharing",] <br />
2013-11-07T13:25:07Z<br /><br />




# Qn2
The sqldf package allows for execution of SQL commands on R data frames. We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL.

Download the American Community Survey data and load it into an R object called acs:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?<br />
sqldf("select * from acs")<br />
sqldf("select pwgtp1 from acs")<br />
sqldf("select pwgtp1 from acs where AGEP < 50")<br />
sqldf("select * from acs where AGEP < 50 and pwgtp1") <br />


## Solutions to Qn2
 install.packages("sqldf")<br />
 install.packages("data.table")<br />
 library("sqldf")<br />
 fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"<br />
 f <- file.path(getwd(), "acs.csv")<br />
 download.file(fileurl, f)<br />
 acs <- data.table(read.csv(f))<br />
 ans <- sqldf("select pwgtp1 from acs where AGEP < 50")<br /><br />
 
sqldf("select * from acs"), NO - selects everything<br />
sqldf("select pwgtp1 from acs"), NO - only selects pwgtp1 column<br />
sqldf("select pwgtp1 from acs where AGEP < 50"), YES - selects the correct column and for ages less than 50<br />
sqldf("select * from acs where AGEP < 50 and pwgtp1") <br />
identical(query3, query4)<br />
[1] TRUE<br />
str(query3)<br />
'data.frame':    10093 obs. of  239 variables:<br />
$ RT      : Factor w/ 1 level "P": 1 1 1 1 1 1 1 1 1 1 ...<br />
$ SERIALNO: int  186 186 186 186 306 395 395 506 506 506 ...<br /><br />
 
 Problems faced:<br />
 https://stackoverflow.com/questions/38416714/failed-to-connect-the-database-when-using-sqldf-in-r <br />
 Solution: <br />
 detach("package:RMySQL", unload=TRUE)<br />
 ans <- sqldf("select pwgtp1 from acs where AGEP < 50")<br />
 

# Qn3
Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)

## Solutions to Qn3
desired <- unique(acs$AGEP)<br />
op1 <- sqldf("select distinct AGEP from acs")<br />
YES - generates the same list but in a different format<br /><br />
op2 <- sqldf("select AGEP where unique from acs")<br />
Error in rsqlite_send_query(conn@ptr, statement) : <br />
  near "unique": syntax error<br /><br />
op3 <- sqldf("select unique * from acs")<br />
Error in rsqlite_send_query(conn@ptr, statement) : <br />
  near "unique": syntax error<br /><br />
op4 <- sqldf("select unique AGEP from acs")<br />
Error in rsqlite_send_query(conn@ptr, statement) : <br />
  near "unique": syntax error<br /><br />






# Qn4
How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:

http://biostat.jhsph.edu/~jleek/contact.html

(Hint: the nchar() function in R may be helpful)

## Solutions to Qn4
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")<br />
htmlCode <- readLines(con)<br />
close(con)<br /><br />
n10 <- nchar(htmlCode[10]) # 45<br />
n20 <-nchar(htmlCode[20]) # 31<br />
n30 <-nchar(htmlCode[30]) # 7<br />
n100 <-nchar(htmlCode[100]) # 25<br />
All <- c(n10,n20,n30,n100)<br /><br />




# Qn5
Read this data set into R and report the sum of the numbers in the fourth column.

https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for

Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for

(Hint this is a fixed width file format)

## Solutions to Qn5
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"<br />
download.file(fileUrl, destfile = "q5_data.for", method = "curl")<br />
list.files('./') # in current directory<br />
q5_df <- read.fwf(file = "q5_data.for", widths = c(15, 4, 1, 3, 5, 4), header = FALSE, sep = "\t", skip = 4)<br />
head(q5_df)<br /><br />


<br /><br />

| V1 |  V2 |V3 | V4| V5  | V6  | 
| ---|---|---|--- | ---|---|
| 1 | 03JAN1990 |23.4 | -0.4| NA |25.1 |
| 2 | 10JAN1990   |   23.4 | - 0.8 |NA |25.2|
|3 | 17JAN1990     | 24.2  |- 0.3 |NA |25.3|
|4 | 24JAN1990     | 24.4  |- 0.5 |NA |25.5|
|5 | 31JAN1990     | 25.1 | - 0.2 |NA |25.8|
|6 | 07FEB1990     | 25.8  |  0.2 |NA |26.1|


Need to sum up the V6 column<br />
sum(q5_df$V6)
