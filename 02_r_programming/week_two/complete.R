# jmcdermo assignment 2 question 2 for coursera data science 
complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete casesc
  full_path <- paste(getwd(), directory, sep="/")
  filenames <- list.files(full_path, pattern="*.csv", full.names=TRUE)
  polData <- lapply(filenames, read.csv)

  # apply complete.cases to get non NA rows
  complete_only <- lapply(polData, function(x) x[complete.cases(x), ])
  
  # do the same to get lens and IDs; unlist to get a vector
  lens <- lapply(complete_only, nrow)
  ids <- lapply(complete_only, function(x) x[['ID']][1])

  df <- data.frame(unlist(ids), unlist(lens))
  names(df) <- c('id', 'nobs')
  df[id, ]
}