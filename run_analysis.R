library(data.table)
## Firstly,read file X_train.txt,features.txt,subject_train.txt,y_train.txt to tables (data.table) and join them to 
## trainData table with appropriate variable names.

X_train <- fread("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
features<- fread("./UCI HAR Dataset/features.txt",header=FALSE)
subject_train <- fread("./UCI HAR Dataset/train/subject_train.txt",header=FALSE,col.names="subject")
y_train <- fread("./UCI HAR Dataset/train/y_train.txt",header=FALSE,col.names="activity")
names(X_train) <- features$V2 ## get variable names from features table

## join tables horizontally
trainData <- cbind(X_train,subject_train,y_train)

## Like first step, make testData table with appropriate variable names

X_test <- fread("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
subject_test <- fread("./UCI HAR Dataset/test/subject_test.txt",header=FALSE,col.names="subject")
y_test <- fread("./UCI HAR Dataset/test/y_test.txt",header=FALSE,col.names="activity")
names(X_test) <- features$V2 # get variable names from features table

## join X_test,subject_test,y_test tables horizontally to form testData table
testData <- cbind(X_test,subject_test,y_test)

## join testData to trainData to form dat table
dat <- rbind(trainData,testData)

## read file activity_labels.txt
activity_labels <- fread("./UCI HAR Dataset/activity_labels.txt",header=FALSE,col.names=c("code","activity.labels"))
                              
## make features vector with "mean()" and "std()" (mean and standard diviation) , additionally two feature "activity" and "subject"   
new_features <- c(grep("mean\\(\\)|std\\(\\)",features$V2,value=TRUE),"activity","subject")

## make new table with features vector above
new_dat = subset(dat,,new_features)

## merge the new table above with activity_labels table by the code column and eliminate it from the result table

mergeData <- merge(new_dat,activity_labels,by.x="activity",by.y="code",sort=FALSE)
mergeData = mergeData[,-1]

## tidy data set with the average of each variable for each activity and each subject

tidyData <- mergeData[,lapply(.SD,mean),by=c('subject','activity.labels')]

## write tidyData to tidyData.txt
write.table(tidyData,file="tidyData.txt",row.names=FALSE)






