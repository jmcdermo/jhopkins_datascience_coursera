library('sqldf')
setwd('C:\\Users\\jmcdermo\\Documents\\GitHub\\datasciencecoursera\\getting_cleaning_data\\week_two')
acs <- read.csv('getdata-data-ss06pid.csv')
sqldf("select pwgtp1 from acs where AGEP < 50")