# run dplyr package
library("dplyr")

# get the link for zip file
link_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zip_file <- "UCI_HAR_Dataset.zip"

# check zip file existence and download
if(!file.exists(zip_file)){
  download.file(link_url, zip_file, mode = "wb")
}

# check folder existence and unzip
data_path = "UCI HAR Dataset"
if(!file.exists(data_path)){
  unzip(zip_file)
}

# read data from train folder
train_subject <- read.table(file.path(data_path, 'train', 'subject_train.txt'))
train_value <- read.table(file.path(data_path, 'train', 'X_train.txt'))
train_activity <- read.table(file.path(data_path, 'train', 'y_train.txt'))

# read data from test folder
test_subject <- read.table(file.path(data_path, 'test', 'subject_test.txt'))
test_value <- read.table(file.path(data_path, 'test', 'X_test.txt'))
test_activity <- read.table(file.path(data_path, 'test', 'y_test.txt'))

# read feature and activity file
feature <- read.table(file.path(data_path, 'features.txt'), as.is = TRUE)
activities <- read.table(file.path(data_path, 'activity_labels.txt'))

# change the column names of activity to make easier to read
colnames(activities) <- c('activityid', 'activitylabel')

### 1. Merges the training and the test sets to create one data set
# merge train and test data: merge columns for data in train and test, while rows for train and test
people_activity <- rbind(cbind(train_subject, train_value, train_activity),
                         cbind(test_subject, test_value, test_activity))

# change column names based on features
colnames(people_activity) <- c('subject', feature[, 2], 'activity')

### 2. Extracts only the measurements on the mean and standard deviation for each measurement
# make the list of extract columns
name_keep <- "subject|activity|mean|std"
extract_columns <- grepl(name_keep, colnames(people_activity))

# extract required columns
extract_activity <- people_activity[,extract_columns]

### 3. Use descriptive activity names to name the activities in the data set
# change the activity value to descriptive names
extract_activity <- extract_activity %>% 
  mutate(activity = factor(activity, levels = activities[,1],
                           labels = activities[,2]))

### 4. Appropriately labels the data set with descriptive variable names
# make lists for pattern and replacement to change column names
pattern_list <- c("[\\(\\)-]", "^f", "^t", "Acc", "Gyro", "Mag", "Freq", "mean", "std")
replacement_list <- c("", "frequencyDomain", "timeDomain", "Accelerometer","Gyroscope","Magnitude",
                      "Frequency", "Mean", "StandarDeviation")

# loop over the above list to change the column names
for (i in seq_along(pattern_list)){
  colnames(extract_activity) <- gsub(pattern_list[i], replacement_list[i], colnames(extract_activity))
}

### 5. Create a second, independent tidy set with the average of each variable for each activity and each subject
# group the dataframe based on subject and activity, calculate mean
activity_mean <- extract_activity %>% 
  group_by(subject, activity) %>% 
  summarise(across(everything(),mean))

# extract tidy files to .txt
write.table(extract_activity, "tidy_activity.text", row.names = FALSE, quote = FALSE)
write.table(activity_mean, "tidy_activity_mean.text", row.names = FALSE, quote = FALSE)