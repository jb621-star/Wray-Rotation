#!/bin/bash
#SBATCH --output=TADs.HiC.matrix.out
#SBATCH -p common
#SBATCH --mem 300G

module load Anaconda3/2021.05
source /hpc/group/biostat/jb621/miniconda3/etc/profile.d/conda.sh
conda activate /hpc/group/wraylab/jb621/envs/HiCExplorer

#hicFindTADs -m hicSRR1658693_corrected.h5 --outPrefix hicSRR1658693_corrected --correctForMultipleTesting fdr --numberOfProcessors 16

hicPlotTADs --tracks hicSRR1658693_track.ini --region chr14:20000000-90000000 \
-t 'SRR1658693 TADs on chr14' -o SRR1658693_tads.pdf
