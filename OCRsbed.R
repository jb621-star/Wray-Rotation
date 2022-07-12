# Converting OCRs within x_0011_df.csv into bed file for intersection with the 
# Cactus datasets 
library(tidyverse)
library(ggplot2)
library(ggpubr)

#This continues the experimentation that Carl worked on with Random Forests, which
# he labeled X_0012 for experiment 12
x_0011_df <- read_csv(file = "/Users/jamesonblount/Documents/Wray_Rotation/Carl/X_0012/data/x_0011_df.csv")

# Extracting the intervals in BED format
x_0011_df_OCRs <- x_0011_df %>% select(seqnames, start, end) 

x_0011_df_OCRs <- x_0011_df_OCRs %>% rename(chr = seqnames)

write.table(x_0011_df_OCRs, file = "/Users/jamesonblount/Documents/Wray_Rotation/Carl/X_0012/myresults/CERES_OCRs.bed", col.names = FALSE, row.names=FALSE,sep="\t", quote = FALSE)

# After getting the intersections with Cactus file and averaging the scores across 
# intervals using the bedtools "map" function, we have our intervals and their scores
OCRs_PhyloP <- read_delim("/Users/jamesonblount/Documents/Wray_Rotation/Carl/X_0012/data/CERES.PhyloP.inter.avg.bed", col_names = FALSE)

colnames(OCRs_PhyloP) <- c("seqnames","start","end","PhyloP_mammals_score")
OCRs_PhyloP$PhyloP_mammals_score <- as.numeric(OCRs_PhyloP$PhyloP_mammals_score)

# Performing a left join with our existing dataset will simply add the PhyloP scores
# as an additional variable to the corresponding interval
x_0011_df_phyloP <- left_join(x_0011_df, OCRs_PhyloP, by = c("seqnames","start","end"))

write_csv(x_0011_df_phyloP, "/Users/jamesonblount/Documents/Wray_Rotation/Carl/X_0012/data/x_0011_df_phyloP.csv")

# After getting the primate- and placental-specific intersections with the PhyloP 
# and averaging the scores across intervals using the same "map" function
OCRs_PhyloP_primates <- read_delim("/Users/jamesonblount/Documents/Wray_Rotation/Carl/X_0012/data/CERES.PhyloP.primates.inter.avg.bed", col_names = FALSE)

OCRs_PhyloP_placental <- read_delim("/Users/jamesonblount/Documents/Wray_Rotation/Carl/X_0012/data/CERES.PhyloP.placental.inter.avg.bed", col_names = FALSE)

colnames(OCRs_PhyloP_primates) <- c("seqnames","start","end","PhyloP_primates_score")

colnames(OCRs_PhyloP_placental) <- c("seqnames","start","end","PhyloP_placental_score")

x_0011_df_phyloP_primates <- left_join(x_0011_df_phyloP, OCRs_PhyloP_primates, by = c("seqnames","start","end"))

# Creating a master dataframe with all phyloP scores
x_0011_df_phyloP_all <- left_join(x_0011_df_phyloP_primates, OCRs_PhyloP_placental, by = c("seqnames","start","end"))

# Scatterplots to try and discover the relationship between the different phyloP scores
# 242-way mammals vs 46-way primates
x_0011_df_phyloP_all %>% 
  ggplot(aes(x=PhyloP_mammals_score,y=PhyloP_primates_score, color = chromHMM_cat_longest)) +
  geom_point(alpha=0.5) +
  labs(x= "242-way mammalian phyloP", y="46-way primates phyloP")+
  stat_cor() +
  geom_smooth()

# 242-way mammals vs 46-way placentals
x_0011_df_phyloP_all %>% 
  ggplot(aes(x=PhyloP_mammals_score,y=PhyloP_placental_score, color = chromHMM_cat_longest)) +
  geom_point(alpha=0.5) +
  labs(x= "242-way mammalian phyloP", y="46-way placental phyloP")+
  stat_cor() +
  geom_smooth()

# 46-way primates vs 46-way placentals
x_0011_df_phyloP_all %>% 
  ggplot(aes(x=PhyloP_primates_score,y=PhyloP_placental_score, color = chromHMM_cat_longest)) +
  geom_point(alpha=0.5) +
  labs(x= "46-way primates phyloP", y="46-way placental phyloP")+
  stat_cor() +
  geom_smooth()

