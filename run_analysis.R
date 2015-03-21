run_analysis <- function(){

library(plyr)
library(dplyr)

### Read common data for Training & Test ######################################
activity_labels <- read.table("./activity_labels.txt", sep = "")
features <- read.table("./features.txt", sep = "")

### Read Training data ########################################################
subject_train <- read.table("./train/subject_train.txt", sep = "")
x_train <- read.table("./train/x_train.txt", sep = "")
y_train <- read.table("./train/y_train.txt", sep = "")
body_acc_x_train <- read.table("./train/Inertial Signals/body_acc_x_train.txt", sep = "")
body_acc_y_train <- read.table("./train/Inertial Signals/body_acc_y_train.txt", sep = "")
body_acc_z_train <- read.table("./train/Inertial Signals/body_acc_z_train.txt", sep = "")
body_gyro_x_train <- read.table("./train/Inertial Signals/body_gyro_x_train.txt", sep = "")
body_gyro_y_train <- read.table("./train/Inertial Signals/body_gyro_y_train.txt", sep = "")
body_gyro_z_train <- read.table("./train/Inertial Signals/body_gyro_z_train.txt", sep = "")
total_acc_x_train <- read.table("./train/Inertial Signals/total_acc_x_train.txt", sep = "")
total_acc_y_train <- read.table("./train/Inertial Signals/total_acc_y_train.txt", sep = "")
total_acc_z_train <- read.table("./train/Inertial Signals/total_acc_z_train.txt", sep = "")

### Define common data column names Test ######################################
colnames(activity_labels) <- c("activity_label","activity")
colnames(features) <- c("feature_no","feature")

### Define Training data column names #########################################
colnames(subject_train) <- "subject"
colnames(x_train) <- features$feature
colnames(y_train) <- "activity_label"

## Make data_type to distinguish Training #####################################
data_type <- rep("training", times=nrow(subject_train))

### Naming Training 128 element vector ########################################
colnames(body_acc_x_train) <- paste("body_acc_x_",1:128,sep="")
colnames(body_acc_y_train) <- paste("body_acc_y_",1:128,sep="")
colnames(body_acc_z_train) <- paste("body_acc_z_",1:128,sep="")
colnames(body_gyro_x_train) <- paste("body_gyro_x_",1:128,sep="")
colnames(body_gyro_y_train) <- paste("body_gyro_y_",1:128,sep="")
colnames(body_gyro_z_train) <- paste("body_gyro_z_",1:128,sep="")
colnames(total_acc_x_train) <- paste("total_acc_x_",1:128,sep="")
colnames(total_acc_y_train) <- paste("total_acc_y_",1:128,sep="")
colnames(total_acc_z_train) <- paste("total_acc_z_",1:128,sep="")
### Combine all Training data #################################################
all_train <- cbind(subject_train,data_type,y_train,x_train
                  ,body_acc_x_train,body_acc_y_train,body_acc_z_train
                  ,body_gyro_x_train,body_gyro_y_train,body_gyro_z_train
                  ,total_acc_x_train,total_acc_y_train,total_acc_z_train)

### Read Test data ############################################################
subject_test <- read.table("./test/subject_test.txt", sep = "")
x_test <- read.table("./test/x_test.txt", sep = "")
y_test <- read.table("./test/y_test.txt", sep = "")
body_acc_x_test <- read.table("./test/Inertial Signals/body_acc_x_test.txt", sep = "")
body_acc_y_test <- read.table("./test/Inertial Signals/body_acc_y_test.txt", sep = "")
body_acc_z_test <- read.table("./test/Inertial Signals/body_acc_z_test.txt", sep = "")
body_gyro_x_test <- read.table("./test/Inertial Signals/body_gyro_x_test.txt", sep = "")
body_gyro_y_test <- read.table("./test/Inertial Signals/body_gyro_y_test.txt", sep = "")
body_gyro_z_test <- read.table("./test/Inertial Signals/body_gyro_z_test.txt", sep = "")
total_acc_x_test <- read.table("./test/Inertial Signals/total_acc_x_test.txt", sep = "")
total_acc_y_test <- read.table("./test/Inertial Signals/total_acc_y_test.txt", sep = "")
total_acc_z_test <- read.table("./test/Inertial Signals/total_acc_z_test.txt", sep = "")


### Define Test data column names #############################################
colnames(subject_test) <- "subject"
colnames(x_test) <- features$feature
colnames(y_test) <- "activity_label"


## Make data_type to distinguish Test #########################################
data_type <- rep("test", times=nrow(subject_test))

### Naming Test 128 element vector ############################################
colnames(body_acc_x_test) <- paste("body_acc_x_",1:128,sep="")
colnames(body_acc_y_test) <- paste("body_acc_y_",1:128,sep="")
colnames(body_acc_z_test) <- paste("body_acc_z_",1:128,sep="")
colnames(body_gyro_x_test) <- paste("body_gyro_x_",1:128,sep="")
colnames(body_gyro_y_test) <- paste("body_gyro_y_",1:128,sep="")
colnames(body_gyro_z_test) <- paste("body_gyro_z_",1:128,sep="")
colnames(total_acc_x_test) <- paste("total_acc_x_",1:128,sep="")
colnames(total_acc_y_test) <- paste("total_acc_y_",1:128,sep="")
colnames(total_acc_z_test) <- paste("total_acc_z_",1:128,sep="")

### Combine all Test data #####################################################
all_test <- cbind(subject_test,data_type,y_test,x_test
                 ,body_acc_x_test,body_acc_y_test,body_acc_z_test
                 ,body_gyro_x_test,body_gyro_y_test,body_gyro_z_test
                 ,total_acc_x_test,total_acc_y_test,total_acc_z_test)

### 1. Merges the Traing and the Test sets to create one data set #############
train.test <- rbind(all_train,all_test)
### 3.Uses descriptive activity names to name the activities in the data set ###

train.test <- merge(activity_labels,train.test,by = "activity_label")
### 4.Appropriately labels the data set with descriptive variable names.#######
validname <- make.names(names(train.test),unique=TRUE)  # Transform to validname
colnames(train.test) <- validname
### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
col_sel <- grep("mean|std",validname)
MeanStdOnly <- train.test[,c(1:4,col_sel)]


### 5. creates a second, independent tidy data set with the average of each variable for each activity and each subject.
actvol <- group_by(MeanStdOnly, activity, subject)
myTidy <- summarise_each(actvol,funs(mean))
myTidy2 <- plyr::arrange(myTidy,activity_label,subject)# sorting
myTidy2 <- myTidy2[, -c(3,4)]                            # drop unnecessary col


### Write result Tidy Data ####################################################
file <- "./myTidy.txt"
write.table(myTidy2, file=file, row.names=FALSE,col.names=TRUE, sep="\t")

}