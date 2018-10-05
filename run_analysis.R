

library(dplyr, lib.loc = "C:/Library/R")


###############################################################################
#Download and unzip project files
###############################################################################

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./courseproject.zip")

zipF<- "./courseproject.zip"
outDir<-"./courseproject"
unzip(zipF,exdir=outDir)

###############################################################################
#Get Activity Labels and Activity Features
###############################################################################

#Activity lables maps the six activities (e.g., walking, sitting, standing) to an index 1:6
activity_labels <- read.table("./courseproject/UCI HAR Dataset/activity_labels.txt", 
                              quote="\"", comment.char="", col.names = c("ClassLabel", "ActivityName"))
#Features maps 561 features to an index 1:561
features <- read.table("./courseproject/UCI HAR Dataset/features.txt", 
                       quote="\"", comment.char="", col.names = c("Index", "FeatureNames"))

###############################################################################
#Prepare training data: label variables, and select required features
#Training data has 7352 observations (300 - 400 observations per subject) and 561 features
###############################################################################

#set features as col label
X_train <- read.table("./courseproject/UCI HAR Dataset/train/X_train.txt", 
                      quote="\"", comment.char="", col.names = features[,2])
#keep only features for mean and std (79 features)
X_train_small <- X_train[ , grepl( "mean|std" , names(X_train) ) ]

#Y_Train is a vector that identifies what observation corresponds to what activity (7352 rows and 1 column)
y_train <- read.table("./courseproject/UCI HAR Dataset/train/y_train.txt", 
                      quote="\"", comment.char="", col.names = "ClassLabel")

#Subject_Train is a vector that identifies what observation corresponds to what subject (7352 rows and 1 column)
subject_train <- read.table("./courseproject/UCI HAR Dataset/train/subject_train.txt",
                            quote="\"", comment.char="", col.names = "SubjectNumber")
#column bind data (7352 obs and 82 vars)
train <- cbind(subject_train, y_train, X_train_small)%>%
  mutate(Data_type = "Training")

###############################################################################
#Prepare test data: label variables, and select required features (repeats steps for training data)
#Training data has 2947 observations (300 - 400 observations per subject) and 561 features
###############################################################################

#set features as col label
X_test <- read.table("./courseproject/UCI HAR Dataset/test/X_test.txt", 
                      quote="\"", comment.char="", col.names = features[,2])
#keep only features for mean and std (79 features)
X_test_small <- X_test[ , grepl( "mean|std" , names(X_test) ) ]
#Y_Test is a vector that identifies what observation corresponds to what activity (2947 rows and 1 column)
y_test <- read.table("./courseproject/UCI HAR Dataset/test/y_test.txt", 
                      quote="\"", comment.char="", col.names = "ClassLabel")

#Subject_test is a vector that identifies what observation corresponds to what subject (7352 rows and 1 column)
subject_test <- read.table("./courseproject/UCI HAR Dataset/test/subject_test.txt",
                            quote="\"", comment.char="", col.names = "SubjectNumber")

#column bind data (2947 obs and 82vars)
test<- cbind(subject_test, y_test, X_test_small)%>%
  mutate(Data_type = "Testing")

###############################################################################
#Stack test and training data (10,299 observations and 82 variables)
###############################################################################

combined_data <- rbind(train, test)

###############################################################################
#Creates a second, independent tidy data set with the average (by var, activity, and subject)
###############################################################################

tidy_data <- combined_data %>%
  group_by(SubjectNumber, ClassLabel, Data_type)%>%
  summarise_all(funs(mean))

#apply activity label and rename the variable
tidy_data$ClassLabel <- factor(tidy_data$ClassLabel,levels = activity_labels[, 1], labels = activity_labels[, 2])
names(tidy_data)[names(tidy_data) == 'ClassLabel'] <- 'Activity_Type'


# output to file "tidy_data.txt"
write.table(tidy_data, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)
