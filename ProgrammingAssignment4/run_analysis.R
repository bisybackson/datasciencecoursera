# title: "run_analysis.R"
# author: "Deon Erasmus"
# date: "2016-10-23"
# output: tidy_features.csv
# see 'README.md' and 'CodeBook.md' for further information.

# Prepare environment
library(data.table, dplyr)
filepath <- file.path("~","DataScienceCoursera")
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Download and extract dataset, update filepath
if (!exists(file.path(filepath,"rawdata"))) {dir.create(file.path(filepath,"rawdata"))}
filepath <- file.path("~","DataScienceCoursera","rawdata")
download.file(fileurl, destfile = file.path(filepath,"uci-har.zip"), method="curl")
unzip(file.path(filepath,"uci-har.zip"),exdir=file.path(filepath))
filepath <- file.path("~","DataScienceCoursera","rawdata","UCI HAR Dataset")

# Get metadata (labels)
activitylabels <- read.table(file.path(filepath,"activity_labels.txt"),
                             colClasses = c("NULL","factor"), col.names = c("V1","activity"))
featurelabels <- read.table(file.path(filepath,"features.txt"),
                            colClasses = c("NULL","character"), col.names = c("V1","feature"))

# Read the Test data into a data.table
testfeatures <- fread(file.path(filepath,"test/X_test.txt"))

# Set the column names according to the feature labels
names(testfeatures) <- featurelabels[[1]]

# Add columns for subject and activity
testfeatures$activity <- fread(file.path(filepath,"test/Y_test.txt"))
testfeatures$subject <- fread(file.path(filepath,"test/subject_test.txt"))

# Read the Train data into a data.table
trainfeatures <- fread(file.path(filepath,"train/X_train.txt"))

# Set the column names according to the feature labels
names(trainfeatures) <- featurelabels[[1]]

# Add columns for subject and activity
trainfeatures$activity <- fread(file.path(filepath,"train/Y_train.txt"))
trainfeatures$subject <- fread(file.path(filepath,"train/subject_train.txt"))

# Bind Test and Train data frames by row; remove redundant objects
features <- rbind(trainfeatures, testfeatures)
rm(testfeatures, trainfeatures, featurelabels)

# Replace activity for each observation to contain descriptive label
features$activity <- sapply(features$activity, function (x) {activitylabels[[1]][x]})

# Extract all columns containing [Mm]ean or std variables
names(features) <- make.unique(names(features))
features_mean_std <- select(features, grep("[Mm]ean|std", names(features)),activity,subject)

# Summarise dataset for all features by activity and subject, remove redundant objects
tidy_features <- features_mean_std %>% group_by(activity, subject) %>% summarise_all(mean)
rm(features_mean_std, features, activitylabels)

# Normalise variable names and write out tidy dataset to working directory
names(tidy_features) <- tolower(gsub("[()--,]","",(names(tidy_features))))
write.table(tidy_features, file="tidy_features.txt", row.names = FALSE)