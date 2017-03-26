## The run_analysis.R consists of 4 functions (description below) that read the training and test datasets and returns
## a tidy data set as guidelined by the assignement instructions. The steps followed are as follows:

## 1. Read training and test data (X_train.txt and X_test.txt) along with their label data (y_train.txt and y_test)
##    respectively. This is done in the joindata() function which returns a single, combined training and test data
##    along with their corresponding labels.
## 2. Extract only measurements on mean and standard deviation from the merged dataset. The column numbers and names 
##    to be extracted are obtained from the col_select() function. The function returns a dataframe containing the 
##    column indices and column names containing measurements on mean and standard deviation. Also, the function
##    removes any special characters from the column names and converts all the characters to lower case.
## 3. Read activity label data from "activity_labels.txt" and obtain a dataframe containing activities corresponding
##    to each numeric label. This is achieved by act_label() function, which returns a dataframe consisting of numeric
##    labels along with the corresponding activities. The function also converts the text labels to lower case and
##    removes any special character.

## All the above steps are executed in the function tidyscript(), which calls the above explained functions sequentially
## to obtain a clean, labeled dataset as required by the assignment instructions.

## The function joindata() takes in the folder name, and names of the training, and testing data as well as label files,
## to read the data sets. While doing so, it is assumed that folder containing the data is in the working directory and
## the internal folder structure has not been changed. The function flashes out an error message if it's unable to find
## the file. If all the files are available, the function reads the training and test data, and labels. It first merges
## the corresponding measurements data, label, and subject data using cbind(). It then proceeds with merging the 
## training and test data using rbind().

joindata<-function(directory = "UCI HAR Dataset",
                   filetrain = "X_train.txt",filetest = "X_test.txt",
                   trainlbl = "y_train.txt",testlbl = "y_test.txt",
                   trainsub = "subject_train.txt",testsub="subject_test.txt"){
  
  f1<-file.path(getwd(),directory,"train",filetrain)
  f2<-file.path(getwd(),directory,"test",filetest)
  f3<-file.path(getwd(),directory,"train",trainlbl)
  f4<-file.path(getwd(),directory,"test",testlbl)
  f5<-file.path(getwd(),directory,"train",trainsub)
  f6<-file.path(getwd(),directory,"test",testsub)
  
  if(!file.exists(f1))
    return("Incorrect directory / filename for training data")
  else if(!file.exists(f2))
    return("Incorrect directory / filename for test data")
  else if(!file.exists(f3))
    return("Incorrect directory / filename for training activity label data")
  else if(!file.exists(f4))
    return("Incorrect directory / filename for test activity label data")
  else if(!file.exists(f5))
    return("Incorrect directory / filename for training subject label data")
  else if(!file.exists(f6))
    return("Incorrect directory / filename for test subject label data")
  else {
    train<-cbind(read.table(f1,stringsAsFactors = FALSE),read.table(f3),read.table(f5))
    test<-cbind(read.table(f2,stringsAsFactors = FALSE),read.table(f4),read.table(f6))
    
    if(length(train)!=length(test))
      return("Number of columns unequal. Please check file names")
    
    else return(rbind(train,test))
      
  }
    
}

## The act_label() function takes in the directory name where the data is present and the filename containig activity
## labels. The function returns a named dataframe containing the activity namescorresponding to each of the numeric
## labels. The text labels are further converted to lower case, and any special characters are removed.

act_label<-function(directory = "UCI HAR Dataset", filelabel ="activity_labels.txt"){
  
  f1<-file.path(getwd(),directory,filelabel)
  
  if(!file.exists(f1))
    return("Incorrect activity label directory / file name")
  else{
  labmatrix<-read.table(f1)
  labmatrix[,2]<-tolower(gsub("_","",labmatrix[,2]))
  names(labmatrix)<-c("numlabel","actlabel")
  return(labmatrix)
  }
}

## The col_select() function takes in the directory name and the filename containing the features ("features.txt"). The
## function returns a named dataframe containing the indices and column names of the measurements which calculate the
## mean or standard deviation of the measurements. The function also adds the index and name for the numeric labels
## which describe a particular activty (numlabel) and the subject identifier label of the person who conducted the test.
## (sublabel) in the list of selected columns. Furthermore, the variable names are converted to lowercase and all the
## special characters such as (),- and blankspaces are removed.

col_select<-function(directory = "UCI HAR Dataset", filefeature ="features.txt"){
  
  f1<-file.path(getwd(),directory,filefeature)
  
  if(!file.exists(f1))
    return("Incorrect feature directory / filename")
  else{
  features<-read.table(f1,stringsAsFactors = FALSE)
  colmatrix<-data.frame(col_index = c(grep("-mean\\(\\)|-std\\(\\)",features[,2]),562,563),
                        col_label=c(grep("-mean\\(\\)|-std\\(\\)",features[,2],value = TRUE),"numlabel","sublabel"))
  colmatrix$col_label<-tolower(gsub("[,() -]","",colmatrix$col_label))
  
  return(colmatrix)
  }
}

## The tidyscript() function is the main function which calls the above three functions in its body. The function
## returns a tidy dataset, complete with descriptive variable names, and labeled activities. The column names and
## indices are obtained from the col_select() function. The labeled activities are present under the column "actlabel"
## which is obtained by merging the dataframe obtained from act_label() on the "numlabel" column.The merge function
## also sorts the dataset according to the numeric label of the activities.

tidyscript<-function(directory="UCI HAR Dataset",
                     filetrain = "X_train.txt", filetest = "X_test.txt",
                     trainlbl = "y_train.txt", testlbl = "y_test.txt",
                     filelabel ="activity_labels.txt", filefeature ="features.txt"){
  
  finaldata<-joindata(directory,filetrain,filetest,trainlbl,testlbl)
  validcols<-col_select(directory,filefeature)
  actlookup<-act_label(directory,filelabel)
  
  finaldata<-finaldata[,validcols[,1]]
  names(finaldata)<-validcols[,2]
  finaldata<-merge(actlookup,finaldata)
}