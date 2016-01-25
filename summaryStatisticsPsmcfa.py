#!/usr/bin/env python3
#USE: 'summaryStatisticsPsmcfa.py [inputFile.psmcfa] > [outputFile.txt]'
#This script takes a .psmcfa file and gives some summary statistics on how long each contig/chromsome is
#it returns a tab delimited table of the minimum, maximum, mean, median and total length of all the chromosomes
import sys
import statistics

if len(sys.argv) > 1:
	filename = sys.argv[1] #take filename as a system argument
else:
	sys.exit("You have incorrectly passed a filename, the correct syntax is: 'summaryStatisticsPsmcfa.py [inputFile.psmcfa] > [outputFile.txt]'")

chromoLengths=[]
currentLength=0
with open(filename) as infile: #uses python 3 to call lines from a file without having to load the whole thing into memory. 
	next(infile)
	for line in infile: #loop over each line in the file
		if ">" in line:#end whenever we reach a header in the file
			chromoLengths.append(currentLength) #figure out how many characters are on each line (note that each character represents a bin of 100 base pairs in a psmcfa file
			currentLength=0
		else:
			currentLength+=(len(line)-1) #subtract 1 to account for end of line characters we have no interest in
chromoLengths.append(currentLength)
print('min	max	mean	median	totalLength')
print(str(min(chromoLengths)*100)+'	'+str(max(chromoLengths)*100)+'	'+str(statistics.mean(chromoLengths)*100)+'	'+str(statistics.median(chromoLengths)*100)+'	'+str(sum(chromoLengths)*100))
