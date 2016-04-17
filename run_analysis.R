## Libraries

library(data.table)
library(dplyr)
library(plyr)

## Getting and Cleaning Data Project Assignment

rm(list = ls())
workdir <- "C:/data/R/coursera/getting and cleaning data/"
projdir <- "C:/data/R/coursera/getting and cleaning data/UCI HAR Dataset/" 
setwd(workdir)

## read the activity labels and features; test dimensions with dim()
setwd(projdir)
activities <- read.table("activity_labels.txt")	#   6 rows, 2 columns
features   <- read.table("features.txt")			# 561 rows, 2 columns

## set appropriate column names
names(activities) <- c("act_label", "activity")
names(features)   <- c("feat_label", "feature")

## read the training data set (labels, subjects, data)
setwd("./train/")
train_activity <- read.table("y_train.txt")
train_data     <- read.table("X_train.txt")
train_subject  <- read.table("subject_train.txt")
setwd(projdir)

## read the test data set (labels, subjects, data)
setwd("./test/")
test_activity <- read.table("y_test.txt")
test_data     <- read.table("X_test.txt")
test_subject  <- read.table("subject_test.txt")
setwd(projdir)

## merge the data sets; test dimensions with dim()
all_data <- rbind(train_data, test_data)		 # 10299 rows, 561 columns
all_actv <- rbind(train_activity, test_activity) # 10299 rows,   1 column
all_subj <- rbind(train_subject, test_subject)	 # 10299 rows,   1 column

## set appropriate column names
names(all_actv) <- c("act_label")
names(all_subj) <- c("subject")
names(all_data) <- as.vector(features$feature)

## subset all_data with only the columns having a mean or standard deviation (std)
colset <- sort(union(grep("std\\(\\)", features[,2]),grep("mean\\(\\)",features[,2]))) ## number of features: 66
all_data <- all_data[, colset]

## combine data sets into one using cbind
all_data <- cbind(all_data, all_actv, all_subj)	# 10299 rows, 68 columns

## include the actual activity description, joining in the activities data frame
all_data <- join(all_data, activities, by="act_label")

## remove the act_label column
all_data <- subset( all_data, select = -act_label )

## calculcate the average for all variables per activity and per subject
avg_vals <- ddply(all_data, c("activity", "subject"), numcolwise(mean)) # 6 activities, 30 subjects, i.e. 180 rows, 68 columns

## write the new data set called avg_vals to a file on disk in the working directory 
setwd(workdir)
write.table(avg_vals, "all_data_averaged.txt", row.name=FALSE)
