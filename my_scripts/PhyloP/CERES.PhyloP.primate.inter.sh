#!/bin/bash
#SBATCH --output=CERES.Phylo.primates.int.out
#SBATCH -p common
#SBATCH --mem=300G

module load Bedtools/2.30.0

bedtools intersect -sorted -a CERES_OCRs.bed -b primates.phyloP46way.bed -wa -wb > CERES.PhyloP.primates.inter.bed
