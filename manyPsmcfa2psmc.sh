#!/bin/bash
for filename in *.psmcfa; do
        ../../psmc-master/psmc -p "100*1" "$filename">"$filename.psmc"
	echo "$filename"
done
