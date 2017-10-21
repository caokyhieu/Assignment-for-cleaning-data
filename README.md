# Train Data:
+ First, use data.table package, read X_train.txt and features.txt to tables, take value from features table to make column names for X_train table.
+ Read  file y_train.txt with column name is "activity" 
+ join two tables above (X_train and y_train) to make trainData table
# Test Data
+ Similar like train data, make testData.

# Concatenate trainData to testData by rbind() -> dat table

# read activity_labels.txt to table with column names "code" and "activity.labels"

# mege two tables (dat and acitivty_labels) with parameter sort=FALSE, eliminate the first column (code) -> mergeData

# select features with mean() and std() (mean and standard diviation) in features table(66 features) plus two features "activity"
# and "activity.labels"

# use lapply() to calculate everage values of features for each person and each activity.



