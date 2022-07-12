#!/bin/bash
#SBATCH --output=CERES.Phylo.242.int.avg.out
#SBATCH -p common
#SBATCH --mem=300G

module load Bedtools/2.30.0

bedtools map -a CERES_OCRs.bed -b 241-mammalian-2020v2.bedGraph -c 4 -o mean > CERES.PhyloP.inter.avg.bed
