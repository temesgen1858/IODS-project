#Name: Abera Temesgen
#Date: 19/11/2017
#About dataset: the data contain information about student performace and alcohol consumption
#Link to data soruce:https://archive.ics.uci.edu/ml/datasets/Student+Performance

#Read the data
math <-read.table("D:/GitHub/IODS-project/student-mat.csv",sep = ";", header = TRUE)
por <-read.table("D:/GitHub/IODS-project/student-por.csv",sep = ";", header = TRUE)
#Explore structure and dimensions
str(math)
str(por)
dim(math)
dim(por)
#Join the two dataset and explore the structure and dimensions
library(dplyr)
join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")
math_por <- inner_join(math,por, by= join_by,suffix=c(".math", ".por"))
str(math_por)
dim(math_por)
#Combine the duplicated answers in the joined data
alc <- select(math_por, one_of(join_by))
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
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
# create a new column(alc_use) by taking average of weekday and weekedn alcoho consumption
alc <- mutate(alc,alc_use=(Dalc +Walc)/2)
# create a new colum "high_use" for students with alc_use > 2
alc <- mutate(alc,high_use=alc_use >2)
#Glimpse the data
glimpse(alc)
#save the modified data
write.table(alc,"D:/GitHub/IODS-project/stu_alc_consu.csv", sep=";")

