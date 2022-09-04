#!bin/sh
# author: Hiroshi Kumagai

Mapping for RSEM
##繰り返し用コマンド-stranded-single end

SEQLIBS=(NC1 NC2 NC3 NC4 NC5 NC6 NC7 NC8 Ca1 Ca2 Ca3 Ca4 Ca5 Ca6 Ca7 Ca8 WT1 WT2 WT3 WT4 WT5 WT6 WT7 WT8 MT1 MT2 MT3 MT4 MT5 MT6 MT7 MT8)

for seqlib in ${SEQLIBS[@]}; do
STAR \
--outSAMtype BAM SortedByCoordinate \ ok
--quantMode TranscriptomeSAM \ ok
--runThreadN 4 \ ok
--outSAMattributes All \ 
--readFilesCommand gunzip -c \ ok
--genomeDir /Volumes/HDD14TB/RNAseq_expression/Tools/Ensembl_STAR_Mus_index \ ok
--readFilesIn ${seqlib}.fastq.gz \ ok
--outFileNamePrefix /Volumes/HDD14TB/RNAseq_expression/MOTSc_cast_unified/star_rsem/${seqlib}. Ok
done




#----------------
#RSEM-NUC-done
#----------------

SEQLIBS=(NC1 NC2 NC3 NC4 NC5 NC6 NC7 NC8 Ca1 Ca2 Ca3 Ca4 Ca5 Ca6 Ca7 Ca8 WT1 WT2 WT3 WT4 WT5 WT6 WT7 WT8 MT1 MT2 MT3 MT4 MT5 MT6 MT7 MT8)

for seqlib in ${SEQLIBS[@]}; do
rsem-calculate-expression \
--alignments \
--strandedness reverse \
--estimate-rspd \
--no-bam-output \
-p 12 \
${seqlib}.Aligned.toTranscriptome.out.bam \
/Volumes/HDD14TB/RNAseq_expression/Tools/Ensembl_RSEM-1.3.3_NUC_index_mus/Ensembl_RSEM_Mus_index \
/Volumes/HDD14TB/RNAseq_expression/MOTSc_cast_unified/star_rsem/rsem_results/${seqlib}
done

