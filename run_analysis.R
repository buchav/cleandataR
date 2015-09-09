
#set data folder and input files
data_dir<-"UCI HAR Dataset"

#set filenames to be loaded
test_files<-c("y_test.txt","subject_test.txt","X_test.txt")
train_files<-c("y_train.txt","subject_train.txt","X_train.txt")
feature_file<-file.path(data_dir,"features.txt")

#generate path to filenames
train_files_path<-sapply(train_files,function(x) file.path(data_dir,"train",x))
test_files_path<-sapply(test_files,function(x) file.path(data_dir,"test",x))

#load feature names
features_df<-read.table(feature_file,sep="",header=FALSE)
features_vec<-as.vector(t(features_df[2]))

#generate descriptive feature names
features_vec<-gsub(c("\\(|\\)"),c(""), features_vec)

#extend feature names with subject and Y
features_vec<-c(c("Label","Subject"),features_vec)

#function load 3 files- Y, subject, X and combine them into one dataset
combine_data_pack<-function(datapack_path){
#s<-lapply(datapack_path,read.table,sep="",nrows = 10,header=FALSE)
s<-lapply(datapack_path,read.table,sep="",header=FALSE)
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
