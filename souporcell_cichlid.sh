#!/bin/bash

# the next 4 lines of code is how souporcell is expected to be run. there is an
# issue with the singularity container provided though, so I run the souporcell
# python script directly (in run lines of code below). I am keeping the commented
# out code here though in case it is of interest to anyone in the future.

#singularity exec /path/to/souporcell_latest.sif souporcell_pipeline.py \
# -i ../data/juntti_cichlid_bam.bam -b ../data/barcodes.tsv.gz -f \
#../reference/Astatotilapia_burtoni_genomeNCBI2/fasta/reference.fasta -t 8 -o souporcell_output \
#-k 4



# call souporcell python script
# -i is input file is sorted bam
# -b is barcodes file from the cellranger output
# -f is the fasta file for the reference genome
# -t is how many compute threads to use
# -o is the name of the output directory
# -k is the number of clusters we expect (4 since we know there were 4 fish sequenced)

# Souporcell required installing freebayes. If you run this script, you need to
# ensure freebayes in installed on your machine
# The souporcell python script ran with errors as downloaded straight from the git.
# The python script used for our souporcell analysis has been modified.


souporcell_pipeline.py \
-i ~/scratch/reesyxan/juntti_cichlid/OE1_data/AburtOE1_TArun/outs/possorted_genome_bam.bam \
-b ~/scratch/reesyxan/juntti_cichlid/OE1_data/AburtOE1_TArun/outs/raw_feature_bc_matrix/barcodes.tsv.gz \
-f ~/scratch/reesyxan/juntti_cichlid/reference/Astatotilapia_burtoni_genomeNCBI2/Astatotilapia_burtoni_genomeNCBI2_gtfmod/fasta/genome.fa \
-t 8 \
-o OE1_souporcell \
-k 4


# Souporcell fails at the part where souporcell tries to merge vcf files. But it successfully creates all individual vcf files.
# When it fails, I created my own script (souporcell_merge_vcfs.sh) to finish the merging to get a final vcf file.

