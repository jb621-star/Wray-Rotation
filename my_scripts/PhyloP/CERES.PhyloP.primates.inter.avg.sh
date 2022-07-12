#!/bin/bash
#SBATCH --output=CERES.Phylo.primates.int.avg.out
#SBATCH -p common
#SBATCH --mem=300G

module load Bedtools/2.30.0

bedtools map -a CERES_OCRs.bed -b primates.phyloP46way.bedGraph -c 4 -o mean > CERES.PhyloP.primates.inter.avg.bed
