#!/bin/bash
#SBATCH --output=make.HiC.matrix.out
#SBATCH -p common
#SBATCH --mem 300G

module load Anaconda3/2021.05
source /hpc/group/biostat/jb621/miniconda3/etc/profile.d/conda.sh
conda activate /hpc/group/wraylab/jb621/envs/HiCExplorer

hicFindRestSite --fasta /hpc/group/wraylab/jb621/HiC/fastq/SRR1658693_1.fastq --searchPattern GATC -o SRR1658693_1_rest_site_positions.bed

hicFindRestSite --fasta /hpc/group/wraylab/jb621/HiC/fastq/SRR1658693_2.fastq --searchPattern GATC -o SRR1658693_2_rest_site_positions.bed
