
# ------------------------- SETUP THE WORKING DIRECTORY ------------------------------- #

setwd('D:\\datascience\\03_CleaningData\\assignments\\week4')



# ------------------------- LOAD FEATURES NAMES VECTOR -------------------------------- #

features <- read.table('.\\data\\features.txt', col.names=c('position', 'label'))

featureFilter <- grepl("mean\\(\\)|std\\(\\)", features$label)  # filter
featureLabels <- as.character(features[featureFilter, 'label']) # labels

rm (features)

# we prepare featureFilter to load only the relevant features in read.table
featureFilter <- sub("TRUE", "numeric", as.character(featureFilter))
featureFilter <- sub("FALSE", "NULL", featureFilter)



# ------------------------- LOAD RELEVANT FILES - RELEVANT COLUMNS ONLY --------------- #

# training set
trainingSet <- read.table('.\\data\\train\\X_train.txt', colClasses = featureFilter)
trainingSubjects <-  read.table('.\\data\\train\\subject_train.txt')
trainingActivities <-  read.table('.\\data\\train\\y_train.txt')

trainingSet <- cbind(trainingActivities, trainingSubjects, trainingSet)
rm (trainingSubjects, trainingActivities)


# test set
testSet <- read.table('.\\data\\test\\X_test.txt', colClasses = featureFilter)
testSubjects <-  read.table('.\\data\\test\\subject_test.txt')
testActivities <-  read.table('.\\data\\test\\y_test.txt')

testSet <- cbind(testActivities, testSubjects, testSet)
rm (testSubjects, testActivities, featureFilter)



# ------------------------- MERGE FILES & RENAME COLUMNS ------------------------------ #

fullSet <- rbind.data.frame(trainingSet, testSet)
rm (trainingSet, testSet)

colnames (fullSet) <- append (c('activity', 'subject'), featureLabels)
rm (featureLabels)

activityLabels <- read.table('.\\data\\activity_labels.txt', col.names=c('id', 'activity_label'))
fullSet <- merge (fullSet, activityLabels, by.x='activity', by.y='id')
fullSet <- fullSet[,!(names(fullSet) %in% c('activity'))]
rm (activityLabels)



# ------------------------- SUBSET WITH AVERAGES -------------------------------------- #

library(reshape2)

fullSetMelt <- melt(fullSet,id=c("subject","activity_label"))

fullSetAvg <- dcast (fullSetMelt, subject + activity_label ~ variable, mean)
rm (fullSetMelt)

write.table(fullSetAvg, ".\\fullSetAverage.txt", sep="\t", row.names = FALSE)

