#access file from website, unzip
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,"./UCI HAR Dataset.zip",method="curl")
unzip("./UCI HAR Dataset.zip")
file.remove ("./UCI HAR Dataset.zip")

#create variable names
features <- read.table("./UCI HAR Dataset/features.txt")
namingvec <- c("observation_number","subject","activity_label",
               as.character(features[,2]))

#training dataset preparation
subject_train <- read.table(
  "./UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/x_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
#label the rows
norows <- nrow(x_train)
ids_train <- paste(replicate(norows,"train_"),seq(1:norows),sep="")
#concatenate
df_train <- data.frame(ids_train,subject_train,y_train,x_train)
colnames(df_train) <- namingvec

#test dataset preparation
subject_test <- read.table(
  "./UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/x_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
#label the rows
norows <- nrow(x_test)
ids_test <- paste(replicate(norows,"test_"),seq(1:norows),sep="")
#concatenate
df_test <- data.frame(ids_test,subject_test,y_test,x_test)
colnames(df_test) <- namingvec

#append (step 1)
all_data <- rbind(df_train,df_test)

#which variables have mean/std in?
grepmean <- grep("mean\\(\\)",colnames(all_data))
grepstd <- grep("std\\(\\)",colnames(all_data))
greps <- sort(c(c(1,2,3),grepmean,grepstd)) #include label variables
#select them (step 2)
means_and_stds <- all_data[,greps]

#create activity names
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
#add them, rearrange table labelling (step 3)
results_by_record <- merge(means_and_stds,activities,
                             by.x="activity_label",by.y="V1")
results_by_record <- results_by_record[,c(1,70,2:69)]
colnames(results_by_record)[2] <- "activity"
results_by_record$activity_label <- NULL

#descriptive variable names (step 4)
colnames(results_by_record) <- c(
  "activity", 
  "observation_number", 
  "subject", 
  "body_accelerometer_acceleration_time_domain_x_direction_mean", 
  "body_accelerometer_acceleration_time_domain_y_direction_mean", 
  "body_accelerometer_acceleration_time_domain_z_direction_mean", 
  "body_accelerometer_acceleration_time_domain_x_direction_standard_deviation", 
  "body_accelerometer_acceleration_time_domain_y_direction_standard_deviation", 
  "body_accelerometer_acceleration_time_domain_z_direction_standard_deviation", 
  "gravity_accelerometer_time_domain_x_direction_mean", 
  "gravity_accelerometer_time_domain_y_direction_mean", 
  "gravity_accelerometer_time_domain_z_direction_mean", 
  "gravity_accelerometer_time_domain_x_direction_standard_deviation", 
  "gravity_accelerometer_time_domain_y_direction_standard_deviation", 
  "gravity_accelerometer_time_domain_z_direction_standard_deviation", 
  "body_accelerometer_acceleration_jerk_signal_time_domain_x_direction_mean", 
  "body_accelerometer_acceleration_jerk_signal_time_domain_y_direction_mean", 
  "body_accelerometer_acceleration_jerk_signal_time_domain_z_direction_mean", 
  "body_accelerometer_acceleration_jerk_signal_time_domain_x_direction_standard_deviation", 
  "body_accelerometer_acceleration_jerk_signal_time_domain_y_direction_standard_deviation", 
  "body_accelerometer_acceleration_jerk_signal_time_domain_z_direction_standard_deviation", 
  "body_accelerometer_angular_velocity_time_domain_x_direction_mean", 
  "body_accelerometer_angular_velocity_time_domain_y_direction_mean", 
  "body_accelerometer_angular_velocity_time_domain_z_direction_mean", 
  "body_accelerometer_angular_velocity_time_domain_x_direction_standard_deviation", 
  "body_accelerometer_angular_velocity_time_domain_y_direction_standard_deviation", 
  "body_accelerometer_angular_velocity_time_domain_z_direction_standard_deviation", 
  "body_accelerometer_angular_velocity_jerk_signal_time_domain_x_direction_mean", 
  "body_accelerometer_angular_velocity_jerk_signal_time_domain_y_direction_mean", 
  "body_accelerometer_angular_velocity_jerk_signal_time_domain_z_direction_mean", 
  "body_accelerometer_angular_velocity_jerk_signal_time_domain_x_direction_standard_deviation", 
  "body_accelerometer_angular_velocity_jerk_signal_time_domain_y_direction_standard_deviation", 
  "body_accelerometer_angular_velocity_jerk_signal_time_domain_z_direction_standard_deviation", 
  "body_accelerometer_acceleration_time_domain_magnitude_mean", 
  "body_accelerometer_acceleration_time_domain_magnitude_standard_deviation", 
  "gravity_accelerometer_time_domain_magnitude_mean", 
  "gravity_accelerometer_time_domain_magnitude_standard_deviation", 
  "body_accelerometer_angular_velocity_jerk_signal_time_domain_magnitude_mean", 
  "body_accelerometer_angular_velocity_jerk_signal_time_domain_magnitude_standard_deviation", 
  "body_accelerometer_angular_velocity_time_domain_magnitude_mean", 
  "body_accelerometer_angular_velocity_time_domain_magnitude_standard_deviation", 
  "body_accelerometer_angular_velocity_jerk_signal_time_domain_magnitude_mean", 
  "body_accelerometer_angular_velocity_jerk_signal_time_domain_magnitude_standard_deviation", 
  "body_accelerometer_acceleration_FFT_applied_x_direction_mean", 
  "body_accelerometer_acceleration_FFT_applied_y_direction_mean", 
  "body_accelerometer_acceleration_FFT_applied_z_direction_mean", 
  "body_accelerometer_acceleration_FFT_applied_x_direction_standard_deviation", 
  "body_accelerometer_acceleration_FFT_applied_y_direction_standard_deviation", 
  "body_accelerometer_acceleration_FFT_applied_z_direction_standard_deviation", 
  "body_accelerometer_acceleration_jerk_signal_FFT_applied_x_direction_mean", 
  "body_accelerometer_acceleration_jerk_signal_FFT_applied_y_direction_mean", 
  "body_accelerometer_acceleration_jerk_signal_FFT_applied_z_direction_mean", 
  "body_accelerometer_acceleration_jerk_signal_FFT_applied_x_direction_standard_deviation", 
  "body_accelerometer_acceleration_jerk_signal_FFT_applied_y_direction_standard_deviation", 
  "body_accelerometer_acceleration_jerk_signal_FFT_applied_z_direction_standard_deviation", 
  "body_accelerometer_angular_velocity_FFT_applied_x_direction_mean", 
  "body_accelerometer_angular_velocity_FFT_applied_y_direction_mean", 
  "body_accelerometer_angular_velocity_FFT_applied_z_direction_mean", 
  "body_accelerometer_angular_velocity_FFT_applied_x_direction_standard_deviation", 
  "body_accelerometer_angular_velocity_FFT_applied_y_direction_standard_deviation", 
  "body_accelerometer_angular_velocity_FFT_applied_z_direction_standard_deviation", 
  "body_accelerometer_acceleration_FFT_applied_magnitude_mean", 
  "body_accelerometer_acceleration_FFT_applied_magnitude_standard_deviation", 
  "body_accelerometer_acceleration_jerk_signal_FFT_applied_magnitude_mean", 
  "body_accelerometer_acceleration_jerk_signal_FFT_applied_magnitude_standard_deviation", 
  "body_accelerometer_angular_velocity_FFT_applied_magnitude_mean", 
  "body_accelerometer_angular_velocity_FFT_applied_magnitude_standard_deviation", 
  "body_accelerometer_angular_velocity_jerk_signal_FFT_applied_magnitude_mean", 
  "body_accelerometer_angular_velocity_jerk_signal_FFT_applied_magnitude_standard_deviation"
)

#summarise data, average all variables by subject and activity
#(step 5)
#instructions not clear about whether to average standard 
#deviations, so have
results_by_subject_and_activity <- aggregate(
  results_by_record[,4:69],list(
  results_by_record$subject,results_by_record$activity),mean)

#rename summary variables
colnames(results_by_subject_and_activity)[1:2] <- c(
  "subject_id","activity")
average_vec <- rep("average_",66)
colnames(results_by_subject_and_activity)[3:68] <- 
  paste(average_vec,
        colnames(results_by_subject_and_activity)[3:68],sep = "")

#output results_by_subject_and_activity
write.table(results_by_subject_and_activity,
            "./Wearables_Summary_Table.txt", row.names = FALSE)

#tidy data tables are results_by_record and
#results_by_subject_and_activity; the latter is the one that
#is being marked for Coursera