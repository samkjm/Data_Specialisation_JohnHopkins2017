
Remove everything from the workspace<br />
rm(list = ls())<br />

# Qn1
The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:<br />

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv<br />

and load the data into R. The code book, describing the variable names is here:<br />

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf<br />

Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE.<br />

which(agricultureLogical)<br />

What are the first 3 values that result?<br />

## Solutions to Qn1
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv "<br />
download.file(fileUrl, destfile = "qn1_Idaho.csv") <br /><br />

read file into dataframe<br />
qn1_Idaho<- read.csv("qn1_Idaho.csv",header = TRUE,quote = "\"'",dec = ".")<br /><br />

ACR refers to acres... AGS refers to agri products<br />
agricultureLogical <-with(qn1_Idaho, ACR == 3 & AGS == 6)<br />
which(agricultureLogical)<br /><br />





# Qn2
Using the jpeg package read in the following picture of your instructor into R<br />

https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg<br />

Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? (some Linux systems may produce an answer 638 different for the 30th quantile)<br /><br />


## Solutions to Qn2
install.packages("jpeg")<br />
library(jpeg)<br /><br />

fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"<br />
download.file(fileUrl, mode = "wb",destfile = "qn2_Jeff.jpg") <br /><br />

on "wb" mode, refer to below<br />
https://stat.ethz.ch/R-manual/R-devel/library/utils/html/download.file.html<br />
https://stat.ethz.ch/pipermail/r-devel/2012-August/064739.html<br /><br />

Jeff <- readJPEG("qn2_Jeff.jpg", native = TRUE)<br />
On raster vs array (native representation)<br />
https://rforge.net/doc/packages/jpeg/readJPEG.html<br />
https://gis.stackexchange.com/questions/57142/what-is-the-difference-between-vector-and-raster-data-models<br /><br />
 
QJeff <- quantile(Jeff,probs = c(.30, .80))<br /><br />


# Qn3
Load the Gross Domestic Product data for the 190 ranked countries in this data set:<br />

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv<br />

Load the educational data from this data set:<br />

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv<br />

Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank (so United States is last). What is the 13th country in the resulting data frame?<br /><br />

Original data sources:<br />

http://data.worldbank.org/data-catalog/GDP-ranking-table<br />

http://data.worldbank.org/data-catalog/ed-stats<br />

## Solutions to Qn3

fileUrlGDP <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"<br />
download.file(fileUrlGDP, destfile = "GDP.csv") <br />
GDP <- read.csv("GDP.csv",header = TRUE,quote = "\"",dec = ".",skip=3, nrows = 191)<br />
ref for read.csv<br />
https://stat.ethz.ch/R-manual/R-devel/library/utils/html/read.table.html<br /><br />


fileUrlEdu <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"<br />
download.file(fileUrlEdu, destfile = "Education.csv")<br />
Education <- read.csv("Education.csv",header = TRUE,quote = "\"",dec = ".",)<br /><br />

merger <- merge(GDP, Education, by.x = "X", by.y = "CountryCode")<br />
https://stat.ethz.ch/R-manual/R-devel/library/base/html/merge.html<br />
by.x = "X" is X column in GDP<br />
by.y = "CountryCode" is CountryCode column in Education<br /><br />



merger_filterRanking <- merger[,c("X","Ranking")] #Filter by ranking<br />
merger_sortedRankingRow <- order(-merger_filterRanking$Ranking) # Sort by ranking<br />
Output is ordered row numbers:<br />
merger_sortedRanking<br />
  [1] 173  92 113 137 155  59 169  46  39 184 180  69  93 183  66  65 151 161   8 100 168  22  99  28  40  30 111<br />
 [28] 102  12   1  71  52 160 152 164  57 120  26 122 117 156  23  64 108  95  90 125 166 146 109  14  75  19 116<br />
 [55]  97 114 189   7 110 118 115  15 121 127   4 163 124  82  37  91 149 119  29  85 138  62  27 187  20  67  60<br />
 [82]  73 130 175   2 188  54  43 170 153  35  36 142  24 174 105  18  86 167 185 134 154  89  63  55 103  98 106<br />
