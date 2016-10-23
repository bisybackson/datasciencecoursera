---
title: "run_analysis.R"
author: "Deon Erasmus"
date: "2016-10-23"
output: tidy_features.csv
  html_document:
    keep_md: yes
---

### Introduction 

This script downloads a predefined dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, then extracts it and processes it in the following manner:

- Prepare the environment by loading dplyr and data.table packages. Data.table makes processing much faster, and dplyr is required for selecting and summarising required data.
- Download and extract the dataset to location specified by 'filepath'
- Load the metadata (labels for activity and features) from text files into variables
- Read the test and training datasets into data.table objects
- Set column names according to features.txt
- Add columns containing subject ID and activity performed
- Merge test and training data
- Replace activity values with descriptive label
- Extract only columns containing "[Mm]ean" or "std" in the header
- Summarise dataset for all features by activity and subject

### Usage
Run the script from your working directory by executing run_analysis.R; the resultant tidy dataset called tidy_features.csv will be placed in the working directory. Downloaded and extracted raw data is placed in ./rawdata/ and not removed.

### Further information
Please see the accomanying code book (CodeBook.md) for further information.