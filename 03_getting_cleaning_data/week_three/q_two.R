setwd('C:\\Users\\jmcdermo\\Documents\\GitHub\\datasciencecoursera\\getting_cleaning_data\\week_three')
library('jpeg')
data <- readJPEG('getdata-jeff.jpg', native=TRUE)
quants <- quantile(data, probs=c(0.3, 0.8))
