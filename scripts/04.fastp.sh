#!/bin/sh
# author: Emma Kumagai
# trimming low quality reads by fastp
# adapter trimming is enabled by default
# detecting adapter is TRUE for single end by default


# fastq directory
FASTQDIR="/Volumes/HDD14TB/RNAseq_expression/MOTSc_cast_unified"

# output directory
mkdir -p ${FASTQDIR}/fastp
FASTPDIR="${FASTQDIR}/fastp"

cd ${FASTPDIR}
mkdir -p html json

filenames="/Volumes/HDD14TB/RNAseq_expression/MOTSc_cast/filename.txt"
for file in `cat ${filenames}`; do
    echo fastp: ${file}
    # single end
    # -3: enable per read cutting by quality in tail (3'), default is disabled
    # (WARNING: this will interfere deduplication for SE data)
    fastp -i ${FASTQDIR}/${file}*.fastq.gz -o ${file}.fastp.fastq.gz \
    -h html/${file}.report.html -j json/${file}.report.json --thread 10 -q 20 --trim_tail1 1
    
    # pair enabled
    # fastp -i ${FASTQDIR}/${seqlib}_1.fastq.gz -I ${FASTQDIR}/${seqlib}_2.fastq.gz -3 \
    # -o ${seqlib}_1.fastp.fastq.gz -O ${seqlib}_2.fastp.fastq.gz \
    # --detect_adapter_for_pe \
    # -h html/${seqlib}.report.html -j json/${seqlib}.report.json \
    # -q 20 --trim_tail1 1 --trim_tail2 1 -l 20 --thread 4
    echo number of fastp files: `ls *.fastp.fastq.gz | wc -l`
    echo "\n"
done

echo finished

