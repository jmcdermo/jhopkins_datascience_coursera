setwd('C:\\Users\\jmcdermo\\Documents\\GitHub\\datasciencecoursera\\getting_cleaning_data\\week_two')

dat <- read.fwf('getdata-wksst8110.for',
                c(16, 3, 4, 9, 4, 9, 4),
                header=FALSE,
                skip=4)