[109]  41 158 171 177  70  17 179 104 148  48  74 101  21  11  42 132 162  50 157 107 140   3  16  76 182  96 131<br />
[136] 143 176 144  44  88 135  49  81  79 141 133  56  68 136  83 126  51  72  33 150 123  47   5 165  38 181 186<br />
[163]  10   6  13 139 129  80 159  32 147 128 172  77  94 112  53   9  31  78  84 145  25  61  58  45  87  34 178<br />

merger2 <- merger_filterRanking[merger_sortedRankingRows,]<br />
merger2 ranking is sorted in descending, but numbering on the far left is not ordered<br />
Output:<br />
tail(merger2)<br />
      X Ranking<br />
61  GBR       6<br />
58  FRA       5<br />
45  DEU       4<br />
87  JPN       3<br />
34  CHN       2<br />
178 USA       1<br /><br />

reset the order<br />
rownames(merger2) <br />
  [1] "173" "92"  "113" "137" "155" "59"  "169" "46"  "39"  "184" "180" "69"  "93"  "183" "66"  "65"  "151" "161"<br />
 [19] "8"   "100" "168" "22"  "99"  "28"  "40"  "30"  "111" "102" "12"  "1"   "71"  "52"  "160" "152" "164" "57" <br />
 [37] "120" "26"  "122" "117" "156" "23"  "64"  "108" "95"  "90"  "125" "166" "146" "109" "14"  "75"  "19"  "116"<br />
 [55] "97"  "114" "189" "7"   "110" "118" "115" "15"  "121" "127" "4"   "163" "124" "82"  "37"  "91"  "149" "119"<br />
 [73] "29"  "85"  "138" "62"  "27"  "187" "20"  "67"  "60"  "73"  "130" "175" "2"   "188" "54"  "43"  "170" "153"<br />
 [91] "35"  "36"  "142" "24"  "174" "105" "18"  "86"  "167" "185" "134" "154" "89"  "63"  "55"  "103" "98"  "106"<br />
[109] "41"  "158" "171" "177" "70"  "17"  "179" "104" "148" "48"  "74"  "101" "21"  "11"  "42"  "132" "162" "50" <br />
[127] "157" "107" "140" "3"   "16"  "76"  "182" "96"  "131" "143" "176" "144" "44"  "88"  "135" "49"  "81"  "79" <br />
[145] "141" "133" "56"  "68"  "136" "83"  "126" "51"  "72"  "33"  "150" "123" "47"  "5"   "165" "38"  "181" "186"<br />
[163] "10"  "6"   "13"  "139" "129" "80"  "159" "32"  "147" "128" "172" "77"  "94"  "112" "53"  "9"   "31"  "78" <br />
[181] "84"  "145" "25"  "61"  "58"  "45"  "87"  "34"  "178"<br /><br />
rownames(merger2) <- 1:nrow(merger2)<br /><br />

rownames(merger2)<br />
  [1] "1"   "2"   "3"   "4"   "5"   "6"   "7"   "8"   "9"   "10"  "11"  "12"  "13"  "14"  "15"  "16"  "17"  "18" <br />
 [19] "19"  "20"  "21"  "22"  "23"  "24"  "25"  "26"  "27"  "28"  "29"  "30"  "31"  "32"  "33"  "34"  "35"  "36" <br />
 [37] "37"  "38"  "39"  "40"  "41"  "42"  "43"  "44"  "45"  "46"  "47"  "48"  "49"  "50"  "51"  "52"  "53"  "54" <br />
 [55] "55"  "56"  "57"  "58"  "59"  "60"  "61"  "62"  "63"  "64"  "65"  "66"  "67"  "68"  "69"  "70"  "71"  "72" <br />
 [73] "73"  "74"  "75"  "76"  "77"  "78"  "79"  "80"  "81"  "82"  "83"  "84"  "85"  "86"  "87"  "88"  "89"  "90" <br />
 [91] "91"  "92"  "93"  "94"  "95"  "96"  "97"  "98"  "99"  "100" "101" "102" "103" "104" "105" "106" "107" "108"<br />
[109] "109" "110" "111" "112" "113" "114" "115" "116" "117" "118" "119" "120" "121" "122" "123" "124" "125" "126"<br />
[127] "127" "128" "129" "130" "131" "132" "133" "134" "135" "136" "137" "138" "139" "140" "141" "142" "143" "144"<br />
[145] "145" "146" "147" "148" "149" "150" "151" "152" "153" "154" "155" "156" "157" "158" "159" "160" "161" "162"<br />
[163] "163" "164" "165" "166" "167" "168" "169" "170" "171" "172" "173" "174" "175" "176" "177" "178" "179" "180"<br />
[181] "181" "182" "183" "184" "185" "186" "187" "188" "189"<br /><br />

