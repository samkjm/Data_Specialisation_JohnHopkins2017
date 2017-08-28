## Download file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "DataScience3_assignment.zip") 

## Unzip file
unzip("DataScience3_assignment.zip")

## Libraries needed
library(data.table)

#################### Merge training and test data ####################
## Read files subject and then merge
trainsubject<- fread("./UCI HAR Dataset/train/subject_train.txt")
testsubject<- fread("./UCI HAR Dataset/test/subject_test.txt")
Subject <- rbind(trainsubject, testsubject)
setnames(Subject, "V1", "subject")

## Read files activity Y and merge
ytrain<- fread("./UCI HAR Dataset/train/Y_train.txt")
ytest<- fread("./UCI HAR Dataset/test/Y_test.txt")
YActivity <- rbind(ytrain, ytest)
setnames(YActivity, "V1", "activityNum")

## Read files Data X and meter
xtrain<- fread("./UCI HAR Dataset/train/X_train.txt")
xtest <- fread("./UCI HAR Dataset/test/X_test.txt")
XData<- rbind(xtrain, xtest)

Merge1 <- cbind(Subject, YActivity, XData)
setkey(Merge1, subject, activityNum)

#################### Features: from here get Mean and Std ####################
features <- fread("./UCI HAR Dataset/features.txt")
setnames(features, names(features), c("featureNum", "featureName")) 
## Header "V1", "V2" change to "featureNum", "featureName"

##features2 <-features[grepl("mean.|std", featureName)]
features2 <-features[grepl("mean[[:punct:]]|std", featureName)]
##!!!!!!! this part is very important. Because there is something called "meanFreq" which is different from mean() in the data
## need to choose mean(followed by punctuation)
## very important especially when selecting features at segment 5 later on.... 
## if meanFreq is included, r1 = 79, r2 = 66
## if meanFreq is NOT included, r1 = r2 = 66


features2$featureCode <- features2[, paste0("V", featureNum)] 
## need a featureCode column so u can use to coincide with columns already inside the downloaded data "X" files

MergeKey <- c(key(Merge1), features2$featureCode)
## key gives you the column names already existing, "c" just adds to the list

Merge2 <- Merge1[, MergeKey, with=FALSE]






#################### Get Activity Labels ####################
activityLabels <- fread("./UCI HAR Dataset/activity_labels.txt")
setnames(activityLabels, names(activityLabels), c("activityNum", "activityName"))

Merge3 <- merge(Merge2, activityLabels, by="activityNum", all.x=TRUE)

setkey(Merge3, subject, activityNum, activityName)

Merge4 <- data.table(melt(Merge3, key(Merge3), variable.name="featureCode"))
Merge5 <- merge(Merge4, features2[, list(featureNum, featureCode, featureName)], by="featureCode", all.x=TRUE)




#################### Tidy the variables ####################

Merge5$Feature <- factor(Merge5$featureName)

## sort by 1 feature
Merge5$Jerk <- factor(grepl("Jerk", Merge5$Feature), labels=c(NA, "Jerk"))
Merge5$Magnitude <- factor(grepl("Mag", Merge5$Feature), labels=c(NA, "Magnitude"))




## sort by 2 features
n_two <- 2
y_two <- matrix(seq(1, n_two), nrow=n_two)

## sort by 2 features : time vs frequency
xdomain <- matrix(c(grepl("^t", Merge5$Feature), grepl("^f", Merge5$Feature)), ncol=2)
Merge5$Domain <- factor(xdomain %*% y_two, labels=c("Time", "Freq"))


## sort by 2 features : Accelerometer vs Gyroscope
xinstrument <- matrix(c(grepl("Acc", Merge5$Feature), grepl("Gyro", Merge5$Feature)), ncol=2)
Merge5$Instrument <- factor(xinstrument %*% y_two, labels=c("Accelerometer", "Gyroscope"))

## sort by 2 features : Body Acceleration vs Gravity Acceleration
xacc <- matrix(c(grepl("BodyAcc", Merge5$Feature), grepl("GravityAcc", Merge5$Feature)), ncol=2)
Merge5$Acceleration <- factor(xacc %*% y_two, labels=c(NA, "Body", "Gravity"))

## sort by 2 features : Mean vs Standard Deviation
xvar <- matrix(c(grepl("mean", Merge5$Feature), grepl("std", Merge5$Feature)), ncol=2)
Merge5$Variable <- factor(xvar %*% y_two, labels=c("Mean", "SD"))



## Features with 3 features
n_three <- 3
y_three <- matrix(seq(1, n_three), nrow=n_three)
xaxis <- matrix(c(grepl("-X", Merge5$Feature), grepl("-Y|,Y", Merge5$Feature), grepl("-Z|,Z", Merge5$Feature)), ncol=3)
Merge5$Axis <- factor(xaxis %*% y_three, labels=c(NA, "X", "Y", "Z"))




r1 <- nrow(Merge5[, .N, by=c("Feature")])
r2 <- nrow(Merge5[, .N, by=c("Domain", "Acceleration", "Instrument", "Jerk", "Magnitude", "Variable", "Axis")])
r1 == r2 ## 66


Merge5$activity <- factor(Merge5$activityName)
setkey(Merge5, subject, activity, Domain, Acceleration, Instrument, Jerk, Magnitude, Variable, Axis)
MergeTidy <- Merge5[, list(count = .N, average = mean(value)), by=key(Merge5)]


dim(MergeTidy) # [1] 11880    11

MergeTidy1 <- file.path("MergeTidy.csv")
write.table(MergeTidy, MergeTidy1, quote = FALSE, sep = ",", row.names = FALSE)
MergeTidy2 <- file.path("MergeTidy.txt")
write.table(MergeTidy,MergeTidy2, quote = FALSE, sep = "\t", row.names = FALSE)

head(MergeTidy)
   subject activity Domain Acceleration Instrument Jerk Magnitude Variable Axis count     average
1:       1   LAYING   Time           NA  Gyroscope   NA        NA     Mean    X    50 -0.01655309
2:       1   LAYING   Time           NA  Gyroscope   NA        NA     Mean    Y    50 -0.06448612
3:       1   LAYING   Time           NA  Gyroscope   NA        NA     Mean    Z    50  0.14868944
4:       1   LAYING   Time           NA  Gyroscope   NA        NA       SD    X    50 -0.87354387
5:       1   LAYING   Time           NA  Gyroscope   NA        NA       SD    Y    50 -0.95109044
6:       1   LAYING   Time           NA  Gyroscope   NA        NA       SD    Z    50 -0.90828466


