#!/usr/bin/env python3
#This script splits up every chromosome/contig in a MS format file into a separate text file
import sys

if len(sys.argv) > 1:
    filename = sys.argv[1] #take filename as a system argument
else:
    sys.exit("File path not given")
#	filename = askopenfilename() #pop up box to choose file to load in
	
with open(filename) as infile: #uses python 3 to call lines from a file without having to load the whole thing into memory. 
	j=0
	for line in infile: #loop over each line in the file
		if "//" in line:
			#iterate to next text file and write line if it's the header of a sequence
			j=j+1
			print(line, file=open(str(j)+'.ms', 'a'), end='')
		else:
			#write line to file if it's just a continuing part of the sequence
			print(line, file=open(str(j)+'.ms', 'a'), end='')
