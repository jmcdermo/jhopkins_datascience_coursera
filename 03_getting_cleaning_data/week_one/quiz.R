prep_data <- function() {
  setwd('C:\\Users\\jmcdermo\\Documents\\GitHub\\datasciencecoursera\\getting_cleaning_data')
  if (!file.exists('housing_data.csv')) {
    download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv',
                  destfile='housing_data.csv')
  }
  data <- read.csv('housing_data.csv')
  data
}

prep_excel <- function() {
  setwd('C:\\Users\\jmcdermo\\Documents\\GitHub\\datasciencecoursera\\getting_cleaning_data')
  library('xlsx')
  if (!file.exists('natgas.xlsx')) {
    download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx',
                  destfile='natgas.xlsx')
  }
  
  rows = 18:23
  cols = 7:15
  dat <- read.xlsx('natgas.xlsx', sheetIndex=1, rowIndex=rows, colIndex=cols)
}

prep_xml <- function() {
  setwd('C:\\Users\\jmcdermo\\Documents\\GitHub\\datasciencecoursera\\getting_cleaning_data')
  library('XML')
  if (!file.exists('restaurants.xml')) {
    download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml',
                  destfile='restaurants.xml')
  }
  
  dat <- xmlTreeParse('restaurants.xml', useInternal=TRUE)
}

prep_fread <- function() {
  setwd('C:\\Users\\jmcdermo\\Documents\\GitHub\\datasciencecoursera\\getting_cleaning_data')
  if (!file.exists('idaho.csv')) {
    download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv ',
                  destfile='idaho.csv')
  }
  
  DT <- data.table::fread('idaho.csv')
  
  DT
}

time_trial <- function(DT) {
  trial_size <- 300
  collected_results <- numeric(trial_size)
  for (i in 1:trial_size){
    single_function_time <- system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
    collected_results[i] <- single_function_time[1]
  }
  print(mean(collected_results))  
}