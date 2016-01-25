setwd("~/Documents/Summer Scholarship/RScripts/slidingWindow/")
#a few R functions used for doing the sliding window error analysis
eval_popsize = function(pos, x, y){ 
  #eval_popsize returns values of a left constant piecewise step function
  #pos is the position that you want to evaluate at
  #x is the vector of x coordinates that the steps occur at
  #y is the corresponding y values
  xIndex = length(which(x <= pos))
  return(y[xIndex])
}

absdifference = function(xpos,func1x,func1y,func2x,func2y){
  #absdifference calculates the absolute difference in values between two piecewise constant functions
  #at some position xpos
  out=NULL
  for (i in 1:length(xpos)) {
    out[i] = abs(eval_popsize(xpos[i],func1x,func1y) - eval_popsize(xpos[i],func2x,func2y))
  }
  return(out)
}

slidingWindow=function(xVals1,yVals1,xVals2,yVals2){
  #slidingWindow calculates the errors using the integral of the absdifference function above
  #over fixed width intervals (1000 of the domain of the functions) for two piecewise step functions
  xMin=max(min(xVals1),min(xVals2))
  xMax=min(max(xVals1),max(xVals2))
  xIntegralValues=seq(xMin,xMax,length=1000)
  integrationVal=vector()
  for(i in 1:(length(xIntegralValues)-1)){
    integrationReturn=integrate(absdifference,xIntegralValues[i],xIntegralValues[i+1], func1x=xVals1, func1y=yVals1, func2x=xVals2, func2y=yVals2, subdivisions=100)
    integrationVal[i]=integrationReturn$value
  }
  xCentredValues=(xIntegralValues[-1]+xIntegralValues[-length(xIntegralValues)])/2
  returnedValues=data.frame()
  returnedValues=cbind(xCentredValues,integrationVal)
  colnames(returnedValues)=c("centredXValue","integrationValue")
  plot(xCentredValues,integrationVal,"s",log='x',xlab='Time in the past (N_0 generations ago)',ylab='Error')
  return(returnedValues)
}
########################################################################
#EXAMPLE USE OF THE SCRIPT
########################################################################
system2('../../myScripts/removeDataFromPSMC.sh', args='1Chromsome30Mbp/fullData.psmcfa.psmc',stdout='1Chromsome30Mbp/fullData.txt')
system2('../../myScripts/removeDataFromPSMC.sh', args='1Chromsome30Mbp/thousandTwentyFourthData.psmcfa.psmc',stdout='1Chromsome30Mbp/splitData.txt')
fullData<-read.table('1Chromsome30Mbp/fullData.txt',header=T)
splitData<-read.table('1Chromsome30Mbp/splitData.txt',header=T)
slidingWindow(fullData$t_k,fullData$lambda_k,splitData$t_k,splitData$lambda_k)
