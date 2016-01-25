#!/bin/bash
#USE: 'manyPsmcfa2psmc.fa'
#runs all the applicable *.psmcfa files in a folder through PSMC, modify for own use
for filename in *.psmcfa; do
        ../../psmc-master/psmc -p "10*1" "$filename">"$filename.psmc"
	echo "$filename"
done
