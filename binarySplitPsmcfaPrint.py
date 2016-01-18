#!/usr/bin/python
#This file takes a .psmcfa as an input file and then outputs a .psmcfa file to the command line where every chromosome/contig is split into two separate contigs. Generally called by 'python binarySplitPsmcfaPrint.py originalPsmcFile.psmcfa > splitFile.psmcfa'
import sys
#import numpy as np
from math import ceil

if len(sys.argv) > 1:
	filename = sys.argv[1] #take filename as a system argument
else:
	print('You have incorrectly passed a filename, the correct syntax is: python binarySplitPsmcfa.py [filename]')

headers=[] # define some empty lists for use later
midPositions=[]

with open(filename) as infile: #lets python realise a variable called infile exists without loading it into memory!
	j=0
	for line in infile: #loop over each line in the file
		j=j+1
		if ">" in line:
			headers.append(j) #find the header of each new chromosome/contig/etc in the file

headers.append(j) #add the end of the file to the headers list
for i in range(0,len(headers)-1):
	if((headers[i+1]-headers[i])==2):
		continue
	midPositions.append(ceil((headers[i]+headers[i+1])/2)) #find the midpoint of each chromosome by taking the rounded average of each header's position
numSplits=len(midPositions) 
midPositions.append(j+10) #add an arbitrarily large value to the list so no SEGFAULTS occur in the next section

with open(filename) as infile: #lets python realise a variable called infile exists without loading it into memory!
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
