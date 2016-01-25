#!/bin/bash
#USE: 'combineFastaChunks.sh [inputFile.fa] > [outputFile.fa]'
#this quick script combines all the chromosomes/contigs in a single FASTA format file into a single chromosome. Should be reasonably obvious how considering it is only two lines
#grep -v finds all the lines that do not match the format i.e. anything that is not a header. $1 refers to the first command line argument
echo '>Chromosome1'
grep -v '>' $1
