#The "run_analysis.R" script follows the following steps:


1 - First, reads the features and filter only the features that contain "mean()" and "std()".
2 - Then, it will load all train and test data but only the filtered features. It will use negative widths in "read.fwf" to skip the columns that are not required. That makes it much faster to load and process.
3 - It will merge the subject files to main data and then merges all train, and test data (using rbind). The result is a dataframe named "all_data". It also labels the columns by the name of the features.
4 - The next step creates another dataframe named "all_average" that contains the mean of all columns by "subject". I have used "aggregate" function for that.
5 - Last step it to write both dataframes into CSV files.