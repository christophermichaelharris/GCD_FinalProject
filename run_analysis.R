
filename <- "UCI_dataset.zip"
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" ##URL for source data
directory <- "UCI HAR Dataset"

if(!file.exists(filename)){     ##checks if the file has already been downloaded
  download.file(url,filename)  ##downloads the source data if it hasn't been downloaded

}

unzip(filename)  ##unzips file

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")  ##extract label names
features <- read.table("UCI HAR Dataset/features.txt")  ##extract column names

##read data from test folder

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("UCI HAR Dataset/test/x_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

##read data from train folder

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("UCI HAR Dataset/train/x_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

##combine subject/activity test and train data
subject <- rbind(subject_train,subject_test)
names(subject) <- "subject"
activity <- rbind(y_train,y_test)
names(activity) <- "activity"

##clean and combine train and test data
merged_data <- rbind(x_train,x_test)    ##merge
extracted_values <- grep("mean\\(\\)|std\\(\\)",features[,2])  ##extract mean or std dev values 
merged_data <- merged_data[,extracted_values]   ##subset data
 
##create names of relevant columns
column_names <- features[,2]   
column_names <- column_names[extracted_values]
column_names <- gsub("^t","time",column_names)
column_names <- gsub("^f","frequency",column_names)
column_names <- gsub("Mag","Magnitude",column_names)
column_names <- gsub("Acc","Accelerometer",column_names)
column_names <- gsub("Gyro","Gyroscope",column_names)
column_names <- gsub("BodyBody","Body",column_names)
column_names <- gsub("\\(\\)","",column_names)
names(merged_data) <- column_names

##combine into one dataset
merged_data <- cbind(subject,activity,merged_data)

##rename activity labels
activity_num <- merged_data$activity
act_factor <- factor(activity_num)
levels(act_factor) <- activity_labels[,2]
merged_data$activity <- act_factor

##create new dataset
library(plyr)
new_data <- aggregate(. ~subject + activity,merged_data,mean)
new_data <- new_data[order(new_data$subject,new_data$activity),]
write.table(new_data,"UCI HAR Dataset/tidydata.txt",row.name=FALSE)
