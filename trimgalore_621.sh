#!/bin/bash -l

##TrimGalore
##Remove adaptors 


conda activate



/net/hawkins/vol1/home/aolima/miniconda2/bin/trim_galore --path_to_cutadapt /net/hawkins/vol1/home/aolima/miniconda2/bin/cutadapt  --illumina --three_prime_clip_R1 15 --clip_R2 15 --dont_gzip --paired  SG24_R1.fastq SG24_R2.fastq -o out


