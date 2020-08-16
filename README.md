# Assignment-Getting-and-cleaning-data-
This repository contains three files

Codebook.md : It has all the variables of the tidy data set.
README.md : This explains the transformations involved step by step.
run_analysis.R : It transforms the given data to a tidy data set.
tidyset.txt : This is the tidy data set produced as an output from the R script.

Install dplyr package


Unzipped folder as the working directory then run the given R script

Transformation: 

1) Both datasets train and test are loaded in separate dataframes. Feature list is loaded which is formatted to good variable names.This vector is now used to rename the columns of both data frames
2) Out of 561 columns of the data frames only the ones with mean and standard deviation are used (68 in number).
meanFreq() columns are not used as they are derived columns.
3) Activity labels are loaded are binded to the data frames of test and train. Labels are then replaced by more descriptive names.
4) Subjects are now loaded and binded to the test and train data frames.
5) Merge both data frames together
6) merge data frame by subject and activity and written to tidyset.txt in the working directory.
