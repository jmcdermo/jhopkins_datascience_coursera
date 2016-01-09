setwd('C:\\Users\\jmcdermo\\Documents\\GitHub\\datasciencecoursera\\getting_cleaning_data\\course_project')

load_features <- function() {
  # load up the features list
  feature_desc <- read.table('UCI HAR Dataset\\features.txt')
  feature_desc <- as.character(feature_desc[[2]])
  
  # clean up the variable names removing bad characters
  feature_desc <- gsub('\\(\\)|\\(', '', feature_desc)
  feature_desc <- gsub(',|-|\\)', '.', feature_desc)
  feature_desc
}

load_activities <- function(activities_file) {
  # loads the activities key into a dataframe and cleans the text up
  activities_desc <- read.table('UCI HAR Dataset\\activity_labels.txt')
  activities_desc[2] <- tolower(activities_desc[[2]])
  activities_desc[2] <- gsub('_', '.', activities_desc[[2]])
  colnames(activities_desc) <- c('activity_id', 'activity')
  
  # load the particular activities for this data set
  activities <- read.table(activities_file)
  colnames(activities) <- c('activity_id')
  
  # using the plyr library, convert the number (activity ID) into a more
  # readable factor
  library(plyr)
  activities <- join(activities, activities_desc, by = 'activity_id')
  activities
}

load_subjects <- function(file) {
  subjects <- read.table(file, comment.char = "", colClasses="numeric")
  subjects
}

load_data_set <- function(data_file, activities_file, subjects_file) {
  # load the features
  features <- load_features()
  
  # load the primary data
  data <- read.table(data_file)
  
  # load the activities
  activities <- load_activities(activities_file)
  
  # load the subjects
  subjects <- load_subjects(subjects_file)
  
  # combine them into a single dataset
  data <- cbind(data, subjects, activities$activity)
  colnames(data) <- c(features, 'subjects', 'activities')
  
  # grab only columns relating to mean + std deviation
  # -- the grep looks for mean or std AT THE END OF THE LINE
  # -- I intentionally wanted to skip the variables like meanFreq
  # -- so the regular expression is as follows:
  #     - ends with 'mean' or ends with 'std'
  #     - ends with 'mean.?' for the mean.X, mean.Y, and mean.Z (same for std.?)
  #     - is our added columns of subjects or activities
  regexp <- 'mean$|std$|mean\\..$|std\\..$|subjects|activities'
  data <- subset(data, select=(names(data)[grep(regexp,names(data))]))
  
  data
}

merge_data <- function() {
  # load up the data files (rows with 561 columns matching the features)
  test_data <- load_data_set('UCI HAR Dataset\\test\\X_test.txt',
                             'UCI HAR Dataset\\test\\Y_test.txt',
                             'UCI HAR Dataset\\test\\subject_test.txt')
  train_data <- load_data_set('UCI HAR Dataset\\train\\X_train.txt',
                              'UCI HAR Dataset\\train\\Y_train.txt',
                              'UCI HAR Dataset\\train\\subject_train.txt')
  
  # merge the two sets
  data <- rbind(test_data, train_data)
  data
}

create_small_data <- function(data) {
  regexp <- 'subjects|activities|tBodyAcc.mean.X|tBodyAcc.mean.Y|tBodyAcc.mean.Z'  
  small_data <- subset(data, select=(names(data)[grep(regexp,names(data))]))
  small_data
}

create_tidy_data <- function() {
  # load up the merged data
  data <- merge_data()
  
  # split up the data frame by subject + activity
  # -- melt reshapes the data into subject, activity, variable (e.g. tBodyAcc.mean.X), value
  # -- dcast reshapes the data back to our original format but applies the fun.aggregate 
  library(reshape2)
  melted <- melt(data, c('subjects', 'activities'))
  tidy <- dcast(melted, ... ~ variable, fun.aggregate = mean)
  tidy
}

write.csv(create_tidy_data(), 'tidy_data.csv')