write_csv(x_0011_df_phyloP_all, "/Users/jamesonblount/Documents/Wray_Rotation/Carl/X_0012/data/x_0011_df_phyloP.csv")

x_0011_df_phyloP_all <- read_csv("/Users/jamesonblount/Documents/Wray_Rotation/Carl/X_0012/data/x_0011_df_phyloP.csv")

# Convert the phyloP tracks into bedGraph files for vizualization and intersection
x_0011_df_phyloP_compare <- x_0011_df_phyloP_all %>% 
  select(seqnames, start, end, PhyloP_mammals_score, PhyloP_primates_score, PhyloP_placental_score)

x_0011_df_phyloP_242mammals <- x_0011_df_phyloP_compare %>% 
  select(seqnames, start, end, PhyloP_mammals_score)

x_0011_df_phyloP_242mammals[is.na(x_0011_df_phyloP_242mammals)] <- 0

# Need to eventually do the same filtering on all of these
x_0011_df_phyloP_46primates <- x_0011_df_phyloP_compare %>% 
  select(seqnames, start, end, PhyloP_primates_score)

x_0011_df_phyloP_46primates[is.na(x_0011_df_phyloP_46primates)] <- 0

x_0011_df_phyloP_46placental <- x_0011_df_phyloP_compare %>% 
  select(seqnames, start, end, PhyloP_placental_score)

x_0011_df_phyloP_46placental[is.na(x_0011_df_phyloP_46placental)] <- 0

# Experimenting now with plyranges
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
library(GenomicRanges)
BiocManager::install("plyranges")
library(plyranges)
library(GenomicRanges)

x_0011_df_phyloP_242mammals_grng <- x_0011_df_phyloP_242mammals %>%
  transform(seqnames = seqnames,
            strand = strand) %>%
  as_granges()
x_0011_df_phyloP_242mammals_grng
x_0011_df_phyloP_242mammals_grng_nonover <- 
  x_0011_df_phyloP_242mammals_grng[unique(findOverlaps(x_0011_df_phyloP_242mammals_grng, type = "any", select = "first"))]
x_0011_df_phyloP_242mammals_grng_nonover

library(Repitools)
x_0011_df_phyloP_242mammals_DF <- annoGR2DF(x_0011_df_phyloP_242mammals_grng_nonover)
x_0011_df_phyloP_242mammals_DF <- x_0011_df_phyloP_242mammals_DF %>% 
  select(!(width))

#Converting to bed/bedgraph/bigwig
write.table(x_0011_df_phyloP_242mammals, file="/Users/jamesonblount/Documents/Wray_Rotation/UCSC_viz/x_0011_df_phyloP_242mammals.bedGraph", quote=F, sep="\t", row.names=F, col.names=F)

#Same pipeline but with other phyloP scores

#Primates
x_0011_df_phyloP_46primates_grng <- x_0011_df_phyloP_46primates %>%
  transform(seqnames = seqnames,
            strand = strand) %>%
  as_granges()

x_0011_df_phyloP_46primates_grng_nonover <- 
  x_0011_df_phyloP_46primates_grng[unique(findOverlaps(x_0011_df_phyloP_46primates_grng, type = "any", select = "first"))]

x_0011_df_phyloP_46primates_DF <- annoGR2DF(x_0011_df_phyloP_46primates_grng_nonover)
x_0011_df_phyloP_46primates_DF <- x_0011_df_phyloP_46primates_DF %>% 
  select(!(width))

#Converting to bed/bedgraph/bigwig
write.table(x_0011_df_phyloP_46primates, file="/Users/jamesonblount/Documents/Wray_Rotation/UCSC_viz/x_0011_df_phyloP_46primates.bedGraph", quote=F, sep="\t", row.names=F, col.names=F)

#Placental
x_0011_df_phyloP_46placental_grng <- x_0011_df_phyloP_46placental %>%
  transform(seqnames = seqnames,
            strand = strand) %>%
  as_granges()

x_0011_df_phyloP_46placental_grng_nonover <- 
  x_0011_df_phyloP_46placental_grng[unique(findOverlaps(x_0011_df_phyloP_46placental_grng, type = "any", select = "first"))]

x_0011_df_phyloP_46placental_DF <- annoGR2DF(x_0011_df_phyloP_46placental_grng_nonover)
x_0011_df_phyloP_46placental_DF <- x_0011_df_phyloP_46placental_DF %>% 
  select(!(width))

