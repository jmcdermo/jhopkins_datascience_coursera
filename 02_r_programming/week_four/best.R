# assignment for week 4
best <- function(state, outcome) {
  raw_data <- read.csv("data\\outcome-of-care-measures.csv", colClasses = "character")

  heart_attack_idx <- 11
  heart_failure_idx <- 17
  pneumonia_idx <- 23
  
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  state_data <- raw_data[,7]
  hospital_name_data <- raw_data[,2]
  if (!state %in% state_data) {
    stop('invalid state')
  }
  
  if (outcome == 'heart attack') {
    outcome_data <- as.numeric(raw_data[, heart_attack_idx])
  }
  else if (outcome == 'heart failure') {
    outcome_data <- as.numeric(raw_data[, heart_failure_idx])
  }
  else if (outcome == 'pneumonia') {
    outcome_data <- as.numeric(raw_data[, pneumonia_idx])    
  }
  else {
    stop('invalid outcome')
  }
  
  # build the dataframe
  df <- data.frame(state_data, hospital_name_data, outcome_data)
  names(df) <- c('state_name', 'hospital', 'mortality')
  
  # drop na
  df <- df[complete.cases(df), ]

  # get only my state
  df <- df[df$state_name == state, ]
  
  # max
  max_row <- df[df$mortality <= min(df$mortality, na.rm=TRUE), ]
  
  as.character(max_row[2]$hospital)
}
