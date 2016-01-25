#!/usr/bin/bash
#simple script that generates data from msHOT-lite and then runs it through all the scripts that split the data up, preprocess for PSMC, does PSMC and then plots the data
#
../../foreign-master/msHOT-lite/msHOT-lite 2 100 -t 30000 -r 6000 3000000 -eN 0.01 0.1 -eN 0.06 1 -eN 0.2 0.5 -eN 1 1 -eN 2 2 -l >testData.ms
python ../../myScripts/splitMs.py testData.ms
bash ../../myScripts/manyMs2Psmcfa.sh 
bash ../../myScripts/manyPsmcfa2psmc.sh
bash ../../myScripts/manyPsmc2Plot.sh
