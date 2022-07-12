#!/bin/bash
#SBATCH --output=cactus.bw2bed.out
#SBATCH -p common

module load Anaconda3/2021.05
source /hpc/group/biostat/jb621/miniconda3/etc/profile.d/conda.sh
conda activate /hpc/group/wraylab/jb621/envs/condaBEDOPS 

wig2bed --multisplit=foo --do-not-sort < /hpc/group/wraylab/jb621/PhyloP/placentalMammals.phyloP46way.wig > /hpc/group/wraylab/jb621/PhyloP/placentalMammals.phyloP46way.bed
