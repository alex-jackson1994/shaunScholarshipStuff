#!/usr/bin/env python3
#THIS SCRIPT IS UNFINISHED! IT STILL NEEDS DEBUGGING! DO NOT USE YET!!!
#This scripts needs a description. Will YOU be the one to add it?

import sys
from random import random, randint

if len(sys.argv)==3:
	filename=sys.argv[1] #take filename as a system argument
	numMovements=int(sys.argv[2])
elif len(sys.argv)==2:
	filename=sys.argv[1] #take filename as a system argument
	numMovements=10
else:
	sys.exit('The correct syntax is: ./removeRandomContigs.py [filename] [probability=0.1]')

headers=[] # define some empty lists for use later
chromoLength=[]
lineOffset=[]
offset=0

with open(filename) as infile: #uses python 3 to call lines from a file without having to load the whole thing into memory. 
	j=0
	#This loop both finds the position of every line break and of each header
	for line in infile: #loop over each line in the file
		lineOffset.append(offset)# Read in the file once and build a list of line breaks, this will allow us to jump to the line we need in the file
		offset += len(line)
		if ">" in line:
			headers.append(j) #find the header of each new chromosome/contig/etc in the file
		j+=1
		
fileLength=j
headers.append(fileLength) #add the end of the file to the headers list

move=[]
seqLength=[]
moveTo=[]
for i in range(0,numMovements):
	move.append(randint(1,fileLength))
	seqLength.append(randint(1,fileLength))
	moveTo.append(randint(1,fileLength))
	
moveTo, move, seqLength = (list(t) for t in zip(*sorted(zip(moveTo, move, seqLength,))))
moveTo.append(fileLength+1)
move.append(fileLength+1)
seqLength.append(0)
print(moveTo,move,seqLength)
with open(filename) as infile: #uses python 3 to call lines from a file without having to load the whole thing into memory. 
	j=0
	i=0
	for line in infile: #loop over each line in the file
		if j==moveTo[i]:
			for k in range(0,seqLength[i]):
				if move[i]+k<fileLength:
					infile.seek(lineOffset[move[i]+k])
					print(line,end='')
				else:
					seqLength[i]=k
					break
			infile.seek(lineOffset[move[i]])
			i+=1
			j+=1
		elif j in move:
			j+=seqLength[move.index(j)]
			infile.seek(lineOffset[j])
		else:
			j+=1
			print(line,end='')
			
			
			