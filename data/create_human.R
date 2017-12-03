rm(list=ls())
require(dplyr)
require(MASS)
#Read the "Human development" and "Gender inequality" data
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

str(hd)
str(gii)
dim(hd)
dim(gii)
summary(hd)
summary(gii)
#"GNI" = Gross National Income per capita
#"Life.Exp" = Life expectancy at birth
#"Edu.Exp" = Expected years of schooling 
#"Mat.Mor" = Maternal mortality ratio
#"Ado.Birth" = Adolescent birth rate
#"Parli.F" = Percetange of female representatives in parliament
#"Edu2.F" = Proportion of females with at least secondary education
#"Edu2.M" = Proportion of males with at least secondary education
#"Labo.F" = Proportion of females in the labour force
#"Labo.M" " Proportion of males in the labour force
#"Edu2.FM" = Edu2.F / Edu2.M
#"Labo.FM" = Labo2.F / Labo2.M
#"Rank"-HDI.Rank
#"HDI"-Human.Development.Index..HDI. 
#"MYE"-Mean.Years.of.Education
#"Difference"-GNI.per.Capita.Rank.Minus.HDI.Rank
#"GIRank"-Gender Inequality Index Rank
#"GII"-Gender.Inequality.Index
#"ABR"-Adolescent.Birth.Rate

names(hd)<-c("Rank","Country","HDI","Life.Exp" ,"Edu.Exp","MYE","GNI","Difference")
names(hd)
names(gii)<- c("GIRank","Country","GII","Mat.Mor","Ado.Birth","Parli.F","Edu2.F","Edu2.M","Labo2.F","Labo2.M")
names(gii)
gii <- mutate(gii,Edu2.FM=(Edu2.F/Edu2.M))
gii <- mutate(gii,Labo.FM=(Labo2.F/Labo2.M))

join_by <- c("Country")
human <- inner_join(hd,gii, by= join_by,suffix=c(".hd", ".gii"))
#transform the Gross National Income (GNI) variable to numeric
human <- transform(human, GNI= as.numeric(gsub(",", "", GNI)))
#Exclude unneeded variables
keep_col <-c("Country","Edu2.FM","Labo.FM","Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- dplyr::select(human, one_of(keep_col))
#Remove all rows with missing values
human <- filter(human,complete.cases(human))
#Define the row names of the data by the country names 
last <- nrow(human) - 7
human <- human[1:last, ]
rownames(human) <- human$Country
# remove the country name column
human <- dplyr::select(human, -Country)
#save the data as human.csv
write.table(human,"D:/GitHub/IODS-project/human.csv", sep=";", row.names = TRUE) 

