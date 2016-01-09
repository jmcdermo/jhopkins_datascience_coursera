setwd('C:\\Users\\jmcdermo\\Documents\\GitHub\\datasciencecoursera\\getting_cleaning_data\\week_four')

community_data <- read.csv('getdata-data-ss06hid.csv')

var_names <- colnames(community_data)
split <- strsplit(var_names, 'wgtp')
q1_answer <- split[123]

gdp <- read.csv('getdata-data-GDP.csv', skip=4)
gdp <- gdp[c(1, 4, 2, 5)]
colnames(gdp) <- c('CountryCode', 'LongName', 'Ranking', 'Economy')
gdp$Economy <- as.numeric(gsub(',','', gdp$Economy))
gdp <- gdp[gdp$CountryCode != '',]

avg_gdp <- mean(gdp$Economy, na.rm=TRUE)

# load in the educational data
edu <- read.csv('getdata-data-EDSTATS_Country.csv')

# merge with gdp
edu_gdp <- merge(edu, gdp, by = 'CountryCode', all=TRUE)

# fiscal year in june
june_fiscal <- length(grep('Fiscal year end:.*June.*', edu_gdp$Special.Notes))

# amazon day of week stuff
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
amzn_2012 <- amzn["2012-01-01/2012-12-31"]
weekday_2012 <- weekdays(index(amzn_2012))

# results
nrow(amzn["2012-01-01/2012-12-31"])
nrow(weekday_xts[])