#Converting to bed/bedgraph/bigwig
write.table(x_0011_df_phyloP_46placental, file="/Users/jamesonblount/Documents/Wray_Rotation/UCSC_viz/x_0011_df_phyloP_46placental.bedGraph", quote=F, sep="\t", row.names=F, col.names=F)

#Next: counting the relative number of GCs and ATs in the DHSs
# Since the RF analysis placed a lot of weight on DHS GC proportion
# Use the DHS sequence variable
x_0011_df_phyloP_all_DHS_seqs <- x_0011_df_phyloP_all %>% 
  select(seqnames, start, end, DHS_sequence, DHS_prop_GC, chromHMM_cat_longest,
         PhyloP_mammals_score, PhyloP_primates_score, PhyloP_placental_score)

#Need to make all uppercase as well
x_0011_df_phyloP_all_DHS_seqs$DHS_sequence <- toupper(x_0011_df_phyloP_all_DHS_seqs$DHS_sequence)

#Perform string counting rowwise
library(stringr)
x_0011_df_phyloP_all_DHS_seqs_AT <- x_0011_df_phyloP_all_DHS_seqs %>% 
  rowwise() %>% 
  mutate(DHS_prop_AT = sum(str_count(DHS_sequence, c("A","T")))/nchar(DHS_sequence))

# Now we want to separate the core promoters from the enhancers
x_0011_df_phyloP_all_prom.enhance <- x_0011_df_phyloP_all_DHS_seqs_AT %>% 
  filter(chromHMM_cat_longest == "Active Promoter" | 
           chromHMM_cat_longest == "Inactive Promoter" |
           chromHMM_cat_longest == "Candidate Strong Enhancer" |
           chromHMM_cat_longest == "Candidate Weak Enhancer") %>% 
  mutate(chromHMM_broad = if_else((chromHMM_cat_longest == "Active Promoter" | 
                                     chromHMM_cat_longest == "Inactive Promoter"), 
                                  "Promoter", "Enhancer"))

#Print avg GC vs AT content for these sequences
x_0011_df_phyloP_all_prom.enhance %>%
  group_by(chromHMM_broad) %>% 
  summarise(mGC = mean(DHS_prop_GC), mAT = mean(DHS_prop_AT))

# To analyze motif enrichment, need to convert the DHS sequences to one fasta file
# Requires unique ID and sequence
x_0011_df_fasta <- x_0011_df_phyloP_all %>% 
  select(name, DHS_sequence)

#Below is a simple function that takes a data.frame that has a column name and 
# seq and writes a fasta file from it
writeFasta<-function(data, filename){
  fastaLines = c()
  for (rowNum in 1:nrow(data)){
    fastaLines = c(fastaLines, as.character(paste(">", data[rowNum,"name"], sep = "")))
    fastaLines = c(fastaLines,as.character(data[rowNum,"seq"]))
  }
  fileConn<-file(filename)
  writeLines(fastaLines, fileConn)
  close(fileConn)
}

names(x_0011_df_fasta)[names(x_0011_df_fasta) == "DHS_sequence"] <- "seq"
writeFasta(x_0011_df_fasta, "/Users/jamesonblount/Documents/Wray_Rotation/Carl/X_0012/myresults/OCRs.motif.fa")

# Now we wish to examine the attributes of the top/bottom 10%/quintile of phyloP scores
# 242 mammalian
x_0011_df_phyloP_top10mammal <- subset(x_0011_df_phyloP_all, PhyloP_mammals_score > quantile(PhyloP_mammals_score, prob = 1 - 10/100, na.rm = TRUE))
prop.table(table(x_0011_df_phyloP_top10mammal$chromHMM_cat_longest))
mean(x_0011_df_phyloP_top10mammal$wgCERES_score_nosig)
mean(x_0011_df_phyloP_top10mammal$dhs_0_1_wg)
mean(x_0011_df_phyloP_top10mammal$pValue)

x_0011_df_phyloP_top25mammal <- subset(x_0011_df_phyloP_all, PhyloP_mammals_score > quantile(PhyloP_mammals_score, prob = 1 - 25/100, na.rm = TRUE))
prop.table(table(x_0011_df_phyloP_top25mammal$chromHMM_cat_longest))
mean(x_0011_df_phyloP_top25mammal$wgCERES_score_nosig)
mean(x_0011_df_phyloP_top25mammal$dhs_0_1_wg)

