#!bin/bash

#retrieves DGFs annotated with the desired motifs and outputs a bed file

dat=$1

for d in `cat $dat`; 
do
	echo ${d}
	for a in *.bk
	do
		echo ${a}
		grep ${d} ${a} | awk -v OFS="\t" '{print $5}'|sed 's/\:/\t/'|sed 's/\-/\t/'|sort|uniq > "${d}.${a::-3}.bed"
#	

done

done

