# Julia Hellstrand
# 25.11.2019
# This script includes the Data wrangling task to Exercise 4.

# Read the “Human development” data set
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

# Read the “Gender inequality” data set
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# The structure and dimensions of the data
str(hd)
dim(hd)
summary(hd)

# The Human development data set includes 195 observations of 8 variables.

str(gii)
dim(gii)
summary(gii)

# The Gender inequality data set includes 195 observations of 10 variables.

# Rename the variables with (shorter) descriptive names
names(hd)[names(hd) =="Human.Development.Index..HDI."] <- "HDI"
names(hd)[names(hd) =="Life.Expectancy.at.Birth"] <- "LEaB"
names(hd)[names(hd) =="Expected.Years.of.Education"] <- "EYoE"
names(hd)[names(hd) =="Mean.Years.of.Education"] <- "MYoE"
names(hd)[names(hd) =="Gross.National.Income..GNI..per.Capita"] <- "GNIpC"
names(hd)[names(hd) =="GNI.per.Capita.Rank.Minus.HDI.Rank"] <- "GNIpC_HDIr"

names(gii)[names(gii) =="Gender.Inequality.Index..GII."] <- "GII"
names(gii)[names(gii) =="Maternal.Mortality.Ratio"] <- "MMR"
names(gii)[names(gii) =="Adolescent.Birth.Rate"] <- "ABR"
names(gii)[names(gii) =="Percent.Representation.in.Parliament"] <- "PRP"
names(gii)[names(gii) =="Population.with.Secondary.Education..Female."] <- "PSEf"
names(gii)[names(gii) =="Population.with.Secondary.Education..Male."] <- "PSEm"
names(gii)[names(gii) =="Labour.Force.Participation.Rate..Female."] <- "LFPRf"
names(gii)[names(gii) =="Labour.Force.Participation.Rate..Male."] <- "LFPRm"

# Create a new variable: the ratio of Female and Male populations with secondary education
gii <- mutate(gii, SE_fm_ratio = PSEf / PSEm)

# Create a new variable: the ratio of labour force participation of females and males
gii <- mutate(gii, LFPR_fm_ratio = LFPRf / LFPRm)

# Join the two datasets
human <- inner_join(gii, hd, by = c("Country"))
str(human)

# Set working directory
setwd("Z:\\IODS\\IODS\\data")

# Save the dataset in the data folder
write.csv(human, file="human.csv")
