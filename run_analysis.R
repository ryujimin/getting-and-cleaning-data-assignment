# if you run this code it extract mean and std data of this experiment
# before run this code you should set working directory where you unzip data.
# get_tidy_data : you can get mean and std of data
# avg_for_activities,avg_for_subject : get average of variables for each activities,subjects

get_tidy_data <- function(){
#load training data
x_train <- read.table('./UCI HAR Dataset/train/X_train.txt')
y_train <- read.table('./UCI HAR Dataset/train/y_train.txt')
subject_train <- read.table('./UCI HAR Dataset/train/subject_train.txt')

#load test data
x_test <- read.table('./UCI HAR Dataset/test/X_test.txt')
y_test <- read.table('./UCI HAR Dataset/test/y_test.txt')
subject_test <- read.table('./UCI HAR Dataset/test/subject_test.txt')

#load names of data
features <- read.table('./UCI HAR Dataset/features.txt')
activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt')

features <- as.character(features[,2])

#merge data
Merge_X <- rbind(x_train,x_test)
Merge_y <- rbind(y_train,y_test)
Merge_sub <- rbind(subject_train,subject_test)

colnames(Merge_X) <- features
colnames(Merge_y) <- 'activities'
colnames(Merge_sub) <- 'subject_num'

#extract mean and std mesurements
classifier <- grepl('mean()',colnames(Merge_X),fixed = TRUE) | grepl('std()',colnames(Merge_X), fixed = TRUE)
X <- Merge_X[,classifier]

#use descriptive activity names
Merge_y[,1] <- factor(Merge_y[,1])
levels(Merge_y[,1]) <- as.character(activity_labels[,2])

#get tidy data
TD <- cbind(X,Merge_y,Merge_sub)

TD
}

avg_for_activity <- function(){
    library(dplyr)
    i <- 0
    zeros <- matrix(0,length(unique(TD$activities)),length(colnames(TD))-2)
    TD_activities <- data.frame(zeros)
    for( a in unique(TD$activities)){
        i <- i + 1
        filtering <- filter(TD,TD$activities == a)
        for( j in 1:(length(filtering[1,])-2)){
            TD_activities[i,j] <- mean(filtering[,j])
        }
    }
    
    rownames(TD_activities) <- as.character(unique(TD$activities))
    colnames(TD_activities) <- colnames(TD[,1:(length(colnames(TD))-2)])
    
    TD_activities
}

avg_for_subject <- function(){
    library(dplyr)
    zeros <- matrix(0,length(unique(TD$subject_num)),length(colnames(TD))-2)
    TD_subject_num <- data.frame(zeros)
    for( a in unique(TD$subject_num)){
        filtering <- filter(TD,TD$subject_num == a)
        for( j in 1:(length(filtering[1,])-2)){
            TD_subject_num[a,j] <- mean(filtering[,j])
        }
    }
    
    rownames(TD_subject_num) <- as.character(unique(TD$subject_num))
    colnames(TD_subject_num) <- colnames(TD[,1:(length(colnames(TD))-2)])
    
    TD_subject_num
}


