#!/bin/bash
#USE: 'manyMs2Psmcfa.sh'
#this script runs every MS file in a directory through ms2psmcfa.pl
#convinient little script to quickly run a lot of ms simulations through preprocessing for psmc
for filename in *.ms; do
        perl ../../psmc-master/utils/ms2psmcfa.pl<"$filename">"$filename.psmcfa"
	echo "$filename"
done
