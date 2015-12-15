#!/bin/bash
for filename in *.ms; do
        perl ../../psmc-master/utils/ms2psmcfa.pl<"$filename">"$filename.psmcfa"
	echo "$filename"
done