x_0011_df_phyloP_bottom10mammal <- subset(x_0011_df_phyloP_all, PhyloP_mammals_score < quantile(PhyloP_mammals_score, prob = 1 - 90/100, na.rm = TRUE))
prop.table(table(x_0011_df_phyloP_bottom10mammal$chromHMM_cat_longest))
mean(x_0011_df_phyloP_bottom10mammal$wgCERES_score_nosig)
mean(x_0011_df_phyloP_bottom10mammal$dhs_0_1_wg)

x_0011_df_phyloP_bottom25mammal <- subset(x_0011_df_phyloP_all, PhyloP_mammals_score < quantile(PhyloP_mammals_score, prob = 1 - 75/100, na.rm = TRUE))
prop.table(table(x_0011_df_phyloP_bottom25mammal$chromHMM_cat_longest))
mean(x_0011_df_phyloP_bottom25mammal$wgCERES_score_nosig)
mean(x_0011_df_phyloP_bottom25mammal$dhs_0_1_wg)

# 46 way primate
x_0011_df_phyloP_top10primate <- subset(x_0011_df_phyloP_all, PhyloP_primates_score > quantile(PhyloP_primates_score, prob = 1 - 10/100, na.rm = TRUE))
prop.table(table(x_0011_df_phyloP_top10primate$chromHMM_cat_longest))
mean(x_0011_df_phyloP_top10primate$wgCERES_score_nosig)
mean(x_0011_df_phyloP_top10primate$dhs_0_1_wg)
mean(x_0011_df_phyloP_top10primate$pValue)

x_0011_df_phyloP_top25primate <- subset(x_0011_df_phyloP_all, PhyloP_primates_score > quantile(PhyloP_primates_score, prob = 1 - 25/100, na.rm = TRUE))
prop.table(table(x_0011_df_phyloP_top25primate$chromHMM_cat_longest))
mean(x_0011_df_phyloP_top25primate$wgCERES_score_nosig)
mean(x_0011_df_phyloP_top25primate$dhs_0_1_wg)
mean(x_0011_df_phyloP_top25primate$pValue)

x_0011_df_phyloP_bottom10primate <- subset(x_0011_df_phyloP_all, PhyloP_primates_score < quantile(PhyloP_primates_score, prob = 1 - 90/100, na.rm = TRUE))
prop.table(table(x_0011_df_phyloP_bottom10primate$chromHMM_cat_longest))
mean(x_0011_df_phyloP_bottom10primate$wgCERES_score_nosig)
mean(x_0011_df_phyloP_bottom10primate$dhs_0_1_wg)
mean(x_0011_df_phyloP_bottom10primate$pValue)

x_0011_df_phyloP_bottom25primate <- subset(x_0011_df_phyloP_all, PhyloP_primates_score < quantile(PhyloP_primates_score, prob = 1 - 75/100, na.rm = TRUE))
prop.table(table(x_0011_df_phyloP_bottom25primate$chromHMM_cat_longest))
mean(x_0011_df_phyloP_bottom25primate$wgCERES_score_nosig)
mean(x_0011_df_phyloP_bottom25primate$dhs_0_1_wg)
mean(x_0011_df_phyloP_bottom25primate$pValue)

# 46 way placental
x_0011_df_phyloP_top10placental <- subset(x_0011_df_phyloP_all, PhyloP_placental_score > quantile(PhyloP_placental_score, prob = 1 - 10/100, na.rm = TRUE))
prop.table(table(x_0011_df_phyloP_top10placental$chromHMM_cat_longest))
mean(x_0011_df_phyloP_top10placental$wgCERES_score_nosig)
mean(x_0011_df_phyloP_top10placental$dhs_0_1_wg)
mean(x_0011_df_phyloP_top10placental$pValue)

x_0011_df_phyloP_top25placental <- subset(x_0011_df_phyloP_all, PhyloP_placental_score > quantile(PhyloP_placental_score, prob = 1 - 25/100, na.rm = TRUE))
prop.table(table(x_0011_df_phyloP_top25placental$chromHMM_cat_longest))
mean(x_0011_df_phyloP_top25placental$wgCERES_score_nosig)
mean(x_0011_df_phyloP_top25placental$dhs_0_1_wg)
mean(x_0011_df_phyloP_top25placental$pValue)