answer<br />
merger2<br /><br />

head(merger2, n = 10)<br />
     X Ranking<br />
1  TUV     190<br />
2  KIR     189<br />
3  MHL     188<br />
4  PLW     187<br />
5  STP     186<br />
6  FSM     185<br />
7  TON     184<br />
8  DMA     183<br />
9  COM     182<br />
10 WSM     181<br /><br />

# Qn4
What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?<br />

## Solutions to Qn4


merger_filtered2 <- merger[,c("X","Ranking","Long.Name","Income.Group")]<br />
Ranking<br />
X is short name<br />
Long.Name is long name of country<br />
Income.Group is the OECD and nonOECD<br /><br />




by(merger_filtered2$Ranking,merger_filtered2$Income.Group,mean)<br />



# Qn5
Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries<br />

are Lower middle income but among the 38 nations with highest GDP?<br />

## Solutions to Qn5

reuse merger_filtered2 (X, Ranking, long name,Income Group) <br /><br />

Attempt to see how many values fall into each bin<br />
quantile(merger_filtered2$Ranking,probs = c(.2,.4,.6, .8,1))<br />
  20%   40%   60%   80%  100% <br />
 38.6  76.2 113.8 152.4 190.0 <br /><br />


merger_filtered2_Ranking <- order(merger_filtered2$Ranking)<br />
Output is ordered row numbers:<br />
[1] 178  34  87  45  58  61  25 145  84  78  31   9  53 112  94  77 172 128 147  32 159  80 129 139  13   6  10<br />
 [28] 186 181  38 165   5  47 123 150  33  72  51 126  83 136  68  56 133 141  79  81  49 135  88  44 144 176 143<br />
 [55] 131  96 182  76  16   3 140 107 157  50 162 132  42  11  21 101  74  48 148 104 179  17  70 177 171 158  41<br />
 [82] 106  98 103  55  63  89 154 134 185 167  86  18 105 174  24 142  36  35 153 170  43  54 188   2 175 130  73<br />
[109]  60  67  20 187  27  62 138  85  29 119 149  91  37  82 124 163   4 127 121  15 115 118 110   7 189 114  97<br />
[136] 116  19  75  14 109 146 166 125  90  95 108  64  23 156 117 122  26 120  57 164 152 160  52  71   1  12 102<br />
[163] 111  30  40  28  99  22 168 100   8 161 151  65  66 183  69  93 180 184  39  46 169  59 155 137 113  92 173<br /><br />


merger2_ordered <- merger_filtered2[merger_filtered2_Ranking,]<br />
ranking is sorted in descending, but numbering on the far left is not ordered<br />
Output:<br />
tail(merger2_ordered )<br />
      X Ranking                                          Long.Name        Income.Group<br />
59  FSM     185                     Federated States of Micronesia Lower middle income<br />
155 STP     186 Democratic Republic of S\xe3o Tom\xe9 and Principe Lower middle income<br />
137 PLW     187                                  Republic of Palau Upper middle income<br />
113 MHL     188                   Republic of the Marshall Islands Lower middle income<br />
92  KIR     189                               Republic of Kiribati Lower middle income<br />
173 TUV     190                                             Tuvalu Lower middle income<br /><br />



rownames(merger2_ordered) <- 1:nrow(merger2_ordered)<br /><br />

#Filter records to only look at lower middle income<br />
lowmidInc <- merger2_ordered[ which(merger2_ordered$Income.Group=='Lower middle income'), ]<br /><br />



colnames(lowmidInc)<br />
[1] "X"            "Ranking"      "Long.Name"    "Income.Group"<br /><br />


 lowmidInc[which(lowmidInc$Ranking < 39),]<br />
     X Ranking                  Long.Name        Income.Group<br />
2  CHN       2 People's Republic of China Lower middle income<br />
10 IND      10          Republic of India Lower middle income<br />
16 IDN      16      Republic of Indonesia Lower middle income<br />
31 THA      31        Kingdom of Thailand Lower middle income<br />
38 EGY      38     Arab Republic of Egypt Lower middle income<br /><br />


