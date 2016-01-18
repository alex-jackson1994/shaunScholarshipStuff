#!/usr/bin/python
#This file takes a .psmcfa as an input file and then outputs a .psmcfa file to the command line where every chromosome/contig is split into two separate contigs. Generally called by 'python binarySplitPsmcfaPrint.py originalPsmcFile.psmcfa > splitFile.psmcfa'
import sys
from math import ceil
from random import shuffle


###############################################################
#Take an input file
###############################################################
if len(sys.argv)>1:
	filename=sys.argv[1] #take filename as a system argument
else:
	print('You have incorrectly passed a filename, the correct syntax is: python binarySplitPsmcfa.py [filename]')
###############################################################
# record line breaks for the file so to jump between lines later
# record header positions
###############################################################
headers=[] # define some empty lists for use later
chromoLength=[]
lineOffset=[]
offset=0

with open(filename) as infile: #lets python realise a variable called infile exists without loading it into memory!
	j=0
	#This loop both finds the position of every line break and of each header
	for line in infile: #loop over each line in the file
		lineOffset.append(offset)# Read in the file once and build a list of line breaks, this will allow us to jump to the line we need in the file
		offset += len(line)
		if ">" in line:
			headers.append(j) #find the header of each new chromosome/contig/etc in the file
		j+=1
headers.append(j) #add the end of the file to the headers list

###############################################################
# set up a list of random integers to use for randomising the positions of sequences
###############################################################
randomOrder=[i for i in range(0,len(headers)-1)]
shuffle(randomOrder)

###############################################################
#Calculate chromosome lengths
###############################################################
for i in range(0,len(headers)-1):
	chromoLength.append(headers[i+1]-headers[i]) #calculate the length of every chromosome in the file

###############################################################
#Iterate over random chromosomes and print them
###############################################################
with open(filename) as infile:
	for i in randomOrder:
		infile.seek(lineOffset[headers[i]])
		for j in range(0,chromoLength[i]-1):
		#j=0
		#while(j<chromoLength[i]):
			#j+=1
			line=infile.readline()
			print(line, end='')

