#!/bin/bash
#SBATCH --output=convert.HiC.matrix.out
#SBATCH -p common
#SBATCH --mem 300G

module load Anaconda3/2021.05
source /hpc/group/biostat/jb621/miniconda3/etc/profile.d/conda.sh
conda activate /hpc/group/wraylab/jb621/envs/HiCExplorer

hicConvertFormat --matrices K562_3reps_corrected.h5 --inputFormat h5 --outFileName K562_3reps_GInteraction --outputFormat ginteractions
