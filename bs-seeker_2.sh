#!/bin/bash
#$ -S /bin/bash
#!/usr/bin/env python
#$ -pe serial 4
#$ -l mfree=15G -l h_rt=550:00:00
#$ -o /net/hawkins/vol1/home/aolima/WGBS_2104/BS_FAANG_PE_0825/
#$ -e /net/hawkins/vol1/home/aolima/WGBS_2104/BS_FAANG_PE_0825/
##################################################################
##Align using BS2
##FAANG
#################################################################

conda activate



cd {dir}

 python /net/hawkins/vol1/home/aolima/miniconda2/bin/bs_seeker2-align.py \
        -1 R1_fq -2 R2_fq  \
        -d /net/hawkins/vol1/home/aolima/genome_ncbi/bs2-index -f bam -p /net/hawkins/vol1/home/aolima/tools/bowtie2-2.4.4 --aligner=bowtie2 \
        -o {sample}_bs2.bam  -g /net/hawkins/vol1/home/aolima/genome_ncbi/GCF_016699485.2_bGalGal1.mat.broiler.GRCg7b_genomic.fna



