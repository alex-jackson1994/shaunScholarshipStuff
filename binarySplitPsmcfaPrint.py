#!/usr/bin/env python3
#This file takes a .psmcfa as an input file and then outputs to the command line a .psmcfa file, where every chromosome/contig is split into two separate contigs. Generally called by 'python binarySplitPsmcfaPrint.py originalPsmcFile.psmcfa > splitFile.psmcfa'
#IMPORTANT NOTE!: One of the side effects of how this script works is that it splits chromosomes by line. That means the shortest a chromosome can ever be is a single line long.
#				  A single line of a .psmcfa file is the length times 100 base pairs (each character represents 100 base pairs).

import sys #use sys to take commandline inputs and to exit the program if it has an error
from math import ceil #use ceil when taking midpoints, need to round up

if len(sys.argv) > 1:
	filename = sys.argv[1] #take filename as a system argument
else:
	sys.exit('You have incorrectly passed a filename, the correct syntax is: python binarySplitPsmcfa.py [filename]')

headers=[] # define some empty lists for use later
midPositions=[]

with open(filename) as infile: #uses python 3 to call lines from a file without having to load the whole thing into memory. 
	j=0
	for line in infile: #loop over each line in the file
		j=j+1
		if ">" in line:
			headers.append(j) #find the header of each new chromosome/contig/etc in the file and record it

headers.append(j) #add the end of the file to the headers list
for i in range(0,len(headers)-1):
	if((headers[i+1]-headers[i])==2): #skip this header if it is only one line long. NOTE!!!: This means each sequence MUST be at least one line long which is the length of the line times 100 base pairs
		continue
	midPositions.append(ceil((headers[i]+headers[i+1])/2)) #find the midpoint of each chromosome by taking the rounded average of each header's position
numSplits=len(midPositions) 
midPositions.append(j+10) #add a number bigger than the end value to the list so no SEGFAULTS occur in the next section. A bit 'hacky' but it functions as it needs to

with open(filename) as infile: #uses python 3 to call lines from a file without having to load the whole thing into memory. 
	i=0
	j=0
	for line in infile: #loop over each line in the file
		j=j+1
		if(j==midPositions[i]): #if its at a midpoint of a chromosome add a new header to essentially split the chromosome appart
			print('>split'+str(headers[i])) 
			i=i+1
			print(line, end='')
		else: #otherwise continue printing the original file
			print(line, end='')
