#!/bin/bash
#SBATCH --output=make.HiC.matrix.out
#SBATCH -p common
#SBATCH --mem 300G

module load Anaconda3/2021.05
source /hpc/group/biostat/jb621/miniconda3/etc/profile.d/conda.sh
conda activate /hpc/group/wraylab/jb621/envs/HiCExplorer

hicBuildMatrix --samFiles SRR1658693_R1.bam SRR1658693_R2.bam \
	       --outFileName hicSRR1658693.hg38 \
               --binSize 10000 \
               --restrictionSequence GATC \
               --danglingSequence GATC \
               --restrictionCutFile SRR1658693_rest_site_positions.bed \
               --threads 4 \
               --inputBufferSize 100000 \
               --outBam hicSRR1658693.bam \
               -o hicSRR1658693_matrix.h5 \
               --QCfolder ./hicQC
