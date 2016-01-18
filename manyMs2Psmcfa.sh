#!/bin/bash
#this script runs every MS file in a directory through ms2psmcfa.pl
for filename in *.ms; do
        perl ../../psmc-master/utils/ms2psmcfa.pl<"$filename">"$filename.psmcfa"
	echo "$filename"
done
