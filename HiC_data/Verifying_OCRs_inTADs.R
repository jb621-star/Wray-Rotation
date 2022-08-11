library(tidyverse)
library(dplyr)
library(ggplot2)

#Reading in the original dataset and the coordinates of the OCRs 
# that are present within the TADs 
OCRs_TADdomains_int <- read_delim("/Users/jamesonblount/Downloads/OCRs_TADdomains_int.bed", col_names = FALSE)
x_0011_df_phyloP_all <- read_csv("/Users/jamesonblount/Documents/Wray_Rotation/Carl/X_0012/data/x_0011_df_phyloP.csv")
x_0011_df_phyloP_all$chromHMM_cat_longest <- as.factor(x_0011_df_phyloP_all$chromHMM_cat_longest)

levels(x_0011_df_phyloP_all$chromHMM_cat_longest)
colnames(OCRs_TADdomains_int) <- c("seqnames", "start", "end", 
                                   "TAD_chr", "TAD_start", "TAD_end", "TAD_ID")

# Merging the two by the OCRs coordinates
OCRs_TADdomains_merged <- merge(x_0011_df_phyloP_all, OCRs_TADdomains_int, 
                                    by = c("seqnames", "start", "end"))

#Need to verify that open core promoters and enhancers are within the same TAD,
 # filter the dataset by these chromHMM categories
OCRs_TADdomains_prom.enhance <- OCRs_TADdomains_merged %>% 
  filter(chromHMM_cat_longest == "Active Promoter" | chromHMM_cat_longest == "Candidate Strong Enhancer")

OCRs_TADdomains_prom.enhance$TAD_ID <- as.factor(OCRs_TADdomains_prom.enhance$TAD_ID)

OCRs_TADdomains_summary <- OCRs_TADdomains_prom.enhance %>% 
    dplyr::group_by(TAD_ID) %>% 
    dplyr::summarise(Promoters = sum(chromHMM_cat_longest == "Active Promoter"),
            Enhancers = sum(chromHMM_cat_longest == "Candidate Strong Enhancer"))

head(OCRs_TADdomains_summary)
targetTADs <- OCRs_TADdomains_summary %>% 
  filter(Promoters > 0 & Enhancers > 0)

n_occur <- data.table(table(targetTADs$TAD_ID))

targetTAD_IDs <- n_occur$V1[n_occur$N > 0]

OCRs_TADdomains_merged_targeted <- subset(OCRs_TADdomains_merged, TAD_ID %in% targetTAD_IDs)

write_csv(OCRs_TADdomains_merged_targeted, "/Users/jamesonblount/Documents/Wray_Rotation/Carl/X_0012/data/OCRs_inTADs.csv")
