# How the script works
  This script needs plyr & dplyr packages. 
  If they are not installed, please install them by install.packages beforehand.

  In order to execute R program.  Please do  following @ R console.
     source("run_analysis.R")
     run_analysis()

   Data structure under Working Directory is explained at [1].
   How the program works is expalained briefly at [2].
   
1. Directory structure under Working Directory

   features.txt
   actvity_labels.txt
 
 < Data for Training >  
   train/subject_train.txt
   train/X_train.txt
   train/y_train.txt
   train/Inertial Signals/  9 x 128 column Data Text Files

 < Data for Test >  
   test/subject_test.txt
   test/X_test.txt
   test/y_test.txt
   test/Inertial Signals/  9 x 128 column Data Text Files

	
2. Step to clean up data

	1.  Read all table in R.  Data table name in R is same with each file name.
	2.	naming x_train colum with features
	3.	combine all files data under "train" directory side by side with cbind command, then make training data sets
	4.  Do 2 & 3 for data files under "test" directory, then make test data sets.
	5.  combine training & test data sets vertically by rbind command.
	6.  Change column names above @ 5 to "Syntactically Valid names" by make.names command.
	7.  Exrtract only mean and standard deviation by using "grep" command.
	8.  Grouping data by "activity" & "subject" and calculate average for each group by dplyr "summarise_each" command to make tidy data set.
	9.	Output tidy data set.  
