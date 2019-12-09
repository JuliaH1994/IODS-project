# Julia Hellstrand
# 5.12.2019
# This script includes the Data wrangling task to Exercise 5.

# Links to the original data sources: 
# https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt
# https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt


# Load the data sets (BPRS and RATS)
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt"
           , header=TRUE)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt"
           ,sep="\t", header=TRUE)


# Take a look at the data sets
# BPRS
str(BPRS) # 40 obs. of  11 variables. All variables are integers.
summary(BPRS) # "treatment" takes two values, 1 and 2, one for each treatment group. "subject" takes values from 1 to 
# 20. Within each group every individual has their their own number. The variables "week*" are measurements for the 
# individuals for each week, and take values between 18 to 95.

# RATS
str(RATS) # 16 obs. of  13 variables. All variables are integers.
summary(RATS) # "ID2 takes values from 1 to 16, one for each rat. "Group" takes three values 1,2,3, one for each group
# of rats. The variables "WD**" are measurements for the rats for each measurement point, and take values between
# 225 and 628.

# In the wide format, each measurement point is represented by its own variable (column).


# Convert the categorical variables of both data sets to factors.
# Factor treatment & subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Factor variables ID and Group
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)


# Convert the data sets to long form. Add a week variable to BPRS and a Time variable to RATS.
library(dplyr)
library(tidyr)

# Convert BPRS to long form
BPRSL <-  BPRS %>% 
  gather(key = weeks, value = bprs, -treatment, -subject) %>%
  mutate(week = as.integer(substr(weeks,5,5)))

# Convert RATS to long form
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4)))


# Take a look at the data sets in long form
str(BPRSL) # 360 obs. of  5 variables. The variables are factors, characters, and integers.
summary(BPRSL) # "treatment" takes two values, 1 and 2, one for each treatment group. "subject" takes values from 
# 1 to 20. Within each group every individual has their their own number. The weekly measurments are now found in 
# variable "week" (or "weeks"). The new variable bprs takes values between 18 to 95.

# RATS
str(RATSL) # 176 obs. of  5 variables. The variables are factors, characters, and integers.
summary(RATSL) # "ID2 takes values from 1 to 16, one for each rat. "Group" takes three values 1,2,3, one for each 
# group of rats. The measurments are now found in variable "Time" (or "WD"). The new variable "Weight" takes
# values between 225 and 628.

# In the long format, all the measurement points are represented by only own variable.

# Note: the number of observations (bprs and Weight) is the same in both forms. 
# BPRS in wide form: 40 obs * 9 var (week*) = 360
# BPRS in long form: 360 obs * 1 var (week) = 360
# RATS in wide form: 16 obs * 11 var (WD**) = 176
# RATS in long form: 176 obs * 1 var (Time) = 176

# Save the data sets in your data folder.
setwd("Z:\\IODS\\IODS\\data")
write.csv(BPRS, file = "BPRS.csv", eol = "\r", na = "NA", row.names = FALSE)
write.csv(RATS, file = "RATS.csv", eol = "\r", na = "NA", row.names = FALSE)
write.csv(BPRSL, file = "BPRSL.csv", eol = "\r", na = "NA", row.names = FALSE)
write.csv(RATSL, file = "RATSL.csv", eol = "\r", na = "NA", row.names = FALSE)

