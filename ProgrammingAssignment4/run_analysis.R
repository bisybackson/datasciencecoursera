
# Prepare environment and read metadata
library(data.table, dplyr)
filepath <- file.path("~","DataScienceCoursera")
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Download and extract dataset, then update filepath
if (!exists(file.path(filepath,"rawdata"))) {dir.create(file.path(filepath,"rawdata"))}
filepath <- file.path("~","DataScienceCoursera","rawdata")
download.file(fileurl, destfile = file.path(filepath,"uci-har.zip"), method="curl")
unzip(file.path(filepath,"uci-har.zip"),exdir=file.path(filepath))
filepath <- file.path("~","DataScienceCoursera","rawdata","UCI HAR Dataset")

# Get labels
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

# Bind Test and Train data frames by row; remove test and train objects
features <- rbind(trainfeatures, testfeatures)
rm(testfeatures, trainfeatures, featurelabels)

# Rename activity for each observation to contain descriptive label
features$activity <- sapply(features$activity, function (x) {activitylabels[[1]][x]})

names(features) <- make.unique(names(features))
features_mean_std <- select(features, grep("[Mm]ean|std", names(features)),activity,subject)
tidy_features <- features_mean_std %>% group_by(activity, subject) %>% summarise_all(mean)
rm(features_mean_std, features, activitylabels)


names(tidy_features) <- tolower(gsub("[()--,]","",(names(tidy_features))))

write.csv(tidy_features, file="tidy_features.csv", row.names = FALSE)
