# getting-and-cleaning-data-assignment

original data of this experiment is https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##get mean and std of the data

1. load the training and test data using read.table function/

2. load names of data.

3. merge train data and test using rbind function.

4. set names of data.

5. Extract mean and std measurement using grepl function.

6. merge X,y and subject_num using cbind function.

##get average of each variable for each activities

1. filter for each activities using filter function(in dplyr library)

2. get average for each variable.

3. return piece together data frame of 2.

##get average of each variable for each subject

1. filter for each subjects using filter function(in dplyr library)

2. get average for each variable.

3. return piece together data frame of 2.
