#!/bin/bash
for filename in *.psmcfa.psmc; do
        perl  ../../psmc-master/utils/psmc_plot.pl -pR "$filename.plot" "$filename"
	echo "$filename"
done
