#!/bin/bash
#SBATCH --output=OCRs_TADdomains_closest.out
#SBATCH -p common
#SBATCH --mem=300G

module load Bedtools/2.30.0

# Since we are identifying any candidate strong enhancer where the nearest core promoter is in a different TAD and then either removing or reassigning to the nearest core promoter within the same TADs, we will have the enhancer bed file be A
bedtools closest -a x_0011_df_phyloP_enh.bed -b x_0011_df_phyloP_prom.bed K562_3reps_TAD_domains_merged_cut_sorted.bed -filenames -k 2 -mdb each -d > OCRs_prom.enh_TADdomains_closest.bed

