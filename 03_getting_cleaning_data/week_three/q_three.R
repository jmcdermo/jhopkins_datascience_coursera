setwd('C:\\Users\\jmcdermo\\Documents\\GitHub\\datasciencecoursera\\getting_cleaning_data\\week_three')

# get and tidy GDP 
# -- scrub rows with no country code
# -- convert numbers to numbers for GDP (Economy)
# -- 
gdp <- read.csv('getdata-data-GDP.csv', skip=4, nrows=231)
gdp <- gdp[c(1, 2, 5)]
colnames(gdp) <- c('CountryCode', 'Ranking', 'Economy')
gdp$Economy <- as.numeric(gsub(',','', gdp$Economy))
gdp <- gdp[gdp$CountryCode != '',]

# load in the educational data
edu <- read.csv('getdata-data-EDSTATS_Country.csv')

# merge with gdp
edu_gdp <- merge(edu, gdp, by = 'CountryCode', all=TRUE)

# how many ids match?
num_matches <- sum(!is.na(unique(edu_gdp$Economy)))

# now sort
ordered <- with(edu_gdp, order(Ranking, decreasing=TRUE))
edu_gdp[ordered, c('CountryCode', 'Ranking', 'Economy', 'Long.Name')][13,]

# get the grouped mean
aggregate(edu_gdp$Ranking, by=list(edu_gdp$Income.Group), FUN=mean, na.rm=TRUE)

# 