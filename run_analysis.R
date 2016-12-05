run_analysis <- function()
{
        #check that dplyr package is installed
        require("dplyr")
        
        #Check for existance of data folder, download and unzip if not present
        if(!dir.exists('UCI HAR Dataset')) {
                temp <- tempfile()
                fileurl <- paste("https://d396qusza40orc.cloudfront.net",
                "/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
                download.file(url=fileurl,temp)
                data <- read.table(unz(temp, "UCI HAR Dataset"))
                unlink(temp)
                }
        
        #Read in data column names
        features_dt <- read.table("UCI HAR Dataset/features.txt", 
                                  header = FALSE)
        
        #Read in test data
        xtest_dt <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
        ytest_dt <- read.table("UCI HAR Dataset/test/Y_test.txt", header = FALSE)
        subjecttest_dt <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                                 header = FALSE)
        
        #set column names for test_data
        colnames(xtest_dt) <- features_dt[,2]
        colnames(ytest_dt) <- "Activity"
        colnames(subjecttest_dt) <- "Subject_id"
        
        #Combine test data table
        test_dt <- cbind(subjecttest_dt,ytest_dt,xtest_dt)
        
        #Clear unwanted variables from memory
        rm(xtest_dt,ytest_dt,subjecttest_dt)
        
        
        #read in train data
        xtrain_dt <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
        ytrain_dt <- read.table("UCI HAR Dataset/train/Y_train.txt", header = FALSE)
        subjecttrain_dt <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                                      header = FALSE)
        
        #set column names for train_data
        colnames(xtrain_dt) <- features_dt[,2]
        colnames(ytrain_dt) <- "Activity"
        colnames(subjecttrain_dt) <- "Subject_id"
        
        #Combine train data table
        train_dt <- cbind(subjecttrain_dt,ytrain_dt,xtrain_dt)
        
        #Clear unwanted variables from memory
        rm(xtrain_dt,ytrain_dt,subjecttrain_dt)
        
        
        #Combine test and train datatables
        all_data_dt <- rbind(test_dt,train_dt)
        rm(test_dt,train_dt)#Clear unwanted variables from memory
        
        #Filter for mean and std values
        #Assume mean variable have "mean()" in column name
        #Assume std variable have "std()" in column name
        
        #Create temp variable to store the search pattern for grep
        #note: escape character "\\" used to force R to evaluate() 
        col_pattern <- "mean\\(\\)|std\\(\\)"
        
        #Sub-set dt for columns 1,2 and all that contain col_pattern
        filter_dt <- all_data_dt[ , c(1,2,
                                      grep(col_pattern, colnames(all_data_dt))
                                     )
                                ]
        
        #Read in Activity labels
        activity_dt <- read.table("UCI HAR Dataset/activity_labels.txt", 
                                  header = FALSE)
         
        #Change integers in "Activity" column to descriptor labels 
        filter_dt$Activity <- factor(x=filter_dt$Activity,
                                       levels = activity_dt$V1,
                                       labels = activity_dt$V2)

        #Calculate mean for each Subject-Activity combination
        output <- group_by(filter_dt,Subject_id, Activity) %>% 
                        summarize_each(funs(mean))
        return(output)
}
