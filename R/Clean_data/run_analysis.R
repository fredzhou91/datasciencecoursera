run_analysis.R

###move to the data_folder

###sort the folder and remove the space in foldname (bash command)
system("cd test;mv Inertial' 'Signals Inertial_Signals")
system("cd train;mv Inertial' 'Signals Inertial_Signals")

###1.combine the data into data.frame (bash command)
###use bash command
##merge data for test
system('cd test;paste $(ls ./*/*) > Inertial.summay')
Inertial_test_list=system('ls ./test/*/*',intern = TRUE)
Inertial_test_name=as.vector(sapply(Inertial_test_list,function(x) unlist(strsplit(x,'/'))[4]))
Inertial_test_name=gsub('_test.txt','',Inertial_test_name)

Inertial_test=data.frame(matrix(vector(),nrow=2947))
for (i in 1:length(Inertial_test_list))
{
data=read.table(Inertial_test_list[i],stringsAsFactors=F,header=F)
value_mean=apply(data,1,mean)
value_sd=apply(data,1,sd)
newdata=data.frame(value_mean=value_mean,value_sd=value_sd)
names(newdata)=c(paste(Inertial_test_name[i],'_mean',sep=''),paste(Inertial_test_name[i],'_sd',sep=''))
Inertial_test=cbind(Inertial_test,newdata)
}

test_X=read.table('./test/X_test.txt',stringsAsFactors=F,header=F)
test_Y=read.table('./test/y_test.txt',stringsAsFactors=F,header=F)
names(test_Y)='Y'
test_sub=read.table('./test/subject_test.txt',stringsAsFactors=F,header=F)
names(test_sub)='Subject'

testset=data.frame(X=test_X,Y=test_Y,subject=test_sub,Inertial_test)
testset$Group=rep('test',dim(testset)[1])


##merge data for train
system('cd train;paste $(ls ./*/*) > Inertial.summay')
Inertial_train_list=system('ls ./train/*/*',intern = TRUE)
Inertial_train_name=as.vector(sapply(Inertial_train_list,function(x) unlist(strsplit(x,'/'))[4]))
Inertial_train_name=gsub('_train.txt','',Inertial_train_name)

Inertial_train=data.frame(matrix(vector(),nrow=7352))
for (i in 1:length(Inertial_train_list))
{
data=read.table(Inertial_train_list[i],stringsAsFactors=F,header=F)
value_mean=apply(data,1,mean)
value_sd=apply(data,1,sd)
newdata=data.frame(value_mean=value_mean,value_sd=value_sd)
names(newdata)=c(paste(Inertial_train_name[i],'_mean',sep=''),paste(Inertial_train_name[i],'_sd',sep=''))
Inertial_train=cbind(Inertial_train,newdata)
}

train_X=read.table('./train/X_train.txt',stringsAsFactors=F,header=F)
train_Y=read.table('./train/y_train.txt',stringsAsFactors=F,header=F)
names(train_Y)='Y'
train_sub=read.table('./train/subject_train.txt',stringsAsFactors=F,header=F)
names(train_sub)='Subject'

trainset=data.frame(X=train_X,Y=train_Y,subject=train_sub,Inertial_train)
trainset$Group=rep('train',dim(trainset)[1])

#####Get the final data

final=rbind(trainset,testset)
tidy_data = aggregate(final[,c(1:561,564:581)], by=final[,562:563], mean)
write.table(final,'final.csv',row.names=F)
write.table(tidy_data,'tidy_data.txt',row.names=F)