#!/bin/bash
#USE: 'manyPsmc2Plot.sh'
#runs the plotting tool in psmc through every single applicable file in the current directory
#you'll probably need to change the file path since I set it up for my own use
for filename in *.psmcfa.psmc; do
        perl  ../../psmc-master/utils/psmc_plot.pl -pR "$filename.plot" "$filename"
	echo "$filename"
done
