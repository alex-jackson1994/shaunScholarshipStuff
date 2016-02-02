library(stringr)
library(ggplot2)
setwd("/home/alex/Desktop/Data/shaunWork/steppeBison/errorAnalysisRegression/steppeBison")
#setwd("~/Documents/SummerScholarship/steppeBison/errorAnalysisRegression/steppeBison/") 
#setwd("../../partAnalysis/steppeBison/  ")
summaryFileList = list.files(pattern = "*Summary.txt",recursive=T)
filelist = list.files(pattern = "*.txt",recursive=T)
dataFileList<-setdiff(filelist,summaryFileList) # all the files in the filelist that aren't summary files, i.e. the ones containing the psmc data

# need to set up integration functions
# this function will tell you PSMC's population size estimate at time "pos" given the x (time) and y (relative pop) data
eval_popsize = function(pos, x, y){ 
xIndex = length(which(x <= pos))
if(xIndex==0){
  print(pos)
  print(x)
  print(y)
  return(NaN)
}
return(y[xIndex])
}

# this function will tell you the absolute difference in between two curves A and B at position "xpos". we will later integrate this to get an area between two curves
absdifference = function(xpos,d1,d2,d3,d4){ # d1, d2 are x and y of curve A. d1, d2 are x and y of curve B. you want to compare curves A and B.
out = NULL
n=length(xpos)
for (i in 1:n) {
  out[i] = abs( eval_popsize(xpos[i],d1,d2) - eval_popsize(xpos[i],d3,d4) )
}
return(out)
}

findEndPoints<-function(dataFileList){
logmins = rep(0,length(dataFileList))
logmaxs = rep(0,length(dataFileList))
i = 1
for (infile in dataFileList) {
  data.infile = read.table(infile,header=TRUE)
  logmins[i] = log(min(data.infile$t_k/2)) # gotta divide by 2 to scale PSMC time output to N_0 generations. THIS IS IMPORTANT OTHERWISE THE PROGRAMS STUFF! MUST DO WHENEVER THERE IS A t_k
  logmaxs[i] = log(max(data.infile$t_k/2))
  i = i+1
}
logmax_of_mins = max(logmins)
logmin_of_maxs = min(logmaxs)
return(c(logmin_of_maxs,logmax_of_mins))
}
endPoints<-findEndPoints(dataFileList)
logmax_of_mins = endPoints[2]
logmax_of_mins = -1
logmin_of_maxs = endPoints[1]
logmin_of_maxs = 1

fullDataFileList = list.files(pattern = "*Split1.txt",recursive=T)
fullData<-read.table(fullDataFileList[4],header=T)
#fullData<-read.table('steppeBisonProb0/steppeBisonProb0.txt',header=T)
fullTimeEstimate<-log(fullData$t_k/2)
fullPopulationEstimate<-fullData$lambda_k
results<-data.frame()
for(i in 1:length(dataFileList)){
dataFilePath<-dataFileList[i]
summaryFilePath<-summaryFileList[i]
summaryData<-read.table(summaryFilePath,header=T)
data<-read.table(dataFilePath,header=T)
Int = as.numeric(gsub(pattern = "(.*Int)(.*)(\\*)(.*)(Split.*)", replacement = "\\2", x = dataFilePath)) # for something like 10*1, only extracts the 10 (we wouldn't do anything like x*y for y!= 1)
ErrorVal<-integrate(absdifference, logmax_of_mins, logmin_of_maxs, d1=fullTimeEstimate, d2=fullPopulationEstimate, d3=log(data$t_k/2), d4=data$lambda_k, subdivisions=10000)$value 
#Error = append(Error,ErrorVal)
results<-rbind(results,cbind(dataFilePath,Int,summaryData,ErrorVal))
}

#ggplot(data=results[results$Int>10,], mapping=aes(x=log(mean),y=ErrorVal,colour=Int))+scale_colour_gradient(low="red", high="blue")+geom_point(size=4)+geom_label(label=rownames(results[results$Int>10,]))
#PLOT MEAN VS ERROR for bigger than 20,30,40 intervals
ggplot(data=results[results$Int>10,], mapping=aes(x=log(mean),y=ErrorVal,colour=Int))+scale_colour_gradient(low="red", high="blue")+geom_point(size=4)+facet_grid(~Int) #+geom_smooth()
#ggplot(data=results, mapping=aes(x=mean,y=ErrorVal))+geom_point(size=4)+geom_smooth()
#ggplot(data=results, mapping=aes(x=totalLength,y=ErrorVal))+geom_point(size=4)+geom_smooth()
# ggplot(data=results[results$Int>10,], mapping=aes(x=log(max),y=ErrorVal,colour=Int))+scale_colour_gradient(low="red", high="blue")+geom_point(size=4)#+geom_smooth()

