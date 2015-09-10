
#set data folder and input files
data_dir<-"UCI HAR Dataset"

#set filenames to be loaded
test_files<-c("y_test.txt","subject_test.txt","X_test.txt")
train_files<-c("y_train.txt","subject_train.txt","X_train.txt")
feature_file<-file.path(data_dir,"features.txt")

#generate path to filenames
train_files_path<-sapply(train_files,function(x) file.path(data_dir,"train",x))
test_files_path<-sapply(test_files,function(x) file.path(data_dir,"test",x))

#####################TASK 1,4###################################################
#load feature names
features_df<-read.table(feature_file,sep="",header=FALSE)
features_vec<-as.vector(t(features_df[2]))

#generate descriptive feature names
features_vec<-gsub(c("\\(|\\)"),c(""), features_vec)
features_vec<-gsub(c("\\-|\\,"),c("_"), features_vec)

#extend feature names with subject and Y
features_vec<-c(c("label_id","subject_id"),features_vec)

#function load 3 files- Y, subject, X and combine them into one dataset
combine_data_pack<-function(datapack_path){
        #s<-lapply(datapack_path,read.table,sep="",nrows = 10,header=FALSE)
        s<-lapply(datapack_path,read.table,sep="",header=FALSE,colClasses = "numeric")
        do.call(cbind,s)
}

#load data to dataframes
train<-combine_data_pack(train_files_path)
test<-combine_data_pack(test_files_path)

#assign descriptive names to train and test dataframes
names(train)<-features_vec
names(test)<-features_vec

#merge train and test dataframes
full<-rbind(train,test)

#####################TASK 2###################################################
# find features with "mean" and "std" strings
mean_std_features<-grep("Mean|std",names(train),value=TRUE,ignore.case = TRUE)

# Do not forget about Label and subject colums
mean_std_features<-c(c("label_id","subject_id"),mean_std_features)

#Extracts only the measurements on the mean and standard deviation for each measurement + label_id + subject_id field
full<-full[,mean_std_features]

#####################TASK 3###################################################
# set up path to activity labels file
activity_label_file<-file.path(data_dir,"activity_labels.txt")
activity_label<-read.table(activity_label_file,sep="",header=FALSE,col.names=c("label_id","Label"))
full<-merge(activity_label,full)

#####################TASK 5###################################################
library(dplyr)
tidy_summary<-full %>% select(-label_id) %>%
        group_by(Label,subject_id) %>%
        summarize_each(funs(mean))
tidy_summary
write.table(tidy_summary,"tidy_dataset.tx")