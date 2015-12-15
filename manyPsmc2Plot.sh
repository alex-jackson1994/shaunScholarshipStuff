#!/bin/bash
for filename in *.psmcfa.psmc; do
        perl  ../../psmc-master/utils/psmc_plot.pl -p "$filename.plot" "$filename"
	echo "$filename"
done
