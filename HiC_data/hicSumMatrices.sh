#!/bin/bash
#SBATCH --output=sum.HiC.matrices.out
#SBATCH -p common
#SBATCH --mem 300G

module load Anaconda3/2021.05
source /hpc/group/biostat/jb621/miniconda3/etc/profile.d/conda.sh
conda activate /hpc/group/wraylab/jb621/envs/HiCExplorer

hicSumMatrices --matrices hicSRR1658693_matrix.h5 hicSRR1658695_matrix.h5 hicSRR1658696_matrix.h5 --outFileName K562_3reps.h5 
