#!bin/sh
# author: Emma Kumagai
# concatenating files

filenames="/Volumes/HDD14TB/RNAseq_expression/MOTSc_cast/filename.txt"
MOTSc_cast="/Volumes/HDD14TB/RNAseq_expression/MOTSc_cast"
MOTSc_cast2="/Volumes/HDD14TB/RNAseq_expression/MOTSc_cast2"

cd /Volumes/HDD14TB/RNAseq_expression/


mkdir -p "MOTSc_cast_unified"

for file in `cat ${filenames}`; do
	cat ${MOTSc_cast}/temp/${file}* ${MOTSc_cast2}/temp/${file}* > MOTSc_cast_unified/${file}.fastq.gz
done

