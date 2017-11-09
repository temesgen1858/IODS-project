#Abera Temesgen
#09/11/2017
#Regression and model validation exercise based on survey data from ASSIST (http://www.etl.tla.ed.ac.uk/publications.html#measurement)
# and SATS(http://www.evaluationandstatistics.com/)
library(dplyr)
mydata<- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt",header = TRUE,sep="\t")
str(mydata)
dim(mydata)
# The survey data contains information about approaches and study skills, and attitudes toward statistics. In total, 183 observations of 60 variables are included in the data.
Deep_questions<- c("D03","D11","D19", "D27", "D07", "D14", "D22","D30","D06", "D15", "D23", "D31")
deep_column<- select(mydata, one_of(Deep_questions))
strategic_questions<-c("ST01" , "ST09", "ST17", "ST25","ST04","ST12", "ST20", "ST28")
strategic_column<-select(mydata, one_of(strategic_questions))
surface_questions<-c("SU02" , "SU10" ,"SU18" , "SU26" , "SU05" , "SU13" , "SU21" , "SU29" , "SU08" , "SU16" , "SU24" , "SU32")
surface_column<-select(mydata, one_of(surface_questions))
#data scaling
mydata$deep<-rowMeans(deep_column)
mydata$stra<-rowMeans(strategic_column)
mydata$surf<-rowMeans(strategic_column)
my_columns <- c("gender","Age","Attitude","Points","deep","stra","surf")
#selecting analysis data
AnalysisData <- select(mydata, one_of(my_columns))
#exclude data with points variable value equals 0
Analysis2014 <- filter(AnalysisData, Points > 0)
#Set working directory
setwd("D:/GitHub/IODS-project")
#save the data
write.table(Analysis2014,"D:/GitHub/IODS-project/data/learning2014.txt", sep=",")

#read file
read_data<- read.table("D:/GitHub/IODS-project/data/learning2014.txt", header=TRUE, sep=",")
str(read_data)
head(read_data)
