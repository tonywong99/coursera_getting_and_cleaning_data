## A brief description of ran_analysis.R

The goal, data source of this project are very well described in the course website. To achieve the goal, I created five major steps, which are also marked within the lines of the code.

* step 1, Merges the training and the test sets to create one data set.
* step 2, Extracts only the measurements on the mean and standard deviation for each measurement by using grep function
* step 3, Uses descriptive activity names to name the activities in the data set by using gsub function
* step 4, get tidy dataset
* step 5, output as txt file
 

### Major temperary datasets
* trainHAR, the training set
* testHAR, the test set
* features, the features dataset
* activitiyLabel, the descriptive labels dataset
* tidy, the final tidy dataset
 

### NOTE!!!
* Before you test run the code, please make sure your R working directory includes HAR dataset


