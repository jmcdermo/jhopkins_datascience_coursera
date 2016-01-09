# loads the file and enters it into a dataframe
load_data <- function() {
  heart_attack_idx <- 11
  heart_failure_idx <- 17
  pneumonia_idx <- 23
  
  # read in the data
  raw_data <- read.csv("data\\outcome-of-care-measures.csv", colClasses = "character")
  
  hospital_name_data <- raw_data[,2]
  state_data <- raw_data[,7]
  
  heart_attack <- as.numeric(raw_data[, heart_attack_idx])
  heart_failure <- as.numeric(raw_data[, heart_failure_idx])
  pneumonia <- as.numeric(raw_data[, pneumonia_idx])
  
  df <- data.frame(state_data, hospital_name_data, heart_attack, heart_failure, pneumonia, stringsAsFactors=FALSE)
  names(df) <- c('state_name', 'hospital', 'heart_attack', 'heart_failure', 'pneumonia')
  df
}

order_by <- function(df, field) {
  df <- df[order(df[[field]], df$hospital), ]
  df <- df[!is.na(df[[field]]), ]
  df
}

rankall <- function(outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  
  df <- load_data()
  
  split_by_state <- split(df, df$state_name)
  
  if (outcome == 'heart attack') {
    ordered <- lapply(split_by_state, order_by, 'heart_attack')    
  }
  else if (outcome == 'heart failure') {
    ordered <- lapply(split_by_state, order_by, 'heart_failure')    
  }
  else if (outcome == 'pneumonia') {
    ordered <- lapply(split_by_state, order_by, 'pneumonia')    
  }
  else {
    stop('invalid outcome')
  }
  
  if (num == 'best') {
    result <- lapply(ordered, function(x) head(x, 1)[, c('hospital', 'state_name')])
  }
  else if (num == 'worst') {
    result <- lapply(ordered, function(x) tail(x, 1)[, c('hospital', 'state_name')])
  }
  else {
    result <- lapply(ordered, function(x) x[num, c('hospital', 'state_name')])
  }

  output <- do.call("rbind", result)

  # hack to put state in completely
  names(output) <- c('hospital', 'state')
  output$state <- rownames(output)
  
  output
}