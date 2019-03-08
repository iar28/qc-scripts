#!/bin/bash
#performs motif prediction from a list of Digital Genomic footprints associated with groups of genes

#Create an input file

ID_list=$1      # A single column csv file file containg gene IDs  
ANNOTATED=$2    # A file with the DGFs already annotated with gene IDs
OUTFILE1=$3     # An output file containing DGFs only for the genes of interest
GENOME=$4       # FASTA file of the genome sequence
FASTA_FILE=$5   # Output FASTA file for DGFs of interest

#Extract subset of DGF sequences
echo `awk '{print $1}' ${ID_list} | grep -f - ${ANNOTATED} > ${OUTFILE1}`

#extract FASTA sequences for DGFs
echo `bedtools getfasta -fi ${GENOME} -bed ${OUTFILE1} -fo ${FASTA_FILE}`

#Run HOMER
echo `findMotifs.pl ${FASTA_FILE} x x -fasta x`
