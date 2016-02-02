#!/usr/bin/bash

simulationName='lowerLimitTest'
timeInterval='40*1'
for recombRate in '10000' '50000' '100000' '150000' '200000' '1000000' '5000000'
do
	for bpLength in '10000' '50000' '100000' '500000' '1000000' '5000000'
	do			
		oldStringName=$simulationName'Bp'$bpLength'RecombRate'$recombRate
		echo $oldStringName'start'
		~/Documents/SummerScholarship/foreign-master/msHOT-lite/msHOT-lite 2 1 -t $recombRate -r $recombRate $bpLength -eN 0.0055 0.0832 -eN 0.0089 0.0489 -eN 0.0130 0.0607 -eN 0.0177 0.1072 -eN 0.0233 0.2093 -eN 0.0299 0.3630 -eN 0.0375 0.5041 -eN 0.0465 0.5870 -eN 0.0571 0.6343 -eN 0.0695 0.6138 -eN 0.0840 0.5292 -eN 0.1010 0.4409 -eN 0.1210 0.3749 -eN 0.1444 0.3313 -eN 0.1718 0.3066 -eN 0.2040 0.2952 -eN 0.2418 0.2915 -eN 0.2860 0.2950 -eN 0.3379 0.3103 -eN 0.3988 0.3458 -eN 0.4701 0.4109 -eN 0.5538 0.5048 -eN 0.6520 0.5996 -eN 0.7671 0.6440 -eN 0.9020 0.6178 -eN 1.0603 0.5345 -eN 1.4635 1.7931 -l > $oldStringName'.ms'			
		echo $oldStringName' simulation complete'
		perl ~/Documents/SummerScholarship/psmc-master/utils/ms2psmcfa.pl<$oldStringName'.ms'>$oldStringName'.psmcfa'
		echo $oldStringName' conversion to psmcfa complete'
        ~/Documents/SummerScholarship/psmc-master/psmc -p $timeInterval $oldStringName'.psmcfa'>$oldStringName'.psmc'
		echo $oldStringName' psmc complete'
		bash ~/Documents/SummerScholarship/myScripts/removeDataFromPSMC.sh $oldStringName'.psmc'>$oldStringName'.txt'
		echo $oldStringName' data removed'
		mkdir $oldStringName
		mv $oldStringName'.psmc' $oldStringName'.psmcfa' $oldStringName'.txt' $oldStringName'.ms' $oldStringName
		echo $oldStringName'end'
	done
done
mkdir $simulationName
mv $simulationName* $simulationName
7z a $simulationName.7z $simulationName