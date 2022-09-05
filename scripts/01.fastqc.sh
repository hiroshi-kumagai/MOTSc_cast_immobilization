#!/bin/bash
# Author: Emma Kumagai
# Generate fastQC repots for quality accessment

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

