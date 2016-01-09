## Getting and Cleaning Data - Course Project
======
For this project we were to merge and tidy a set of accelerometor data gathered from subjects using a Samsung Galaxy S smartphone.
Originally the data was split into training and test data.  The data was merged into a single set, linked to the activity codes and the subject IDs.  The data is stored locally for use with the script.  The decision was made not to include code to download the data file.

### Naming Convention
I stripped out the parentheses, commas, and dashes.  For the sake of this assignment, I decided that the CamelCase naming of variables was acceptable and that I would not write extensive text parsing code to break up tBodyAcc into something like t.body.acc.  I also took the decision that period's were acceptable as delimiting segments of a variable name, since I had seen those in course lectures.  When dealing with naming conventions, there are always competing/contradicting rules and ideas and more often than not, consistency with some general common sense is sufficient.

### Source:
The data was downloaded from here on May 25th, 2014:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Libraries:
The script requires the installation of the following libraries:
* plyr: join() was used to map the activity ID to the activity description provided in the 'activity_labels.txt' file
* reshape2: melt()/dcast() were used to split up and then aggregate the data per activity/subject

### Script Description:
* load_features() - reads and 'cleans' the feature labels
* load_activities() - reads the activities for a data set AND loads the labels from 'activity_labels.txt'; it then joins to replace the ID with the label
* load_subjects() - simply loads the subjects for into a single column dataframe
* load_data_set() - the three files (data, activity, subjects) loads the data and merges into a single data frame
* merge_data() - pulls together the above to load both test and train data and rbind into a single data frame
* create_tidy_data() - summarises the data by activity/subject by calculating the mean

### Code Book:
Fields are described in the feature_info.txt included with the dataset.  In tidy_data.txt (which is a CSV file renamed to .TXT in order to circumvent the Coursera restriction on uploads, subject is the ID of the participant, activities is self-describing as the activity the subject was doing while the accelerometer data was read, and each subsequent variable is the mean of that datapoint per-participant/activity.
* subjects
* activities
* tBodyAcc.mean.X
* tBodyAcc.mean.Y
* tBodyAcc.mean.Z
* tBodyAcc.std.X
* tBodyAcc.std.Y
* tBodyAcc.std.Z
* tGravityAcc.mean.X
* tGravityAcc.mean.Y
* tGravityAcc.mean.Z
* tGravityAcc.std.X
* tGravityAcc.std.Y
* tGravityAcc.std.Z
* tBodyAccJerk.mean.X
* tBodyAccJerk.mean.Y
* tBodyAccJerk.mean.Z
* tBodyAccJerk.std.X
* tBodyAccJerk.std.Y
* tBodyAccJerk.std.Z
* tBodyGyro.mean.X
* tBodyGyro.mean.Y
* tBodyGyro.mean.Z
* tBodyGyro.std.X
* tBodyGyro.std.Y
* tBodyGyro.std.Z
* tBodyGyroJerk.mean.X
* tBodyGyroJerk.mean.Y
* tBodyGyroJerk.mean.Z
* tBodyGyroJerk.std.X
* tBodyGyroJerk.std.Y
* tBodyGyroJerk.std.Z
* tBodyAccMag.mean
* tBodyAccMag.std
* tGravityAccMag.mean
* tGravityAccMag.std
* tBodyAccJerkMag.mean
* tBodyAccJerkMag.std
* tBodyGyroMag.mean
* tBodyGyroMag.std
* tBodyGyroJerkMag.mean
* tBodyGyroJerkMag.std
* fBodyAcc.mean.X
* fBodyAcc.mean.Y
* fBodyAcc.mean.Z
* fBodyAcc.std.X
* fBodyAcc.std.Y
* fBodyAcc.std.Z
* fBodyAccJerk.mean.X
* fBodyAccJerk.mean.Y
* fBodyAccJerk.mean.Z
* fBodyAccJerk.std.X
* fBodyAccJerk.std.Y
* fBodyAccJerk.std.Z
* fBodyGyro.mean.X
* fBodyGyro.mean.Y
* fBodyGyro.mean.Z
* fBodyGyro.std.X
* fBodyGyro.std.Y
* fBodyGyro.std.Z
* fBodyAccMag.mean
* fBodyAccMag.std
* fBodyBodyAccJerkMag.mean
* fBodyBodyAccJerkMag.std
* fBodyBodyGyroMag.mean
* fBodyBodyGyroMag.std
* fBodyBodyGyroJerkMag.mean
* fBodyBodyGyroJerkMag.std

