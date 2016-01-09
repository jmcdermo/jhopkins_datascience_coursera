# jmcdermo coursera datascience assignment 1 question 3
corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  
  # could get clever here and do some string parsing to load only the CSV's based on the IDs that we
  # actually want to process, but on the other hand.. why bother?
  source('complete.R')
  
  full_path <- paste(getwd(), directory, sep="/")
  filenames <- list.files(full_path, pattern="*.csv", full.names=TRUE)
  polData <- lapply(filenames, read.csv)
  complete_only <- lapply(polData, function(x) x[complete.cases(x), ])
  
  # filter the IDs into a list where the number of observations is bigger than threshold
  nonNAs <- complete(directory)
  nonNAs <- nonNAs[nonNAs$nobs > threshold, ]

  # now filter the main data by the list of IDs that match this threshold
  matching <- lapply(complete_only, function(x) x[x$ID %in% nonNAs$id, ] )
  matching <- matching[sapply(matching, function(x) dim(x)[1]) > 0]
  
  cr <- lapply(matching, function(x) cor(x$sulfate, x$nitrate) )
  unlist(cr)
}