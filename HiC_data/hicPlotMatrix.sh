#!/bin/bash
#SBATCH --output=plot.HiC.matrix.out
#SBATCH -p common
#SBATCH --mem 300G

module load Anaconda3/2021.05
source /hpc/group/biostat/jb621/miniconda3/etc/profile.d/conda.sh
conda activate /hpc/group/wraylab/jb621/envs/HiCExplorer

hicPlotMatrix -m hicSRR1658693_corrected.h5 -o hicSRR1658693_plot.png --region 1:20000000-80000000 --log1p

