# Julia Hellstrand
# 15.11.2019
# 3. Logistic regression: Data wrangling
# Data source: https://archive.ics.uci.edu/ml/machine-learning-databases/00320/

# Read data
student_mat <- read.table(file = "clipboard", 
              sep = "\t", header=TRUE, dec=",")
student_por <-read.table(file = "clipboard", 
              sep = "\t", header=TRUE, dec=",")

# Explore the structure and dimensions of data
dim(student_mat) # 395 obs. of 33 variables
dim(student_por) # 649 obs. of 33 variables
str(student_mat)
str(student_por)  # Variables are integers (e.g. age) and factors (e.g. school)

# Join the two data sets 
# access the dplyr library
library(dplyr)

# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# join the two datasets by the selected identifiers
mat_por <- inner_join(student_mat, student_por, by = join_by)

# Explore the structure and dimensions of the joined data
dim(mat_por) # 382 obs. of 53 variables
str(mat_por) # Same as previously, but many duplicates

# copy the solution from the DataCamp exercise The if-else structure to combine the 'duplicated' answers in the joined data
# create a new data frame with only the joined columns
alc <- select(mat_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(student_mat)[!colnames(student_mat) %in% join_by]

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'mat_por' with the same original name
  two_columns <- select(mat_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# Glimpse at the joined and modified data
glimpse(alc) # 382 obs. of 35 variables

# Save the joined and modified data
write.csv(alc, file = "data/alc.csv", row.names = FALSE)