#ggplot(data=results, mapping=aes(x=log(mean),y=ErrorVal,colour=Int))+scale_colour_gradient(low="red", high="blue")+geom_point(size=4)

#tenSplit<-read.table('steppeBisonBp2528997500Int40*1Split512/steppeBisonBp2528997500Int40*1Split512.txt',header=T)
#onetwoeightSplit<-read.table('steppeBisonBp2528997500Int40*1Split128/steppeBisonBp2528997500Int40*1Split128.txt',header=T)
#plot(log(tenSplit$t_k/2),tenSplit$lambda_k,'s')
#lines(fullTimeEstimate,fullPopulationEstimate,'s',col='red')
#lines(log(onetwoeightSplit$t_k/2),onetwoeightSplit$lambda_k,'s',col='blue')

# ######################################################################################
# #Plot all the Int 10*1 graphs
# Int10List = dataFileList[grep('Int10',dataFileList)]
# int10Data<-data.frame()
# for(infile in Int10List){
#   currentData<-read.table(infile,header=T)
#   int10Data<-rbind(int10Data,cbind(infile,currentData))
# }
# fullDataMatrix<-cbind('fullData',1,exp(fullTimeEstimate)*2,fullPopulationEstimate,1,1,1)
# colnames(fullDataMatrix)<-colnames(int10Data)
# int10Data<-rbind(int10Data,fullDataMatrix)
# #lines(fullTimeEstimate,fullPopulationEstimate,'s',col='red')
# ggplot(data=int10Data, mapping=aes(x=log(as.numeric(t_k)/2),y=as.numeric(lambda_k),colour=as.factor(infile)))+geom_step()+ylim(0,15)#+xlim(logmax_of_mins,logmin_of_maxs)
######################################################################################
# #Plot all the Int 10*1 graphs
# Int10List = dataFileList[grep('Int40',dataFileList)]
# #Int10List = c(dataFileList[grep('1Split512',dataFileList)],dataFileList[grep('1Split2.txt',dataFileList)])
# int10Data<-data.frame()
# for(infile in Int10List){
#   currentData<-read.table(infile,header=T)
#   int10Data<-rbind(int10Data,cbind(infile,currentData))
# }
# fullDataMatrix<-cbind('fullData',1,exp(fullTimeEstimate)*2,fullPopulationEstimate,1,1,1)
# colnames(fullDataMatrix)<-colnames(int10Data)
# int10Data<-rbind(int10Data,fullDataMatrix)
# #lines(fullTimeEstimate,fullPopulationEstimate,'s',col='red')
# usefulData<-int10Data[which(int10Data$infile=="steppeBisonBp2528997500Int40*1Split1024/steppeBisonBp2528997500Int40*1Split1024.txt" | int10Data$infile=='fullData' | int10Data$infile=='steppeBisonBp2528997500Int40*1Split512/steppeBisonBp2528997500Int40*1Split512.txt' | int10Data$infile=='steppeBisonBp2528997500Int40*1Split256/steppeBisonBp2528997500Int40*1Split256.txt' | int10Data$infile=='steppeBisonBp2528997500Int40*1Split128/steppeBisonBp2528997500Int40*1Split128.txt'),]
# #ggplot(data=int10Data, mapping=aes(x=log(as.numeric(t_k)/2),y=as.numeric(lambda_k),colour=as.factor(infile)))+geom_step(show.legend = TRUE)+ylim(0,15)+xlim(-3,2.5)
# ggplot(data=usefulData, mapping=aes(x=log(as.numeric(t_k)/2),y=as.numeric(lambda_k),colour=as.factor(infile)))+geom_step(show.legend = TRUE)+ylim(0,15)+xlim(-3,2.5)+scale_color_manual(values = c('black','orange','red','blue','purple'))


#LINEAR MODELLING ON PARTITIONS
error.lm<-lm(ErrorVal~mean,data=results[-10,])
summary(error.lm)
library(MASS)
boxcox(error.lm)
