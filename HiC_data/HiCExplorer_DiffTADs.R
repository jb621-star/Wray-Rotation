# Importing HiCExplorer data to Bioconductor
library(GenomicRanges)
library(InteractionSet)
library(readr)
library(data.table)

#Reading in interactions by chromosomes
hic <- fread("/Users/jamesonblount/Downloads/K562_3reps_GInteraction.head.tsv")
#hic <- read.big.matrix("/Users/jamesonblount/Downloads/K562_3reps_GInteraction.tsv", sep = "\t")
# data.table package
#hic_dt <- as.data.table(hic) 

# Getting col names
#colnames(hic_dt) <- c("intst_chr", "intst_start", "intst_end",
#                      "intend_chr", "intend_start", "intend_end", "intfreq")

#Converting data.frame to GInteraction
convertToGI <- function(df){
  row.regions <- GRanges(df$V1, IRanges(df$V2,df$V3))# interaction start
  col.regions <- GRanges(df$V4, IRanges(df$V5,df$V6))# interaction end
  gi <- GInteractions(row.regions, col.regions)
  gi$norm.freq <- df$V7 # Interaction frequencies
  return(gi)
}

hic.gi <- convertToGI(hic)
hic.gi
# gives you the interacting regions, as they are referred to as "anchor" regions
anchors(hic.gi)

# The set of common regions to which those indices point can be obtained with 
# the regions method:
regions(hic.gi)

#hic.cm <- inflate(hic.gi, rows = unique(anchors(hic.gi)$first), columns = unique(anchors(hic.gi)$second), fill = hic.gi$norm.freq)
hic.cm <- inflate(hic.gi, rows = unique(anchors(hic.gi)$first), columns = unique(anchors(hic.gi)$second), fill = hic.gi$norm.freq)
hic.cm

hic.cm.mat <- as.matrix(hic.cm)
hic.cm.mat[2,]
# Modification of the common regions through annotation of the regions
# classifying whether they are promoters or enahncers
library(annotatr)
annots = c('hg19_genes_promoters')
annots_gr = build_annotations(genome = 'hg19', annotations = annots)

# What might be more productive than this would be to include a genome track
# in the TAD boundary figure, and then also label the CERES dataset with how often
# that element interacts with other elements

