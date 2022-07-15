This describes the process of creating the bedgraph-style PhyloP scores averged across all the K562 DHS's.
Make sure that you have created a conda environment with BEDOPS installed, as it contains the executable bigWigToBedGraph that will perform the
the conversion mentioned below.

1. After downloading the raw .wig files off of UCSC, use 46bigWigToBedGraph.sh to convert the file to bedgraph to then be averaged.
2. Find the DHSs of interest and convert them into .bed format. My version here is named CERES_OCRs.bed.
3. Depending on which organism you are interested in, and your preference for the PhyloP scores, there are a few options:
  a. run CERES.PhyloP."organism".inter.sh, which uses the bedtools "Intersect" tool to give you the PhyloP scores at single-base resolution for your inputted DHSs.
  b. run CERES.PhyloP."organism".inter.avg.sh, which uses the bedtools "map" tool to give you the AVERAGE PhyloP score across the DHS interval. 
4. OCRsbed.R will read in the resulting scores and integrate them with your dataset, and perform the visualization of the phyloP scores, as well as our later
  experimentation with the scores
