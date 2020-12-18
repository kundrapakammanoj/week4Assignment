#packages
library(dplyr)


#1 Binding Data

#Read activity labels txt file and assign column names to it

activityLabels<-read.table("activity_labels.txt")
colnames(activityLabels)<-c("Activityid","Activityname")

#Read features file

features<-read.table("features.txt")

#Read all train files(X_train,y_train,subject_train)

X_train<-read.table("./train/X_train.txt")
y_train<-read.table("./train/y_train.txt")
subject_train <-read.table("./train/subject_train.txt")

#assign values from features df(column 2) as column names to X_train file.

colnames(X_train)<-features[,2]

#assign "activityyid" as column name to y_train and "subjectid" to subject_train 

colnames(y_train)="Activityid"
colnames(subject_train)="subjectid"


#column binding all train data frames(X_train,y_train,subject_train)

bindTrain<-cbind(y_train,subject_train,X_train)

#Read all test files(X_test,y_test,subject_test)

X_test<-read.table("./test/X_test.txt")
y_test<-read.table("./test/y_test.txt")
subject_test <-read.table("./test/subject_test.txt")

#assign values from features df(column 2) as column names to X_test file.

colnames(X_test)<-features[,2]

#assign "activityyid" as column name to y_test and "subjectid" to subject_test 

colnames(y_test)="Activityid"
colnames(subject_test)="subjectid"


#column binding all test data frames(X_test,y_test,subject_test)

bindTest<-cbind(y_test,subject_test,X_test)


#row binding both data frames(bindTrain and bindTest)

allTrainTest<-rbind(bindTrain,bindTest)



#2 geting mean and std data columns

#storing column names of  allTrainTest in a vector
allTrainTestNames<-colnames(allTrainTest)

#getting all the column names that has activityid,subjectid,mean and std in allTrainTest

colnamesFiltered<-grepl("Activityid",allTrainTestNames)|grepl("subjectid",allTrainTestNames) | grepl("mean",allTrainTestNames) | grepl("std",allTrainTestNames)

allMeanStd<-allTrainTest[,colnamesFiltered==T]


#3 Adding activity names

# merge allMeanStd and activityLables by activity id and get activity names

allMeanStdWithActivityNames<-left_join(allMeanStd,activityLabels)





#rearrange the activity name column to third position

allMeanStdWithActivityNames<-allMeanStdWithActivityNames %>%
  relocate(Activityname,.after=subjectid)


#4Appropriately labels the data set with descriptive variable names. 
colnames(allMeanStdWithActivityNames)<-gsub("-","",colnames(allMeanStdWithActivityNames))

colnames(allMeanStdWithActivityNames)<-gsub("\\()","",colnames(allMeanStdWithActivityNames))


#5Creating Tidy data Set


tidyData<-allMeanStdWithActivityNames %>% 
  group_by(Activityid,subjectid)%>%summarise(across("tBodyAccmeanX":"fBodyBodyGyroJerkMagmeanFreq",mean))


write.table(tidyData,"./tidyData.txt")