x_0011_df_phyloP_bottom10placental <- subset(x_0011_df_phyloP_all, PhyloP_placental_score < quantile(PhyloP_placental_score, prob = 1 - 90/100, na.rm = TRUE))
prop.table(table(x_0011_df_phyloP_bottom10placental$chromHMM_cat_longest))
mean(x_0011_df_phyloP_bottom10placental$wgCERES_score_nosig)
mean(x_0011_df_phyloP_bottom10placental$dhs_0_1_wg)
mean(x_0011_df_phyloP_bottom10placental$pValue)

x_0011_df_phyloP_bottom25placental <- subset(x_0011_df_phyloP_all, PhyloP_placental_score < quantile(PhyloP_placental_score, prob = 1 - 75/100, na.rm = TRUE))
prop.table(table(x_0011_df_phyloP_bottom25placental$chromHMM_cat_longest))
mean(x_0011_df_phyloP_bottom25placental$wgCERES_score_nosig)
mean(x_0011_df_phyloP_bottom25placental$dhs_0_1_wg)
mean(x_0011_df_phyloP_bottom25placental$pValue)

#Now that we have some idea of the motifs, let's search for the enriched known 
# motif that HOMER found (middle contains GCCCCCT) for K562
# using str_detect(string, GCCCCCTGGTGG)
x_0011_df_phyloP_all$DHS_sequence <- toupper(x_0011_df_phyloP_all$DHS_sequence)
x_011_df_phyloP_motif2 <- x_0011_df_phyloP_all %>% 
  filter(str_detect(DHS_sequence, 'GCCCCCTGGTGG'))
#ChromHMM attributes of these DHSs
prop.table(table(x_011_df_phyloP_motif2$chromHMM_cat_longest))
mean(x_011_df_phyloP_motif2$wgCERES_score_nosig)
mean(x_011_df_phyloP_motif2$dhs_0_1_wg)
mean(x_011_df_phyloP_motif2$pValue)

# Another known motif is TGACTCAGCA
x_011_df_phyloP_motif6 <- x_0011_df_phyloP_all %>% 
  filter(str_detect(DHS_sequence, 'TGACTCAGCA'))
prop.table(table(x_011_df_phyloP_motif6$chromHMM_cat_longest))
mean(x_011_df_phyloP_motif6$wgCERES_score_nosig)
mean(x_011_df_phyloP_motif6$dhs_0_1_wg)
mean(x_011_df_phyloP_motif6$pValue)

# Another is AGATAAG
x_011_df_phyloP_motif8 <- x_0011_df_phyloP_all %>% 
  filter(str_detect(DHS_sequence, 'AGATAAG'))
prop.table(table(x_011_df_phyloP_motif8$chromHMM_cat_longest))
mean(x_011_df_phyloP_motif8$wgCERES_score_nosig)
mean(x_011_df_phyloP_motif8$dhs_0_1_wg)
mean(x_011_df_phyloP_motif8$pValue)

# Reading in the file from another cell line, converting to bed format, outputting
# to extract the FASTA sequences
Cerbllm_OCRs <- read_delim("/Users/jamesonblount/Documents/Wray_Rotation/Carl/X_0012/myresults/Cerbllm_OCRs", delim = "\t", col_names = TRUE)
Cerbllm_OCRs_bed <- Cerbllm_OCRs %>% 
  select(chrom, chromStart, chromEnd, name)
write.table(Cerbllm_OCRs_bed, file="/Users/jamesonblount/Documents/Wray_Rotation/Carl/X_0012/myresults/Cerbllm_OCRs.bed", quote=F, sep="\t", row.names=F, col.names=F)

# Another important question is what are the chromHMM categories of the DHSs in top/bottom 
# percentiles of CERES scores (wgCERES_score_nosig)
x_0011_df_phyloP_top10CERES <- subset(x_0011_df_phyloP_all, wgCERES_score_nosig > quantile(wgCERES_score_nosig, prob = 1 - 10/100, na.rm = TRUE))
prop.table(table(x_0011_df_phyloP_top10CERES$chromHMM_cat_longest))

x_0011_df_phyloP_top25CERES <- subset(x_0011_df_phyloP_all, wgCERES_score_nosig > quantile(wgCERES_score_nosig, prob = 1 - 25/100, na.rm = TRUE))
prop.table(table(x_0011_df_phyloP_top25CERES$chromHMM_cat_longest))

x_0011_df_phyloP_bottom10CERES <- subset(x_0011_df_phyloP_all, wgCERES_score_nosig < quantile(wgCERES_score_nosig, prob = 1 - 90/100, na.rm = TRUE))
prop.table(table(x_0011_df_phyloP_bottom10CERES$chromHMM_cat_longest))

