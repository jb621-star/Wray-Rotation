#!/bin/bash
#SBATCH --output=CERES.Phylo.placental.int.out
#SBATCH -p common
#SBATCH --mem=300G

module load Bedtools/2.30.0

bedtools intersect -sorted -a CERES_OCRs.bed -b placentalMammals.phyloP46way.bedGraph -wa -wb > CERES.PhyloP.placental.inter.bed
