#!/bin/bash
#this script doesn't work. I was trying to get something to work where all teh file paths were specified at the beginning and then called and run later in the script. I gave up after it was consuming too much time and made the script runSimulations.sh which uses absolute file paths. This could be fixed by someone with a better knowledge of bash than I had when I wrote this.

mshotlite="~/Documents/SummerScholarship/foreign-master/msHOT-lite/msHOT-lite 2 1 -t 65130 -r 10973 $(printf $bpLength) -eN 0.0055 0.0832 -eN 0.0089 0.0489 -eN 0.0130 0.0607 -eN 0.0177 0.1072 -eN 0.0233 0.2093 -eN 0.0299 0.3630 -eN 0.0375 0.5041 -eN 0.0465 0.5870 -eN 0.0571 0.6343 -eN 0.0695 0.6138 -eN 0.0840 0.5292 -eN 0.1010 0.4409 -eN 0.1210 0.3749 -eN 0.1444 0.3313 -eN 0.1718 0.3066 -eN 0.2040 0.2952 -eN 0.2418 0.2915 -eN 0.2860 0.2950 -eN 0.3379 0.3103 -eN 0.3988 0.3458 -eN 0.4701 0.4109 -eN 0.5538 0.5048 -eN 0.6520 0.5996 -eN 0.7671 0.6440 -eN 0.9020 0.6178 -eN 1.0603 0.5345 -eN 1.4635 1.7931 -l > $(printf $oldStringName).ms"

oldpsmc="~/Documents/SummerScholarship/psmc-master/psmc -p "$timeInterval" "$oldStringName".psmcfa>"$oldStringName".psmc"
oldremoveDataFromPSMC="bash ~/Documents/SummerScholarship/myScripts/removeDataFromPSMC.sh "$oldStringName".psmc>"$oldStringName".txt"
ms2psmcfa="perl ~/Documents/SummerScholarship/psmc-master/utils/ms2psmcfa.pl<"$oldStringName".ms>"$oldStringName".psmcfa"

psmc="~/Documents/SummerScholarship/psmc-master/psmc -p "$timeInterval" "$stringName".psmcfa>"$stringName".psmc"
removeDataFromPSMC="bash ~/Documents/SummerScholarship/myScripts/removeDataFromPSMC.sh "$stringName".psmc>"$stringName".txt"
binarySplit="python ~/Documents/SummerScholarship/myScripts/binarySplitPsmcfaPrint.py "$stringName".psmcfa>"$stringName".psmcfa"

simulationName='fauxHuman'
for timeInterval in '10*1' '20*1' '30*1' '40*1'
do
	for bpLength in '100000' '500000' '1000000' '5000000' '10000000' '20000000'
	do			
		oldStringName=$simulationName'Bp'$bpLength'Int'$timeInterval'Split1'
		echo 'Start ' $oldStringName
		eval $mshotlite
		eval $ms2psmcfa
		eval $oldpsmc
		eval $oldremoveDataFromPSMC
#		$mshotlite 2 1 -t 65130 -r 10973 $bpLength -eN 0.0055 0.0832 -eN 0.0089 0.0489 -eN 0.0130 0.0607 -eN 0.0177 0.1072 -eN 0.0233 0.2093 -eN 0.0299 0.3630 -eN 0.0375 0.5041 -eN 0.0465 0.5870 -eN 0.0571 0.6343 -eN 0.0695 0.6138 -eN 0.0840 0.5292 -eN 0.1010 0.4409 -eN 0.1210 0.3749 -eN 0.1444 0.3313 -eN 0.1718 0.3066 -eN 0.2040 0.2952 -eN 0.2418 0.2915 -eN 0.2860 0.2950 -eN 0.3379 0.3103 -eN 0.3988 0.3458 -eN 0.4701 0.4109 -eN 0.5538 0.5048 -eN 0.6520 0.5996 -eN 0.7671 0.6440 -eN 0.9020 0.6178 -eN 1.0603 0.5345 -eN 1.4635 1.7931 -l > $oldStringName'.ms'			
#		$ms2psmcfa<$oldStringName'.ms'>$oldStringName'.psmcfa'
#       $psmc -p $timeInterval $oldStringName'.psmcfa'>$oldStringName'.psmc'
#		$removeDataFromPSMC $oldStringName'.psmc'>$oldStringName'.txt'
		mkdir $oldStringName
		mv $oldStringName'.ms' $oldStringName'.psmc' $oldStringName'.psmcfa' $oldStringName'.txt' $oldStringName
		echo 'End ' $oldStringName
		for splitNum in '2' '4' '8' '16' '32' '64' '128' '256' '512' '1024'
		do
			stringName=$simulationName'Bp'$bpLength'Int'$timeInterval'Split'$splitNum
			echo 'Start '$stringName
			mkdir $stringName
			eval $binarySplit
			eval $psmc
			eval $removeDataFromPSMC
#			$binarySplit $oldStringName'.psmcfa' > $stringName'.psmcfa'
#       	$psmc -p $timeInterval $stringName'.psmcfa'>$stringName'.psmc'
#			$removeDataFromPSMC $stringName'.psmc'>$stringName'.txt'
			oldStringName=$stringName
			mv $stringName'.psmc' $stringName'.psmcfa' $stringName'.txt' $stringName
			echo 'End ' $stringName
		done
	done
done