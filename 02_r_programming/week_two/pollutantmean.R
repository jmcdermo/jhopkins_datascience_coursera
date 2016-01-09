# jmcdermo - assignment 2 question 1 for coursera data science 
pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  
  # append the directory to the CWD
  full_path <- paste(getwd(), directory, sep="/")
  filenames <- list.files(full_path, pattern="*.csv", full.names=TRUE)
  polData <- lapply(filenames, read.csv)
  
  myData <- do.call("rbind", polData)
  
  # for the ids
  mean(myData[myData$ID %in% id, ][[pollutant]], na.rm=TRUE)
}