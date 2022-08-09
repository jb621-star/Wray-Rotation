#!/bin/bash
#SBATCH --output=TADs.HiC.matrix.out
#SBATCH -p common
#SBATCH --mem 300G

module load Anaconda3/2021.05
source /hpc/group/biostat/jb621/miniconda3/etc/profile.d/conda.sh
conda activate /hpc/group/wraylab/jb621/envs/HiCExplorer

hicFindTADs -m K562_3reps_corrected.h5 \
 --outPrefix K562_3reps_TAD_step1500_min3000_max31500_thres0.05_delta0.01_fdr \
 --thresholdComparisons 0.05 \
 --delta 0.01 \
 --correctForMultipleTesting fdr \
 -p 64 \

hicFindTADs --matrix K562_3reps_corrected.h5 \
 --outPrefix K562_3reps_TAD_step1500_min10000_max40000_thres0.01_delta0.01_fdr \
 --thresholdComparisons 0.01 \
 --delta 0.01 \
 --correctForMultipleTesting fdr \
 -p 64 \

hicFindTADs --matrix K562_3reps_corrected.h5 \
 --outPrefix K562_3reps_TAD_step1500_min10000_max40000_thres0.005_delta0.01_fdr \
 --thresholdComparisons 0.005 \
 --delta 0.01 \
 --correctForMultipleTesting fdr \
 -p 64 \

hicFindTADs --matrix K562_3reps_corrected.h5 \
 --outPrefix K562_3reps_TAD_step1500_min10000_max40000_thres0.001_delta0.01_fdr \
 --thresholdComparisons 0.001 \
 --delta 0.01 \
 --correctForMultipleTesting fdr \
 -p 64 \

hicPlotTADs --tracks K562_3reps_track.ini --region chr14:20000000-40000000 \
-t 'K562 3 replicates TADs on chr14' -o K562_3reps_tads.pdf
