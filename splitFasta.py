#!/usr/bin/env python3
#USE: 'splitFasta.py [inputFile]'
#This script splits up every chromosome and contig in a FASTA format file into a separate text file name after the header for that chromosome

import sys

if len(sys.argv) > 1:
	filename = sys.argv[1] #take filename as a system argument
else:
	sys.exit("Correct syntax: 'splitFasta.py [inputFile]'")
with open(filename) as infile: #uses python 3 to call lines from a file without having to load the whole thing into memory. 
	j=0
	for line in infile: #loop over each line in the file
		j=j+1
		if ">" in line:
			firstSpace=line.find(' ')
			newFileName=line[1:firstSpace]
			#iterate to next text file and write line if it's the header of a sequence
			j=j+1
			print(line, file=open(newFileName, 'a'), end='')
		else:
			#write line to file if it's just a continuing part of the sequence
			print(line, file=open(newFileName, 'a'), end='')
