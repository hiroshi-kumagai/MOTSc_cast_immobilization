#!bin/sh
# author: Emma Kumagai
# checking strandness

# targets
ID="Ca1.fastq.gz"  # check

# input: bam file directory 
BAMDIR="/Volumes/HDD14TB/RNAseq_expression/MOTSc_cast_unified/star"

# ref: bed file directory
BEDFILE="/Users/Emma/Documents/Bioinformatics/RefGenome/ENSEMBLE/Homo_sapiens.GRCh38.104.bed"

# outdir
OUTDIR="/Users/Emma/Documents/Bioinformatics/DEG/MetaAnalysisProject_Apr2021/${TYPE}/${TARGET}/"

# for bam in `ls ${FASTQDIR}` | while read line; do
infer_experiment.py -r ${BEDFILE} -i ${BAMDIR}${ID} > ${OUTDIR}${ID}_strand_stat.txt

