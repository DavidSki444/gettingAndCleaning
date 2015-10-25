# gettingAndCleaning
Getting and Cleaning Data - course project

The code uses the rbind function in order to merge test set files and training set files.
I get column names from the features.txt file, and then I use the regexpr function to find the column with "mean" or "std".

I use the pmatch function to match activity ids and activity labels. 

To create the final dataset, I use the reshape2 package : melt and dcast functions.
