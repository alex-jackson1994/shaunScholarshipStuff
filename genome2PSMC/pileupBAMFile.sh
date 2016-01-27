#!/bin/bash
#NOTES: change removedBlankLinesBison.fasta to the reference genome fasta file
#change SteppeBison_A16121.Bison_UMD1_0.realigned.bam to the BAM File
#change the output file name SteppeBison.fq.gz to something informative. Keep .fq.gz
#Change the paths to samtools,bcftools and vcfutils

inputReferenceGenome=removedBlankLinesBison.fasta
inputBamFile=SteppeBison_A16121.Bison_UMD1_0.realigned.bam
simulationName=SteppeBison
../samtools-1.3/samtools mpileup -EA -Q20 -C50 -u -f $inputReferenceGenome $inputBamFile |../bcftools-1.3/bcftools call -c |../bcftools-1.3/vcfutils.pl vcf2fq |gzip> $simulationName'.fq.gz'
