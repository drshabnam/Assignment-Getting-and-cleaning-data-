          # Download and Unzip the dataset
library(dplyr)
a="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(a,destfile="D:/R/dataset.zip",method="curl")
unzip("dataset.zip")

# See the column names of features, activity_labels, test and train and assigning new column names

head(read.table("UCI HAR Dataset/features.txt"))
features= read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))

head(read.table("UCI HAR Dataset/activity_labels.txt"))
activities=read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

head(read.table("UCI HAR Dataset/test/subject_test.txt"))
subject_test=read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

head(read.table("UCI HAR Dataset/train/subject_train.txt"))
subject_train=read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

head(read.table("UCI HAR Dataset/test/X_test.txt"))
x_test=read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)

head(read.table("UCI HAR Dataset/train/X_train.txt"))
x_train=read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)

head(read.table("UCI HAR Dataset/test/Y_test.txt"))
y_test=read.table("UCI HAR Dataset/test/Y_test.txt", col.names = "code")

head(read.table("UCI HAR Dataset/train/Y_train.txt"))
y_train=read.table("UCI HAR Dataset/train/Y_train.txt", col.names = "code")

 # 1) Merges the training and the test sets to create one data set.
x=rbind(x_train, x_test)
y=rbind(y_train, y_test)
subject=rbind(subject_train, subject_test)
Merged=cbind(subject, y, x)

 # 2) Extracts only the measurements on the mean and standard deviation for each measurement.
c=Merged %>% select(subject, code, contains("mean"), contains("std"))

# 3) Uses descriptive activity names to name the activities in the data set.
c$code=read.table("UCI HAR Dataset/activity_labels.txt")[c$code, 2]

# 4) Appropriately labels the data set with descriptive variable names.

names(c)[2] = "activity"
names(c)=gsub("Acc", "Accelerometer", names(c))
names(c)=gsub("Gyro", "Gyroscope", names(c))
names(c)=gsub("BodyBody", "Body", names(c))
names(c)=gsub("Mag", "Magnitude", names(c))
names(c)=gsub("^t", "Time", names(c))
names(c)=gsub("^f", "Frequency", names(c))
names(c)=gsub("tBody", "TimeBody", names(c))
names(c)=gsub("-mean()", "Mean", names(c), ignore.case = TRUE)
names(c)=gsub("-std()", "STD", names(c), ignore.case = TRUE)
names(c)=gsub("-freq()", "Frequency", names(c), ignore.case = TRUE)
names(c)=gsub("angle", "Angle", names(c))
names(c)=gsub("gravity", "Gravity", names(c))

# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Mydata=c %>% group_by(subject, activity) %>% summarise_all(funs(mean)) 
write.table(Mydata, "Mydata.txt", row.name=FALSE)

# 6) My Final Data
Mydata
str(Mydata)
