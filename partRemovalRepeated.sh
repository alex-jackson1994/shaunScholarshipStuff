#!/usr/bin/bash
#USE: 'bash partRemovalRepeated.sh' which will need to either have simulationName.fq.gz or simulationName.psmcfa in the current directory
#This script was used to produce data for regression using the Steppe Bison genome. The data was split up into approximately 10%,20%,30% ... 90% of the original data
#Note this is only approximate since I used a random number generator and a bernoulli trial to decide whether the data should be kept or skipped
#can change the simulationName below to run through all the scripts and obtain output easily enough
#program paths will also need to be altered
simulationName='sim2'
#~/Documents/SummerScholarship/psmc-master/utils/fq2psmcfa $simulationName'.fq.gz' > $simulationName'.psmcfa'

for probability in '0' '0.1' '0.2' '0.3' '0.4' '0.5' '0.6' '0.7' '0.8' '0.9'
do
	echo $probability' started running'
	stringName=$simulationName'Prob'$probability
	python ~/Documents/SummerScholarship/myScripts/removeRandomPartsFromPsmcfa.py $simulationName'.psmcfa' $probability > $stringName'.psmcfa'
	echo $probability' partitioned'
	~/Documents/SummerScholarship/psmc-master/psmc -p "40*1" $stringName'.psmcfa'>$stringName'.psmc'
	echo $probability' PSMCed'
	bash ~/Documents/SummerScholarship/myScripts/removeDataFromPSMC.sh $stringName'.psmc'>$stringName'.txt'
	python ~/Documents/SummerScholarship/myScripts/summaryStatisticsPsmcfa.py $stringName'.psmcfa' > $stringName'Summary.txt'
	echo $probability' collected data'
	mkdir $stringName
	mv $stringName'.psmc' $stringName'.psmcfa' $stringName'.txt' $stringName'Summary.txt' $stringName
	echo $probability' done'
done
mkdir $simulationName
mv $simulationName* $simulationName
7z a $simulationName.7z $simulationName