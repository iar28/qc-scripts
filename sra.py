#!/usr/bin/python
# Download SRA files 
#requires a list of SRA numbers to download ("SRR_Acc_List.txt")
import os

data = open("SRR_Acc_List.txt", "r")

for i in data:
    print ("Downloading accession:", i)
    os.system("fastq-dump --outdir '{0}' --gzip --skip-technical  --readids --read-filter pass --dumpbase --split-3 --clip {0}".format(i)) 
    
    
