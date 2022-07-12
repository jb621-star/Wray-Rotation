#!/bin/bash
#SBATCH --output=HOMER.findMotifs.Cerbllm.out
#SBATCH -p common
#SBATCH --mem 300G

module load Anaconda3/2021.05
source /hpc/group/biostat/jb621/miniconda3/etc/profile.d/conda.sh
conda activate /hpc/group/wraylab/jb621/envs/condaHOMER

findMotifs.pl OCRs.motif.fa human /hpc/group/wraylab/jb621/K562_motifs/Cerbllm -fasta Cerbllm_OCRs.fa  
