#!/usr/bin/bash
#../../foreign-master/msHot-lite/msHot-lite 2 100 -t 30000 -r 6000 30000000 -eN 0.01 0.1 -eN 0.06 1 -eN 0.2 0.5 -eN 1 1 -eN 2 2 -l >testData.ms
python ../../myScripts/splitMs.py testData.ms
bash ../../myScripts/manyMs2Psmcfa.sh 
bash manyPsmcfa2psmc.sh
bash manyPsmc2Plot.sh