x_0011_df_phyloP_bottom25CERES <- subset(x_0011_df_phyloP_all, wgCERES_score_nosig < quantile(wgCERES_score_nosig, prob = 1 - 75/100, na.rm = TRUE))
prop.table(table(x_0011_df_phyloP_bottom25CERES$chromHMM_cat_longest))

# Getting the attributes of DHSs where probIntolerantLoF_gt_0.9 is TRUE
x_0011_df_phyloP_LoF <- x_0011_df_phyloP_all %>% 
  filter(probIntolerantLoF_gt_0.9 == TRUE)
# a quick table of the expression of the DHS (medianRNAseqTPM)
x_0011_df_phyloP_LoF %>% group_by(chromHMM_cat_longest) %>% 
  summarise(meanMedianRNAseqTPM = mean(medianRNAseqTPM, na.rm = TRUE))

prop.table(table(x_0011_df_phyloP_LoF$chromHMM_cat_longest))

# comparing CERES score between GC-rich motifs specific to TFs and random GC-rich
# sequence
GCs <- c("G","C")
random12mer <- sample(GCs, 12, replace = T)
random12merStr <- toString(random12mer)
random12merStr <- str_remove_all(random12merStr, ", ")

x_011_df_phyloP_randGC <- x_0011_df_phyloP_all %>% 
  filter(str_detect(DHS_sequence, random12merStr))
x_011_df_phyloP_randGC %>% summarise(meanCERES = mean(wgCERES_score_nosig, na.rm = TRUE))

Sp1 <- c("GGCCCCGCCCCC")

x_011_df_phyloP_Sp1 <- x_0011_df_phyloP_all %>% 
  filter(str_detect(DHS_sequence, Sp1))
x_011_df_phyloP_Sp1 %>% summarise(meanCERES = mean(wgCERES_score_nosig, na.rm = TRUE))

x_0011_df_phyloP_GCrich <- x_0011_df_phyloP_all %>% 
  rowwise() %>% 
  mutate(GCperc = sum(str_count(DHS_sequence, c("G","C")))/str_length(DHS_sequence)) %>% 
  filter(GCperc >= 0.70)
mean(x_0011_df_phyloP_GCrich$wgCERES_score_nosig)

x_0011_df_phyloP_nonGCrich <- x_0011_df_phyloP_all %>% 
  rowwise() %>% 
  mutate(GCperc = sum(str_count(DHS_sequence, c("G","C")))/str_length(DHS_sequence)) %>% 
  filter(GCperc <= 0.50)
mean(x_0011_df_phyloP_nonGCrich$wgCERES_score_nosig)

# Trying to identify the attributes of DHS containing Jun-AP1 and Fos2
library(stringdist)
Jun <-  "TGACTCAT"
Fos2 <- "GATGACTCA"

x_0011_df_phyloP_Jun <- x_0011_df_phyloP_all %>% 
  filter(str_detect(DHS_sequence, Jun))
table(x_0011_df_phyloP_Jun$chromHMM_cat_longest)
mean(x_0011_df_phyloP_Jun$wgCERES_score_nosig)
mean(x_0011_df_phyloP_Jun$PhyloP_primates_score)

x_0011_df_phyloP_Fos2 <- x_0011_df_phyloP_all %>% 
  filter(str_detect(DHS_sequence, Fos2))
table(x_0011_df_phyloP_Fos2$chromHMM_cat_longest)
mean(x_0011_df_phyloP_Fos2$wgCERES_score_nosig)
mean(x_0011_df_phyloP_Fos2$PhyloP_primates_score)

# Breaking down chromHMM based on conserved phyloP scores
summary(x_0011_df_phyloP_all$PhyloP_primates_score)
x_0011_df_phyloP_HiP <- x_0011_df_phyloP_all %>% 
  filter(PhyloP_primates_score >= 0)
prop.table(table(x_0011_df_phyloP_HiP$chromHMM_cat_longest))
mean(x_0011_df_phyloP_HiP$wgCERES_score_nosig)

x_0011_df_phyloP_LoP <- x_0011_df_phyloP_all %>% 
  filter(PhyloP_primates_score < 0)
prop.table(table(x_0011_df_phyloP_LoP$chromHMM_cat_longest))
mean(x_0011_df_phyloP_LoP$wgCERES_score_nosig)

