#!/bin/bash
#SBATCH --output=correct.HiC.matrix.out
#SBATCH -p common
#SBATCH --mem 300G

module load Anaconda3/2021.05
source /hpc/group/biostat/jb621/miniconda3/etc/profile.d/conda.sh
conda activate /hpc/group/wraylab/jb621/envs/HiCExplorer

hicCorrectMatrix diagnostic_plot -m hicSRR1658693_matrix.h5 -o hicSRR1658693_corrected.png

# correct Hi-C matrix
hicCorrectMatrix correct -m hicSRR1658693_matrix.h5 --filterThreshold -1.2 5 -o hicSRR1658693_corrected.h5
