#!/usr/bin/python
import sys
import statistics

if len(sys.argv) > 1:
	filename = sys.argv[1] #take filename as a system argument
else:
	print('You have incorrectly passed a filename, the correct syntax is: python binarySplitPsmcfa.py [filename]')

chromoLengths=[]
currentLength=0
with open(filename) as infile: #lets python realise a variable called infile exists without loading it into memory!
	next(infile)
	for line in infile: #loop over each line in the file
		if ">" in line:
			chromoLengths.append(currentLength)
			currentLength=0
		else:
			currentLength+=len(line)
chromoLengths.append(currentLength)
print('min	max	mean	median')
print(str(min(chromoLengths)*100)+'	'+str(max(chromoLengths)*100)+'	'+str(statistics.mean(chromoLengths)*100)+'	'+str(statistics.median(chromoLengths)*100))
