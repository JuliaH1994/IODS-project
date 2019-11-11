# Julia Hellstrand
# 11.11.2019
# This script includes the answers to Exercise 2.

# 1
# Folder created

# 2
# read the data
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# explore the structure.. 
str(lrn14)

# and dimensions of the data.
dim(lrn14)

# The data consists of 183 observations and 60 variables
# -> dim 183 rows and 60 columns

# 3
# Install and access the dplyr library
#install.packages("dplyr")
#library(dplyr)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# choose a handful of columns to keep
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

# create an analysis data set with the chosen varialbles
analysis_dataset <- select(lrn14, one_of(keep_columns))

# select obs, with points >0
analysis_dataset <- filter(analysis_dataset, Points > 0)
dim(analysis_dataset)

# 4
# Set working directory
setwd("Z:\\IODS\\IODS\\data")

# Save the dataset in the data folder
write.csv(analysis_dataset, file="learning2014.csv")

# Read the data again
data <- read.csv("Z:\\IODS\\IODS\\data\\learning2014.csv")

# An extra column occured for some reason?
data <- data[,2:8]
head(data)
dim(data)
str(data)
summary(data)

# access the GGally and ggplot2 libraries
# install.packages("GGally")
# install.packages("ggplot2")
# library(GGally)
# library(ggplot2)

# create a more advanced plot matrix with ggpairs()
p <- ggpairs(data, mapping = aes(), lower = list(combo = wrap("facethist", bins = 20)))
p

lm1 <- lm(Points ~ Attitude + stra + surf, data=data)
summary(lm1)

lm2 <- lm(Points ~ Attitude, data=data)
summary(lm2)



