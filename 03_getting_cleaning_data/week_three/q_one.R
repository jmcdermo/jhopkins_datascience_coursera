setwd('C:\\Users\\jmcdermo\\Documents\\GitHub\\datasciencecoursera\\getting_cleaning_data\\week_three')
data <- read.csv('getdata-data-ss06hid.csv')
which(with(data, AGS==6 & ACR==3))
