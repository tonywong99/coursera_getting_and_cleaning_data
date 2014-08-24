####!!!Please update the working directory to where your HAR dataset sits###
#setwd("C:/UCI HAR Dataset")

### step 1, Merges the training and the test sets to create one data set.
trainHAR = read.csv("train/X_train.txt", sep="", header=FALSE)
trainHAR[,562] = read.csv("train/Y_train.txt", sep="", header=FALSE)
trainHAR[,563] = read.csv("train/subject_train.txt", sep="", header=FALSE)


testHAR = read.csv("test/X_test.txt", sep="", header=FALSE)
testHAR[,562] = read.csv("test/Y_test.txt", sep="", header=FALSE)
testHAR[,563] = read.csv("test/subject_test.txt", sep="", header=FALSE)


# make the feature names clean
features = read.csv("features.txt", sep="", header=FALSE)
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])

activityLabels = read.csv("activity_labels.txt", sep="", header=FALSE)

# Merge training and test sets into a new dataset named allHAR 
allHAR = rbind(trainHAR, testHAR)


###### Step 2,  Extracts only the measurements on the mean and standard deviation for each measurement.  
## MS = Mean & Std.dev.
colsMS <- grep(".*Mean.*|.*Std.*", features[,2])
# remain columns only related to mean and standard deviation
features <- features[colsMS,]
# Add columns of subject and activity
colsMS <- c(colsMS, 562, 563)
# Extracts only the measurements on the mean and standard
allHAR <- allHAR[,colsMS]
# Add descriptive column names (features) 
colnames(allHAR) <- c(features$V2, "Activity", "Subject")
colnames(allHAR) <- tolower(colnames(allHAR))


#### step 3. Uses descriptive activity names to name the activities in the data set

currActInd = 1   # a variable corresponds to the activity lables in the original dataset
for (currentActivityLabel in activityLabels$V2) {
        allHAR$activity <- gsub(currActInd, currentActivityLabel, allHAR$activity)
        currActInd <- currActInd + 1
}


##### step 4, get tidy dataset

tidy = aggregate(allHAR, by=list(activity = allHAR$activity, subject=allHAR$subject), mean)
# Remove the subject and activity columns
tidy<-subset(tidy, select= -c(89,90))

##### step 5, final output
write.table(tidy, "tidy.txt", sep="\t", row.names=FALSE)

