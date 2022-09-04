#!/bin/bash
# author: Emma Kumagai
# creating fastQC repots

# directories
PROJECTDIR="/Volumes/HDD14TB/RNAseq_expression/MOTSc_cast_unified"
mkdir -p ${PROJECTDIR}/fastqc
FASTQCDIR="${PROJECTDIR}/fastqc"

# run FastQC
cd ${PROJECTDIR}
for file in `ls *fastq.gz`; do
    fastqc -t 10 --nogroup -o ${FASTQCDIR} ${file}
    echo number of FastQC processed: `ls ${FASTQCDIR}/*fastqc.zip | wc -l`
    echo "\n" 
done

echo finished


# fastqc -t 12 -o /Volumes/HDD14TB/RNAseq_expression/MOTSc_cast_unified/fastqc /Volumes/HDD14TB/RNAseq_expression/MOTSc_cast_unified/fastp/Ca1.fastp.fastq.gz