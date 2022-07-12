#!/bin/bash
#SBATCH --output=make.HiC.matrix.out
#SBATCH -p common
#SBATCH --mem 300G

module load Anaconda3/2021.05
module load BWA/0.7.17
source /hpc/group/biostat/jb621/miniconda3/etc/profile.d/conda.sh
conda activate /hpc/group/wraylab/jb621/envs/HiCExplorer

bwa index ./references/Homo_sapiens_assembly38.fasta
