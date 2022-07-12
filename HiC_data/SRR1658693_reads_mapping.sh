#!/bin/bash
#SBATCH --output=reads.mapping.out
#SBATCH -p common
#SBATCH --mem 300G

module load Anaconda3/2021.05
module load BWA/0.7.17
module load samtools/1.14-rhel8
source /hpc/group/biostat/jb621/miniconda3/etc/profile.d/conda.sh
conda activate /hpc/group/wraylab/jb621/envs/HiCExplorer

# map the reads, each mate individually using
# for example bwa
#
# bwa mem mapping options:
#       -A INT        score for a sequence match, which scales options -TdBOELU unless overridden [1]
#       -B INT        penalty for a mismatch [4]
#       -O INT[,INT]  gap open penalties for deletions and insertions [6,6]
#       -E INT[,INT]  gap extension penalty; a gap of size k cost '{-O} + {-E}*k' [1,1] # this is set very high to avoid gaps
#                                  at restriction sites. Setting the gap extension penalty high, produces better results as
#                                  the sequences left and right of a restriction site are mapped independently.
#       -L INT[,INT]  penalty for 5'- and 3'-end clipping [5,5] # this is set to no penalty.

bwa mem -A1 -B4  -E50 -L0  /hpc/group/wraylab/jb621/HiC/references/Homo_sapiens_assembly38.fasta \
    ./fastq/SRR1658693_1.fastq 2>>SRR1658693_R1.log | samtools view -bhS - > SRR1658693_R1.bam

bwa mem -A1 -B4  -E50 -L0  /hpc/group/wraylab/jb621/HiC/references/Homo_sapiens_assembly38.fasta \
    ./fastq/SRR1658693_2.fastq 2>>SRR1658693_R2.log | samtools view -bhS - > SRR1658693_R2.bam
