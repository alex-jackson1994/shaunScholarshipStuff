#!/usr/bin/python
import sys
#from tkinter.filedialog import askopenfilename

if len(sys.argv) > 1:
	filename = sys.argv[1] #take filename as a system argument
else:	
	print("You haven't provided a file correctly")
	#filename = askopenfilename() #pop up box to choose file to load in
	
with open(filename) as infile: #lets python realise a variable called infile exists without loading it into memory!
	headerLine=infile.readline()
	integersInHeader=[int(s) for s in str.split() if s.isdigit()]
	for line in infile: #loop over each line in the file
		if ">" in line or "@" in line or "//" in line:
			continue
		else:
			#write line to file if it's just a continuing part of the sequence
			print(line, file=open("combined"+filename, 'a'), end='')
