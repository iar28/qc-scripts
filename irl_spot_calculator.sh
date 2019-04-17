#!/bin/bash

#calculate spot scores 
#from sean and adapted by Ivan

if [ "$1" = "--help" ] ; then
  echo "This programme will calculate SPOT scores from .bam or tagAlign files"
  echo "Requirements: DHS file in bed format, bedtools"
  echo "irl_spot_calculator.sh <bam/tagAlign> <DHS in bed format>"
  exit 0

fi

f1=$1
DHS=$2

#convert .bam to tagAlign
if [ "$f1" == "*.bam"]; then
do
samtools view -F 0x0204 ${a} -o - | awk 'BEGIN{OFS="\t"}{if (and($2,16) > 0) {print $3,($4-1),($4-1+length($10)),"N","1000","-"} else {print $3,($4-1),($4-1+length($10)),"N","1000","+"} }' | gzip -c > ${f1}.tagAlign
done


awk 'BEGIN{OFS="\t"};{print $1, $2, $3'} ${DHS} > dhs_OUTBED;
zcat ${f1}.tagAlign | shuf | head -n 5000000 - > T_BEDFILE;
SPT=`bedtools intersect -f 1E-9 -wa -u -a T_BEDFILE -b dhs_OUTBED -bed | wc -l`;
echo "SPOT SCORE FOR ${f1}"
echo "scale=2; ${SPT}/5000000" | bc
done

rm dhs_OUTBED
rm T_BEDFILE
