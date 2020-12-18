#Following has the details of code in run_anaylsis.R

Source: Data used in the code is from  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Code Details: 
1. Downloaded the zip,extracted and created directory.
2. Read activity_labels.txt file and assigned columnnames for it.
3. Read features.txt file
4. Read all the data(X_train,y_train,subject_train) in train folder in zip.
5. Assigned colnames to X_train file from 2nd column values of features data frame.
6. Assigned colnames to y_train,subject_train
7. Column binded all the train files into one.
8. Repest the same for test files(y_test,subject_test,X_test) and bind train and test
9. Get columns which has mean,std from bined data.
10. Assign acitiviy names by joining with activity id using two activity_labels.txt and binded data with mean and std columns.
11. Clean the varible names using gsub.
12. Get the mean of all other columns using activity id and subject id.
