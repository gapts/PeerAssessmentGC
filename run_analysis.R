##########
# Description : This scripts contains the code of the Peer Assessment 1 of the 
#               Getting and Cleaning Data course.
#
# Author      : Stagirite (Pseudonym used in the github account).
# Created     : 23-04-2014 03:34:30 PM CST
#
# DISCLAMER   : I AM NOT RESPONSIBLE FOR ANY HARM DONE FROM EXECUTING THIS SCRIPT.
##########


##  CREATING A WORKING DIRECTORY TO SAVE THE RESULTS
## ------------------------------------------------------------------------
# Note: This part of the code will create different folders in your working
#       directory to save the results of this script.

# Create a folder in the current working directory.
dir.create("STAGIRITE_PA01")
setwd("./STAGIRITE_PA01")
# Create a directory to store the raw data.
dir.create("RAW_DATA")
# Create a directory to store the processed data.
dir.create("PROCESSED_DATA")


##  DOWNLOADING THE DATA
## ------------------------------------------------------------------------
# We store in a file "DataDownloadDate.txt" the date of the download.
date.download <- date()
file.conection <- file("DataDownloadDate.txt")
writeLines(paste0("Download date: ", date.download), file.conection)
close(file.conection)

data.file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(data.file, destfile = "./RAW_DATA/Dataset.zip", method = "curl")

# We extract the files in the PROCESSED_DATA folder.
unzip(zipfile = "./RAW_DATA/Dataset.zip", exdir = "./PROCESSED_DATA")


##  READING THE DOWNLOAD FILES
## ------------------------------------------------------------------------
# Set the working directory.
setwd("./PROCESSED_DATA/UCI HAR Dataset")

# It reads the data files in the vector "filenames" and store them in data frames
# with the names in this vector using the "col.classes" vector (e.g., it stores the
# "activity_labels.txt" file in the data frame "activities" reading the first
# column of this file as integer and the second as character).
files <- list(filenames = c(activities = "./activity_labels.txt", 
                            features = "./features.txt",
                            test.subject = "./test/subject_test.txt", 
                            test.activity = "./test/y_test.txt",
                            test.data = "./test/X_test.txt", 
                            train.subject = "./train/subject_train.txt", 
                            train.activity = "./train/y_train.txt", 
                            train.data = "./train/X_train.txt"), 
              col.classes = list(c("integer", "character"), 
                                 c("NULL", "character"), 
                                 "integer", 
                                 "integer", 
                                 "numeric",
                                 "integer", 
                                 "integer", 
                                 "numeric")
              )
for (file in seq_along(files$filenames)) {
  assign(names(files$filenames)[file], 
         read.table(files$filenames[file], 
                    colClasses = files$col.classes[[file]], 
                    header = FALSE)
         )
}


##  STEP 1 - MERGING THE TRAINING AND THE TEST SETS
## ------------------------------------------------------------------------
# Combine the columns for the testing and training sets, since the subject, activity and 
# data files have the same number of rows for each set. 
test <- cbind(test.subject, test.activity, test.data)
train <- cbind(train.subject, train.activity, train.data)

# Given that the testing and training sets now have the same columns and variable types 
# and we want to attach one under the other we combine them by rows.
total.data <- rbind(test, train)

# We remove the rows that contain missing values (NA's).  Note: This particular data
# set didn't have missing values. Check it with "sum(is.na(total.data))".
complete.data <- total.data[complete.cases(total.data), ]

# We set the column names in order to distinguish the variables.
colnames(complete.data) <- c("subject", "activity", features[, 1])


##  STEP 2 - EXTRACTING THE MEAN AND STANDARD DEVIATION
## ------------------------------------------------------------------------
# We are interested only in the measurements on the mean and standard deviation.
#
# According to the "features_info.txt" file:
#   mean(): Mean value
#   std(): Standard deviation
#
# So, we extract only the variables that contain the strings "mean()" and "std()"
# in their names and store them in the "data.only.mean.std" data frame.
mean.std.features <- grep("mean\\(\\)|std\\(\\)", colnames(complete.data))
data.only.mean.std <- complete.data[, c("subject", 
                                        "activity", 
                                        colnames(complete.data)[mean.std.features])
                                    ]


##  STEP 3 - USING DESCRIPTIVE ACTIVITY
## ------------------------------------------------------------------------
# We use the activity names in the file "activity_labels.txt" stored in the "activities"
# data frame in order to change the numbers of the activities with the descriptive names
# in this file.  By the way, we remove the "_" with blankspaces in the activity names.
data.only.mean.std$activity <- gsub("_", " ", 
                                    tolower(activities[data.only.mean.std$activity, 2])
                                    )


##  STEP 4 - APPROPRIATELY LABELING THE DATA SET
## ------------------------------------------------------------------------
# In order to appropriately label the variable names we replace the "-"" with "." and 
# and remove the parantheses "()".
colnames(data.only.mean.std) <- gsub("-", ".", 
                                     gsub("\\(\\)", "", colnames(data.only.mean.std)))


##  STEP 5 - CREATING A TIDY SET
## ------------------------------------------------------------------------
# A tidy data (Wickham, 2011):
#   1.  Each variable forms a column.
#   2.  Each observation forms a row.
#   3.  Each table (or file) stores data about one class of experimental unit
#
# According to this definition we have different features, so we put it in column
# and each observation (subject, activity and feature) in a row.  Since there's
# only one class of experimental unit, we have only one table.
library(reshape2)
tidy.only.mean.std <- melt(data.only.mean.std,
                           id = c("subject", "activity"),
                           variable.name = "feature")

tidy.ordered.only.mean.std <- tidy.only.mean.std[order(tidy.only.mean.std$subject, 
                                                       tidy.only.mean.std$activity, 
                                                       tidy.only.mean.std$feature), ]
# Finally, we get the average for each variable (feature) for each activity and each 
# subject.
library(plyr)
tidy.avg.mean.std <- ddply(tidy.ordered.only.mean.std, 
                           c("subject", "activity", "feature"), 
                           summarise, value = mean(value))
# We store the tidy data set with the averages in the "TidyAverageDataSet.csv" file.
write.table(tidy.avg.mean.std, "../TidyAverageDataSet.csv", sep = ",", row.names = FALSE)
