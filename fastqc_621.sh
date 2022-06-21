#!/bin/bash -l

## Quality control sequencing by FASTQC
###quality of RNA-seq


module load fastqc/0.11.7
conda activate

fastqc *.fastq.gz 
multiqc *_fastqc.zip
