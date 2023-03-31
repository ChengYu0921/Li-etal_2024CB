#!/bin/bash

# this script is to merge all the vcfs created by souporcell.
# This script prints messages as it is running to let you know what step it is on.


print("merging vcfs")

# compress all vcf files
ls *.vcf | xargs -n1 -P1 bgzip -f


print("Invoked bgzip on the vcf files.")
print("Indexing " + vcf + ".")

# use bcftools to index the gzipped vcf files
bcftools index -f *.vcf.gz

print("Indexed the vcf files.")

# use bcftools to combine (concatinate) all the gzipped vcf files
bcftools concat -a *.vcf.gz

# create a file named vcf_filenames.txt that is a list of all files used to concatonate.
ls *.vcf.gz > vcf_filenames.txt


bcftools concat -a -f vcf_filenames.txt > souporcell_merged_vcf.vcf

print("Concatenated the vcf files.")

# sort merged vcf file
bcftools sort souporcell_merged_vcf.vcf > souporcell_merged_sorted_vcf.vcf
print("Sorted merged vcf file.")

# remove unsorted file to save space
rm souporcell_merged_vcf.vcf

# compress merged and sorted vcf file
bgzip souporcell_merged_sorted_vcf.vcf
print("Compressed the final merged sorted vcf file.")

# index the merged and sorted compressed vcf file
tabix -p vcf souporcell_merged_sorted_vcf.vcf.gz
print("Ran tabix on the final vcf file.")
