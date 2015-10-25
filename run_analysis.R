# File: run_analysis.R
# Desc: Coursera Course- Getting and Cleaning Data (Course Project)
# Date: 10/25/2015
# ----------------------------------------------------------------------------

#library(dplyr)

# ----------------------------------------------------------------------------
# 0: Read the Data
# ----------------------------------------------------------------------------

# Column names for the data
features = read.table("./UCI HAR Dataset/features.txt", 
                      header = FALSE,
                      sep = " ",
                      stringsAsFactors = FALSE,
                      col.names = c("col", "col_name"))

# Look up table for activities
activities = read.table("./UCI HAR Dataset/activity_labels.txt", 
                        header = FALSE,
                        sep = " ",
                        stringsAsFactors = FALSE,
                        col.names = c("act_id", "act_name"))


test_subjects = read.table("./UCI HAR Dataset/test/subject_test.txt", 
                            header = FALSE,
                            sep = " ",
                            stringsAsFactors = FALSE,
                            col.names = c("subject"),
                            colClasses = c("integer"))

test_activities = read.table("./UCI HAR Dataset/test/y_test.txt", 
                           header = FALSE,
                           sep = " ",
                           stringsAsFactors = FALSE,
                           col.names = c("act_id"),
                           colClasses = c("integer"))


# test_data = read.table("./UCI HAR Dataset/test/X_test.txt", 
#                         header = FALSE,
#                         sep = "",
#                         stringsAsFactors = FALSE)


train_subjects = read.table("./UCI HAR Dataset/train/subject_train.txt", 
                      header = FALSE,
                      sep = " ",
                      stringsAsFactors = FALSE,
                      col.names = c("subject"),
                      colClasses = c("integer"))


train_activities = read.table("./UCI HAR Dataset/train/y_train.txt", 
                             header = FALSE,
                             sep = " ",
                             stringsAsFactors = FALSE,
                             col.names = c("act_id"),
                             colClasses = c("integer"))


# train_data = read.table("./UCI HAR Dataset/train/X_train.txt", 
#                        header = FALSE,
#                        sep = "",
#                        stringsAsFactors = FALSE)




# ----------------------------------------------------------------------------
# 1: Merge the training and the test sets to create one data set.
# ----------------------------------------------------------------------------

# Add the Activity Label to the Test & Train Activities by Merging with
# activities
test_activities_2 <- merge(test_activities, activities, by = "act_id" )
train_activities_2 <- merge(train_activities, activities, by = "act_id" )

# Merge the Subject, Activitiesand the Test/Train Datasets
test_data_2 <- cbind(test_subjects, test_activities_2, test_data)
train_data_2 <- cbind(train_subjects, train_activities_2, train_data)

# Assign Descriptive Column Names 
colnames(test_data_2) <- c("subject", "act_id", "act_name", features$col_name)
colnames(train_data_2) <- c("subject", "act_id", "act_name", features$col_name)

# Combine the Test & Train Data

all_data <- rbind(test_data_2, train_data_2)



# ----------------------------------------------------------------------------
# 2: Extract only the measurements on the mean and standard deviation
#    for each measurement. 
# ----------------------------------------------------------------------------
# Please Note:
#    1) Mean and Standard Dev. cols are idenfieid by finding the "mean" and
#       "std" patterns in the column names
#    2) In addition to the mean/std colums, the first 4 columns are also included

# Get a vector of interested columns
cols <- grep("data_type|subject|act_id|act_name|mean|std", colnames(all_data))

# Extract only the Mean and Standard Deviation Measurements
mean_std_data <- all_data[,cols]

# ----------------------------------------------------------------------------
# 3: Use descriptive activity names to name the activities in the data set
# ----------------------------------------------------------------------------

# This is already done in step 1

# ----------------------------------------------------------------------------
# 4: Appropriately label the data set with descriptive variable names. 
# ----------------------------------------------------------------------------

# This is also already done in step 1


# ----------------------------------------------------------------------------
# 5: From the data set in step 4, create a second, independent tidy data 
#    set with the average of each variable for each activity and each subject.
# ----------------------------------------------------------------------------

by_sub_act <- mean_std_data %>% group_by(subject, act_name)

final_data <- by_sub_act %>% summarize_each(funs(mean))
write.table(final_data, file="final_data.txt", row.names = FALSE)
