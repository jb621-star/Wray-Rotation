#!/bin/bash
#SBATCH --output=mergeTADs.out
#SBATCH -p common
#SBATCH --mem 300G

module load Anaconda3/2021.05
source /hpc/group/biostat/jb621/miniconda3/etc/profile.d/conda.sh
conda activate /hpc/group/wraylab/jb621/envs/HiCExplorer

hicMergeDomains --domainFiles K562_3reps_TAD_step1500_min10000_max40000_thres0.01_delta0.05_fdr_domains.bed K562_3reps_TAD_step1500_min10000_max40000_thres0.01_delta0.01_fdr_domains.bed K562_3reps_TAD_step1500_min10000_max40000_thres0.01_delta0.005_fdr_domains.bed K562_3reps_TAD_step1500_min10000_max40000_thres0.01_delta0.001_fdr_domains.bed --outputMergedList K562_3reps_TAD_merged
