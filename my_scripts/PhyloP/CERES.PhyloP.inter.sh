#!/bin/bash
#SBATCH --output=CERES.Phylo.int.out
#SBATCH -p common
#SBATCH --mem=300G

module load Bedtools/2.30.0

bedtools intersect -sorted -a CERES_OCRs.bed -b 241-mammalian-2020v2.bed -wa -wb > CERES.PhyloP.inter.bed
