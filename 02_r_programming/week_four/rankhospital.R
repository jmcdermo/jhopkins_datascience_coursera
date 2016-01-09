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

rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  df <- load_data()
  
  if (!state %in% df$state_name) {
    stop('invalid state')
  }
  
  split_by_state <- split(df, df$state_name)
  my_state <- split_by_state[[state]]
  
  if (outcome == 'heart attack') {
    my_state <- my_state[order(my_state$heart_attack, my_state$hospital), ]
    my_state <- my_state[!is.na(my_state$heart_attack), ]
  }
  else if (outcome == 'heart failure') {
    my_state <- my_state[order(my_state$heart_failure, my_state$hospital), ]
    my_state <- my_state[!is.na(my_state$heart_failure), ]
  }
  else if (outcome == 'pneumonia') {
    my_state <- my_state[order(my_state$pneumonia, my_state$hospital), ]
    my_state <- my_state[!is.na(my_state$pneumonia), ]
  }
  else {
    stop('invalid outcome')
  }
  
  # add the rank column
  my_state$rank <- 1:nrow(my_state)
  
  if (num == 'best') {
    result <- head(my_state, 1)$hospital
  }
  else if (num == 'worst') {
    result <- tail(my_state, 1)$hospital    
  }
  else {
    result <- my_state[num, ]$hospital
  }
  result 
}