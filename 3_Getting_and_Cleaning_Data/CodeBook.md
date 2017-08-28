# Background

The purpose of this project is to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. This code book describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip






# Raw Data
## SUBJECT FILES 
Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
* test/subject_test.txt
* train/subject_train.txt 

## ACTIVITY FILES (labels)
* test/y_test.txt
* train/y_train.txt

## DATA FILES
* test/x_test.txt
* train/x_train.txt

## COLUMN DESCRIPTIONS
* features.txt ( column names and the corresponding relative number for each column in the data files )
* features_info.txt 
Features for this come from accelerometer and gyroscope. They are body acceleration and gravity acceleration signals, the derived jerk signals for both types of acceleration. The magnitude of the aforementioned 3-dimensional time and jerk signals were then calculated with the Euclidean norm. Fast Fourier Transform were applied to some signals to obtain the frequency value. All the values mentioned are in 3 dimensions hence the X, Y and Z values are indicated.

Extension of features include the variables that involve some processing of the raw data. This includes the mean, standard deviation, median absolute deviation, minima, maxima,signal magnitude area, energy measure, interquartile range, entropy, autoregression coefficients, correlation coefficients, max index of frequency, mean frequency, frequency skewness, frequency kurtosis, energy of frequency intervals, angle between vectors. 

In summary:
* beginning t or f is based on time or frequency measurements.
* Body = body movements thus creating acceleration.
* Gravity = acceleration of gravity (minus body acceleration)
* Acc = accelerometer measurement
* Gyro = gyroscopic measurements
* Jerk = aceleration due to sudden movement 
* Mag = magnitude of movement

 

Units: 
The units given are g’s for the accelerometer and rad/sec for the gyro and g/sec and rad/sec/sec for the corresponding jerks.

## PROCESS y DATA
activity_labels.txt (Links the class labels which are numeric with their activity name )


# Processing Done
## 1. Merges the training and the test sets to create one data set.
* read subject files, activity files and data files and concatenate in this order column-wise. 
* Concatenation is done in such a way that training-related values are the first half of the rows, and test-related values are the second half. The resulting dataset at this stage is called "Merge1"

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
* From here onwards, we aim to calculate mean and std deviation for each subject for each activity for each mean and std deva measurements.
* read features text (features.txt) which includes features numbers and features description in separate columns. 
* Extract terms with "mean" or "std" inside the descriptions and put into datatable "features2"






   |featureNum   |    featureName| featureCode|
   |---|---|---|
   |1  |        1 tBodyAcc-mean()-X    |      V1|
   |2   |       2 tBodyAcc-mean()-Y     |     V2|
   |3   |       3 tBodyAcc-mean()-Z      |    V3|
   |4    |      4  tBodyAcc-std()-X       |   V4|
   |5     |     5  tBodyAcc-std()-Y        |  V5|
   |6      |    6  tBodyAcc-std()-Z         | V6|






* Make a vector column "features2$featureCode" which joins a "V" in front of each feature number. Note that all these numbers correspond to features with "mean" or "std"

[1] "V1"   "V2"   "V3"   "V4"   "V5"   "V6"   "V41"  "V42"  "V43"  "V44"  "V45"  "V46"  "V81"  "V82"  "V83" 
[16] "V84"  "V85"  "V86"  "V121" "V122" "V123" "V124" "V125" "V126" "V161" "V162" "V163" "V164" "V165" "V166"
[31] "V201" "V202" "V214" "V215" "V227" "V228" "V240" "V241" "V253" "V254" "V266" "V267" "V268" "V269" "V270"
[46] "V271" "V294" "V295" "V296" "V345" "V346" "V347" "V348" "V349" "V350" "V373" "V374" "V375" "V424" "V425"
[61] "V426" "V427" "V428" "V429" "V452" "V453" "V454" "V503" "V504" "V513" "V516" "V517" "V526" "V529" "V530"
[76] "V539" "V542" "V543" "V552"


* Extract out the column names and data in Merge 1 that correspond to "features2$featureCode" and name the new dataset "Merge2"




## 3. Uses descriptive activity names to name the activities in the data set,  4. Appropriately labels the data set with descriptive variable names.
* read activity labels in activity_labels.txt
* rename columns to "activityNum" and "activityName"
* There is already "activityNum" in the dataset "Merge2". What you need to add is the "activityName", so you merge the activitylabels column to Merge2 corresponding to the "activityNum". The new dataset is called "Merge3"
* Melt "Merge3" and sort the data by "featureCode". Call this "Merge4"
* Merge "features2" with "Merge4" by the "featureCode" column variable




## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* Create "Merge5$Feature" as new variable for all the 66 features
* Note there is a discrepancy in result if you include meanFreq or not in the grepl mean items. This should be determined at Step 2 where "features2" was first defined(when we are trying to extract mean and std results)
* Sort the features by variables or categories that are more understandable using grepl and metacharacter principles.
* Features chosen are Domain, Acceleration, Instrument, Jerk, Magnitude, Variable, Axis

* These are then collated in Merge5 together with subject information
* Count and average information are also added. Count indicates the number of subjects that fulfill the particular set of features and conditions in each row. Average is the average acceleration signals (corresponding to the particular set of features and conditions selected) recorded on the smartphone. 





head(MergeTidy)















 |no | subject |activity| Domain| Acceleration| Instrument| Jerk| Magnitude| Variable| Axis| count  |   average|
|---|---|---|---|---|---|---|---|---|---|---|---|
|1|       1  | LAYING |  Time    |       NA | Gyroscope |  NA    |    NA    | Mean  |  X  |  50 | -0.01655309|
|2|       1   | LAYING |  Time    |       NA | Gyroscope |  NA    |    NA    | Mean  |  Y  |  50 | -0.06448612|
|3|       1   | LAYING | Time     |      NA | Gyroscope  | NA     |   NA    | Mean   | Z   | 50  | 0.14868944|
|4|       1  | LAYING |  Time    |       NA | Gyroscope |  NA    |    NA   |    SD  |  X  |  50 | -0.87354387|
|5|       1   |LAYING |  Time    |       NA | Gyroscope |  NA    |    NA   |    SD  |  Y  |  50 | -0.95109044|
|6|       1  | LAYING |  Time    |       NA | Gyroscope |  NA    |    NA   |    SD  |  Z  |  50 | -0.90828466|
















