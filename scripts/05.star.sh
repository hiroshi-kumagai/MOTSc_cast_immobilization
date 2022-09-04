#!/bin/sh
# author: Emma Kumagai
# alignment by STAR

# directories
PROJECTDIR="/Volumes/HDD14TB/RNAseq_expression/MOTSc_cast_unified"
FASTPDIR="${PROJECTDIR}/fastp"
# creating a directory for output
mkdir -p ${PROJECTDIR}/star
OUTDIR="${PROJECTDIR}/star"

# index directory
INDEXDIR="/Volumes/HDD14TB/RNAseq_expression/Tools/Ensembl_STAR_Mus_index"

# number of files to be processed
FILES=`ls ${FASTPDIR}/*.fastq.gz | wc -l`  # single
#FILES=$(ls ${FASTPDIR}/*.fastq.gz | wc -l)  # pair
#FILES=$((FILES/2))  # pair
FILEIDS="${PROJECTDIR}/filename.txt"

# time
script_started=`date +%s`

# STAR
cd ${FASTPDIR}
count=1


cat ${FILEIDS} | while read line; do
    SECONDS=0
    echo STAR ${count} /${FILES}: ${line} `date "+%m/%d/%Y %H:%M:%S"`
    
    echo decompressing fastq.gz...
    echo running STAR...
    STAR \
    --runThreadN 4 \
    --readFilesCommand gunzip -c \
    --readFilesIn ${line}.fastp.fastq.gz \
    --genomeDir ${INDEXDIR} \
    --outSAMtype BAM SortedByCoordinate \
    --outFileNamePrefix ${OUTDIR}/${line}. \
    --outReadsUnmapped Fastx \
    #--outFilterScoreMinOverLread 0 \
    #--outFilterMatchNminOverLread 0 \
    #--outFilterMatchNmin 0 \
    #--outFilterMismatchNmax 2 
    
    # processed time for one file
    echo finished ${line} `date "+%m/%d/%Y %H:%M:%S"`
    h=$(($SECONDS/3600))
    m=$((($SECONDS/60)%60))
    s=$(($SECONDS%60))
    echo processed time: ${h}:${m}:${s}
    
    # elapsed time so far
    elapsed_time=`date +%s`
    elapsed=$((elapsed_time - script_started))
    eh=$(($elapsed/3600))
    em=$((($elapsed/60)%60))
    es=$(($elapsed%60))
    echo elapsed: ${eh}:${em}:${es}
    
    echo processed files: `ls ${OUTDIR}/*.Aligned.sortedByCoord.out.bam | wc -l` /${FILES}
    count=$((count+1))
    echo "\n"
done

echo STAR finished


# moving files
cd ${OUTDIR}
mkdir -p log finallog sjout unmapped
echo sorting directory...
mv *.final.out finallog
mv *.Log* log
mv *.SJ.out.tab sjout
mv *.Unmapped.out.mate* unmapped

echo finished

