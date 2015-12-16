setwd("~/Documents/Summer Scholarship/simulatedData/simulatedData/")

testData<-read.table("testPdf.0.txt",header=FALSE)
plot(testData$V1,testData$V2,"s",log="x",xaxt="n",lwd=1, ylim=c(0,2),xlab="Years ago",ylab= expression(paste("Effective population size x10"^"4")))
filelist = list.files(pattern = "*.txt")
n=length(filelist)
#cumulativeMean<-vector(length=19)
#cumulativePosition<-vector(length=19)
dataMatrix<-matrix(nrow=19)
for(file in filelist){
  fileData<-read.table(file,header=FALSE)
  lines(fileData$V1,fileData$V2,type="s")
#  cumulativePosition<-cumulativePosition+fileData$V1/n
#  cumulativeMean<-cumulativeMean+fileData$V2/n
  dataPosition<-cbind(dataPosition,fileData$V1)
  dataValue<-cbind(dataValue,fileData$V2)
}
library(matrixStats)
medianPopPos<-rowMedians(dataPosition,na.rm =TRUE )
medianPopEsts<-rowMedians(dataValue, na.rm=TRUE)
meanPopPos<-rowMeans(dataPosition,na.rm=TRUE)
meanPopEsts<-rowMeans(dataValue, na.rm=TRUE)
#lines(cumulativePosition,cumulativeMean,col="blue","s",lwd=5)
lines(testData$V1,testData$V2,"s",log="x",xaxt="n",col="red",lwd=10)
lines(medianPopPos,medianPopEsts,col="green","s",lwd=3)
lines(meanPopPos,meanPopEsts,col="blue","s",lwd=3)

ticks <- seq(0, 6, by=1)
labels <- sapply(ticks, function(i) as.expression(bquote(10^ .(i))))
axis(1, at=c(1, 10, 100, 1000,10000,100000,1000000), labels=labels)
