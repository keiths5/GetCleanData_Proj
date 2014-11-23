#You should create one R script called run_analysis.R that does the following. 
#   1) Merges the training and the test sets to create one data set.
#   2) Extracts only the measurements on the mean and standard deviation for each measurement. 
#   3) Uses descriptive activity names to name the activities in the data set
#   4) Appropriately labels the data set with descriptive variable names. 
#   5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
library(dplyr)

#Read in the headings for each of the features (e.g. tBodyAcc-mean()-X) this gives a 2-col data.frame, the 2nd col has the right name
Features_Heading <- read.delim2("UCI HAR Dataset/features.txt", header = FALSE, sep=" ", nrows=6)

#Read in the X for test and train
DF_Measurement_test <- read.delim2("UCI HAR Dataset/test/X_test.txt", header = FALSE, sep="", nrows=-1, skipNul=TRUE, flush=TRUE)
DF_Measurement_train <- read.delim2("UCI HAR Dataset/train/X_train.txt", header = FALSE, sep="", nrows=-1, skipNul=TRUE, flush=TRUE)

#combine the measurement test and train data.frames.
#assignment only calls for the mean and standard deviation of each, so the X, Y, and Z axis mean is the first 3 columns
#     and the X, Y, and Z axis std is the next 3 columns.  Therefore, trim this down to a 6-column dataset.
DF_Measurement <- rbind(data.frame(DF_Measurement_test[,1:6] ), data.frame(DF_Measurement_train[,1:6]))

#remove un-used dataframe to save memory
rm(DF_Measurement_test)  #remove to free memory
rm(DF_Measurement_train) #remove to free memory

#Add the column names to the dataframe
colnames(DF_Measurement) <- Features_Heading$V2

#Read in the Activity test and train
DF_Activity_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
DF_Activity_train <- read.table("UCI HAR Dataset/train/Y_train.txt")

#bind the Activity test and train into a single dataset
DF_Activity <- rbind(DF_Activity_test,DF_Activity_train)

#remove un-used dataframe to save memory
rm(DF_Activity_test) #remove to free memory
rm(DF_Activity_train) #remove to free memory

#bind the Activity and Measurement
#DF_Activity_Measurement frame completes step 4
DF_Activity_Measurement <- cbind(DF_Activity, DF_Measurement)

#remove un-used dataframe to save memory
rm(DF_Activity) #remove to free memory
rm(DF_Measurement) #remove to free memory

DF_tidy_Summary <- DF_Activity_Measurement %>% group_by(V1) %>% summarise_each(funs(mean))
colnames(DF_tidy_Summary)<-c("activity_number", colnames(DF_tidy_Summary[2:7]))
write.table(DF_tidy_Summary, "tidy.txt")
