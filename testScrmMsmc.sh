date
./scrm-master/scrm 2 1 -t 10 -r 4 100000 -eN 0.5 1 -eN 1 2 -eN 2 0.5| ./msmc-tools-master/ms2multihetsep.py 1 10000 > msmcScrmTest
#./scrm-master/scrm 2 10 -t 4 -r 4 100 -eN 0.5 1 -eN 1 2 -eN 2 0.5 > testScrmOutput
#date
#./msmc-tools-master/ms2multihetsep.py 1 100 <testScrmOutput >msmcScrmTest
date
./msmc-master/build/msmc msmcScrmTest -o msmcOutput
date

#R CMD BATCH plotMsmc.R finish.txt | cat finish.txt



