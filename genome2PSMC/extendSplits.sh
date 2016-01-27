#!/usr/bin/bash
simulationName='steppeBison'
#~/Documents/SummerScholarship/psmc-master/utils/fq2psmcfa $simulationName'.fq.gz' > $simulationName'.psmcfa'
#python ~/Documents/SummerScholarship/myScripts/summaryStatisticsPsmcfa.py $simulationName'.psmcfa' > $simulationName'Summary.txt'
bpLength=2528997500 #$(tail -n 1 $simulationName'Summary.txt' | awk '{print $5}')
for timeInterval in '10*1' '20*1' '30*1' '40*1'
do
	oldStringName='steppeBison/'$simulationName'Bp'$bpLength'Int'$timeInterval'Split1024/'$simulationName'Bp'$bpLength'Int'$timeInterval'Split1024'
#	echo $oldStringName'start'
#	cp $simulationName'.psmcfa' $oldStringName'.psmcfa'
#	~/Documents/SummerScholarship/psmc-master/psmc -p $timeInterval $oldStringName'.psmcfa'>$oldStringName'.psmc'
#	bash ~/Documents/SummerScholarship/myScripts/removeDataFromPSMC.sh $oldStringName'.psmc'>$oldStringName'.txt'
#	python ~/Documents/SummerScholarship/myScripts/summaryStatisticsPsmcfa.py $oldStringName'.psmcfa' > $oldStringName'Summary.txt'
#	echo $oldStringName'end'
	for split in '2048' '4096' '8192' '16384' '32768' '65536' '131072'
	do
		stringName=$simulationName'Bp'$bpLength'Int'$timeInterval'Split'$split
		echo $stringName'start'
		python ~/Documents/SummerScholarship/myScripts/binarySplitPsmcfaPrint.py $oldStringName'.psmcfa' > $stringName'.psmcfa'
		~/Documents/SummerScholarship/psmc-master/psmc -p $timeInterval $stringName'.psmcfa'>$stringName'.psmc'
		bash ~/Documents/SummerScholarship/myScripts/removeDataFromPSMC.sh $stringName'.psmc'>$stringName'.txt'
		python ~/Documents/SummerScholarship/myScripts/summaryStatisticsPsmcfa.py $stringName'.psmcfa' > $stringName'Summary.txt'
		oldStringName=$stringName
		echo $stringName'end'
	done
	for split in '2048' '4096' '8192' '16384' '32768' '65536' '131072'
	do
		stringName=$simulationName'Bp'$bpLength'Int'$timeInterval'Split'$split
		mkdir $stringName
		mv $stringName'.psmc' $stringName'.psmcfa' $stringName'.txt' $stringName'Summary.txt' $stringName
	done
done
#mkdir $simulationName
mv $simulationName* $simulationName
7z a $simulationName