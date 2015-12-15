#!/bin/bash
for filename in *.psmcfa; do
        ../../psmc-master/psmc "$filename">"$filename.psmc"
	echo "$filename"
done
