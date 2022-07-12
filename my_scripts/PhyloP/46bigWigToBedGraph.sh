#!/bin/bash
#SBATCH --output=46.bw2bedGraph.out
#SBATCH -p common
#SBATCH --mem 300G

module load Anaconda3/2021.05
source /hpc/group/biostat/jb621/miniconda3/etc/profile.d/conda.sh
conda activate /hpc/group/wraylab/jb621/envs/condaBEDOPS 

/hpc/group/wraylab/jb621/PhyloP/bigWigToBedGraph 241-mammalian-2020v2.bigWig 241-mammalian-2020v2.bedGraph
