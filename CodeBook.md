# Code book

## Data

The data was provided by the UCI Machine Learning Repository and corresponds to the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), a slightly processed version of this data (a `zip` file and the raw data for the purpose of this project) was used and sourced from [this link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) provided by the [Getting and Cleaning Data](https://www.coursera.org/course/getdata) course at [Coursera](https://www.coursera.org/).  

The data corresponds to recordings of 30 volunteers within an age bracket of 19-48 years performing activities of daily living wearing a smartphone (Samsung Galaxy S II) on the waist capturing 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz, using the embedded accelerometer and gyroscope.

The data was splitted in two data sets: training and testing sets.

### Raw Data

We use the following files (contained in the "__UCI HAR Dataset__", "__UCI HAR Dataset/test__" and "__UCI HAR Dataset/train__" folders) contained in the `zip` file:

* __UCI HAR Dataset/__`activity_labels.txt`: File with the descriptions of the activity code numbers.
* __UCI HAR Dataset/__`features.txt`: List of all features in the `X_train.txt` and `X_test.txt` file. Correspond to the names of measurements that were obtained from the accelerometer and gyroscope.__^1__
* __train/__`X_train.txt`: Numeric features of the training set. The units of this features were normalized and bounded within [-1,1].
* __train/__`y_train.txt`: Activity codes for the training set.
* __train/__`subject_train.txt`: Each row identifies the subject (by a number) who performed the activity for the training set. Its range is from 1 to 30.
* __test/__`X_test.txt`: Numeric features of the testing set. The units of this features were normalized and bounded within [-1,1].
* __test/__`y_test.txt`: Activity codes for the testing set.
* __test/__`subject_test.txt`: Each row identifies the subject (by a number) who performed the activity for the testing set. Its range is from 1 to 30.

__^1__For the sake of brevity, we refer the reader to the `features_info.txt` file in the "__UCI HAR Dataset__" folder for a  complete description of each feature contained in the raw data.

### Processed Data
#### Cleaning Data Process
In order to obtain the tidy data we perform the following steps:  

1. We merge the testing and training set by combining the columns of each file, since the `subject_train.txt`/`subject_test.txt`, `y_train.txt`/`y_test.txt`(activity codes) and `X_test.txt`/`X_train.txt` (numeric features) files have the same number of rows for each set, respectively.  After this, we combined them (the increased testing and training sets) by rows in order to obtain a complete data set.  The complete data set didn't have any missing values, so we didn't have to remove any observation.

2. Then, we extracted the mean and standard deviation for each measurement.  We left out the other features.

3. We used the activity names in the file `activity_labels.txt` in order to change the code numbers of the activities with descriptive names.

4. In order to appropriately label the variable names we replace the "-"" with "." and and remove the parantheses "()" (e.g., we change the "tBodyAcc-mean()-X" variable to "tBodyAcc.mean.X").

5. Finally, we created the tidy data set by averaging of each variable extracted in step 2 for each activity and each subject in a table (since there's only one class of experimental unit).  We save the tidy data in the `TidyAverageDataSet.csv` file.  Note that we average means and standard deviations for the purpose of this analysis.

### Information of the variables
The tidy data set (stored in the `TidyAverageDataSet.csv` file) contains the following variables.

* subject: The number of the subject. Its range is from 1 to 30.
* activity: Descriptive activity performed by the subject. 
* feature: Type of feature averaged.
* value: Numeric value that represent the average of the feature.  Values normalized and bounded within [-1,1].