## Getting and Cleaning Data Project Assignment

Steps in the code

# Step 1 - Preparation - directories and libraries
The working directory is set to the root project folder of the data set "UCI HAR Dataset".
Required libraries are data.table, dplyr and plyr

# Step 2 - Read the activity labels and features; test dimensions with dim().
First read the activity labels and the features in the main folder of the data set.
These are large data sets so read.table is used.
Set appropriate column names

## Step 3 - Read the Training and Test data sets (labels, subjects, data) in the corresponding subfolders. The Intertial Data is not included. The assignment was not clear about that. Since this would be more of the same and the related business problem and objective are unknown, these subfolders have been excluded from the exercise. 

## Step 4 - Merge the data sets
Test and Training data sets are stacked (union) together
The feature data set is used to set appropriate column names for the measurements.
These column headers are explained in more detail in the file features_info.txt in the original data set.

## Step 5 - Subsetting the data set
All columns reflecting an average or a standard deviation are selected from the features data frame and used to subset the all_data data frame.

## Step 6 - Add subjects and activities to the data set
First combine (using cbind) the three data frames.
Subsequently join in the activity names using act_label
Finally remove the act_label column.

## Step 7 Calculcate the average for all variables per activity and per subject
This step aggregates the data set by grouping on subject and activity. For each unique combination of subject and activity there should be one record containing the mean (average) for all measurements.

## Step 8 - Finally write the resulting data frame to a text file in the working directory
