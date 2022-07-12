#!/bin/bash
#SBATCH --output=CERES.Phylo.placental.int.avg.out
#SBATCH -p common
#SBATCH --mem=300G

module load Bedtools/2.30.0

bedtools map -a CERES_OCRs.bed -b placentalMammals.phyloP46way.bedGraph -c 4 -o mean > CERES.PhyloP.placental.inter.avg.bed
