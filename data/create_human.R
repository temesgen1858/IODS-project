#Read the "Human development" and "Gender inequality" data
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

str(hd)
str(gii)
dim(hd)
dim(gii)
summary(hd)
summary(gii)

#"Rank" -HDI.Rank
#"HDI" -Human.Development.Index..HDI. 
#"LEB" -Life.Expectancy.at.Birth  
#"EYE"-Expected.Years.of.Education
#"MYE"-Mean.Years.of.Education
#"GNI" -Gross.National.Income..GNI..per.Capita
#"Difference"-GNI.per.Capita.Rank.Minus.HDI.Rank
#"GIRank"-Gender Inequality Index Rank
#"GII"-Gender.Inequality.Index
#"MMR"-Maternal.Mortality.Ratio
#"ABR"-Adolescent.Birth.Rate
#"PRP"-Percent.Representation.in.Parliament
#"PSEF"-Population.with.Secondary.Education..Female.
#"PSEM"-Population.with.Secondary.Education..Male.,
#"LFPRF"-Labour.Force.Participation.Rate..Female.
#"LFPRM"-Labour.Force.Participation.Rate..Male.
names(hd)<-c("Rank","Country","HDI","LEB" ,"EYE","MYE","GNI","Difference")
names(hd)
names(gii)<- c("GIRank","Country","GII","MMR","ABR","PRP","PSEF","PSEM","LFPRF","LFPRM")
names(gii)
gii <- mutate(gii,RatioFM=(PSEF/PSEM))
gii <- mutate(gii,RatioLABFM=(LFPRF/LFPRM))

join_by <- c("Country")
human <- inner_join(hd,gii, by= join_by,suffix=c(".hd", ".gii"))
write.table(human,"D:/GitHub/IODS-project/human.csv", sep=";")

