Getting and Cleaning Data: Course Project
=========================================

Raw Data
------------------
The features are unlabeled and can be found in the x_test.txt.
The activity labels are in the y_test.txt file.
The test subjects are in the subject_test.txt file.

The same holds for the training set.

run_analysis.R and Tidy Data Set
-------------------------------------
The script run_analysis.R merges the test and training sets together.

The UCI HAR Dataset must be extracted and available in a directory called "UCI HAR Dataset"

After merging testing and training, labels are added and only columns that have to do with mean and standard deviation are kept.

The script creates a tidy data set containing the means of all the columns per test subject and per activity.

This tidy dataset writes to a tab-delimited file called tidy_file.txt, which can also be found in this repository.

Code Book
-------------------
The CodeBook.md file explains the variables.
