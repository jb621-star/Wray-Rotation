Column	Description
chrom	chromosome number for DHS
chromStart	chromosome start position for DHS
chromEnd	chromosome end position for DHS
name	DHS name
score	" Indicates how dark the peak will be displayed in the browser (0-1000). If all scores were ""'0""' when the data were submitted to the DCC, the DCC assigned scores 1-1000 based on signal value. Ideally the average signalValue per base spread is between 100-1000."
strand	"+/- to denote strand or orientation (whenever applicable). Use ""."" if no orientation is assigned."
signalValue	"Measurement of overall (usually, average) enrichment for the region."
pValue	Measurement of statistical significance (-log10). Use -1 if no pValue is assigned.
qValue	Measurement of statistical significance using false discovery rate (-log10). Use -1 if no qValue is assigned.
peak	Point-source called for this peak; 0-based offset from chromStart. Use -1 if no point-source called.
gRNA_0_1_wg	Number of significant gRNAs in the DHS (FDR < 0.1)
gRNA_0_05_wg	"Number of significant gRNAs in the DHS (FDR < 0.05) All DHSs, whole-genome screen"
gRNA_0_01_wg	"Number of significant gRNAs in the DHS (FDR < 0.01) All DHSs, whole-genome screen"
bin2_0_1_wg	"Number of significant bins (2 gRNAs per bin) in the DHS (FDR < 0.1) All DHSs, whole-genome screen"
bin2_0_05_wg	"Number of significant bins (2 gRNAs per bin) in the DHS (FDR < 0.05) All DHSs, whole-genome screen"
bin2_0_01_wg	"Number of significant bins (2 gRNAs per bin) in the DHS (FDR < 0.01) All DHSs, whole-genome screen"
bin3_0_1_wg	"Number of significant bins (3 gRNAs per bin) in the DHS (FDR < 0.1) All DHSs, whole-genome screen"
bin3_0_05_wg	"Number of significant bins (3 gRNAs per bin) in the DHS (FDR < 0.05) All DHSs, whole-genome screen"
bin3_0_01_wg	"Number of significant bins (3 gRNAs per bin) in the DHS (FDR < 0.01) All DHSs, whole-genome screen"
dhs_0_1_wg	"Was DHS (all gRNAs grouped) significant? (1 yes, 0 no) (FDR < 0.1) All DHSs, whole-genome screen"
dhs_0_05_wg	"Was DHS (all gRNAs grouped) significant? (1 yes, 0 no) (FDR < 0.05) All DHSs, whole-genome screen"
dhs_0_01_wg	"Was DHS (all gRNAs grouped) significant? (1 yes, 0 no) (FDR < 0.01) All DHSs, whole-genome screen"
gRNA_dir_wg	"Direction of fold change between control (no dCas9-KRAB) and treated (dCas9-KRAB) for gRNA analysis. 0 = no change, 1 = negative change (depletion), 2 = positive change (enrichment), 3 = mixed (significant gRNAs or bins that changed in both directions). FDR < 0.1 All DHSs, whole-genome screen"
bin2_dir_wg	"Direction of fold change between control (no dCas9-KRAB) and treated (dCas9-KRAB) for bin2 analysis. 0 = no change, 1 = negative change (depletion), 2 = positive change (enrichment), 3 = mixed (significant gRNAs or bins that changed in both directions). FDR < 0.1 All DHSs, whole-genome screen"
bin3_dir_wg	"Direction of fold change between control (no dCas9-KRAB) and treated (dCas9-KRAB) for bin3 analysis. 0 = no change, 1 = negative change (depletion), 2 = positive change (enrichment), 3 = mixed (significant gRNAs or bins that changed in both directions). FDR < 0.1 All DHSs, whole-genome screen"
dhs_dir_wg	"Direction of fold change between control (no dCas9-KRAB) and treated (dCas9-KRAB) for DHS analysis. 0 = no change, 1 = negative change (depletion), 2 = positive change (enrichment), 3 = mixed (significant gRNAs or bins that changed in both directions). FDR < 0.1 All DHSs, whole-genome screen"
annotation	genomic location of DHS
gRNA_score	"sum of log2 fold changes for significantly changed gRNAs (FDR < 0.1) All DHSs, whole-genome screen"
bin2_score	"sum of log2 fold changes for significantly changed bin2s (FDR < 0.1) All DHSs, whole-genome screen"
bin3_score	"sum of log2 fold changes for significantly changed bin3s (FDR < 0.1) All DHSs, whole-genome screen"
dhs_score	"log2 fold change of significantly changed DHS (FDR < 0.1) All DHSs, whole-genome screen"
wgCERES_score	"sum of each analysis significant score (gRNA_score + bin2_score + bin3_score + dhs_score) All DHSs, whole-genome screen"
gRNA_score_nosig	"sum of log2 fold changes for all gRNAs in DHS (both significant (FDR < 0.1) and non-significant) All DHSs, whole-genome screen"
bin2_score_nosig	"sum of log2 fold changes for all bin2s in DHS (both significant (FDR < 0.1) and non-significant) All DHSs, whole-genome screen"
bin3_score_nosig	"sum of log2 fold changes for all bin3s in DHS (both significant (FDR < 0.1) and non-significant) All DHSs, whole-genome screen"
dhs_score_nosig	"log2 fold change of DHS (weither significant or not) All DHSs, whole-genome screen"
wgCERES_score_nosig	"sum of each analysis nosig score (gRNA_score_nosig + bin2_score_nosig + bin3_score_nosig + dhs_score_nosig) All DHSs, whole-genome screen"
gRNA_score_top3	"mean of log2 fold changes for the ""top"" 3 gRNAs in DHS (ranked by adjusted p-value) All DHSs, whole-genome screen"
bin2_score_top3	"mean of log2 fold changes for the ""top"" 3 bin2s in DHS (ranked by adjusted p-value) All DHSs, whole-genome screen"
bin3_score_top3	"mean of log2 fold changes for the ""top"" 3 bin3s in DHS (ranked by adjusted p-value) All DHSs, whole-genome screen"
dhs_score_top3	"log2 fold change of DHS (weither significant or not) All DHSs, whole-genome screen"
wgCERES_score_top3	"sum of each analysis top3 score (gRNA_score_top3 + bin2_score_top3 + bin3_score_top3 + dhs_score_top3) All DHSs, whole-genome screen"
geneChr	chromosome of nearest gene
geneStart	start coordinate of nearest gene
geneEnd	end coordinate of nearest gene
geneLength	length of nearest gene
geneStrand	strand of nearest gene
geneId	UCSC id of nearest gene
transcriptId	Entrez GeneID of nearest gene
distanceToTSS	distance to nearest gene TSS
geneSymbol	nearest gene symbol
DHS_length	Length of DHS
DHS_sequence	Sequence of DHS (hg19)
DHS_prop_repeat	Proportion of repetitive sequence in DHS (lower case DNA sequence)
DHS_prop_GC	Proportion of GCs in the DHS
ploidyZhou	Large scale ploidy of the region according to Zhou et al. 2019 (NA value if ploidy of the region was not reported or if gRNA overlap two regions with different ploidy)
LossHetZhou	"True if region lost heterozygocity according to Zhou et al. 2019, False otherwise"
SV_Zhou	"True if structural variant overlap DHS according to Zhou et al. 2019, False otherwise"
n_SNV_Zhou	Number of single nucleotide variants that overlap the DHS according to Zhou et al. 2019
SNV_Zhou	"True if single nucleotide variant overlap DHS according to Zhou et al. 2019, False otherwise"
n_SNV_Zhou_per_bp	Number of single nucleotide variants that overlap the DHS according to Zhou et al. 2019 (normalized for size of DHS)
probIntolerantLoF	"Probability that the closest gene is intolerant to loss of function (from Exac, Lek et al. Nature 2016)"
probIntolerantLoF_gt_0.9	True if probability that the closest gene is intolerant to loss of function is higher than 0.9
numTKOHits_Hart	"number of cell lines in which the gene is essential (from Hart et al., Cell 2018)"
anyTKOHits_Hart	"True if number of cell lines in which the gene is essential (from Hart et al., Cell 2018) is greater than 0"
HartEssential	"True if genes is essential in more than 2 of the Hart et al. cell lines (their definition of essential genes, genes with 1 or 2 could be defined as conditionally essential)"
OGEE_n_Essential	number of cell lines in which the gene is essential according to the OGEE database (http://ogee.medgenius.info)
OGEE_n_NonEssential	number of cell lines in which the gene is non-essential according to the OGEE database (http://ogee.medgenius.info)
OGEE_n	number of cell lines in which the gene was tested for essentiality according to the OGEE database (http://ogee.medgenius.info)
OGEE_prop_Essential	proportion of cell lines in which the gene is essential according to the OGEE database (http://ogee.medgenius.info)
OGEE_prop_NonEssential	proportion of cell lines in which the gene is non-essential according to the OGEE database (http://ogee.medgenius.info)
gene_id	Ensembl gene id
medianRNAseqTPM	"Median TPM of the mean TPM of 4 ENCODE K562 RNA-seq experiments (i.e. 4 experiments (""ENCSR000AEM"",""ENCSR000AEO"",""ENCSR000CPH"",""ENCSR545DKY"") were done in technical replicates, I took the mean TPM across replicates for each experiment,then took the median of the 4 experiments for genes measured in all four experiments)"
cancer_census_tier	"cancer tier (https://cancer.sanger.ac.uk/). Tier1: To be classified into Tier 1, a gene must possess a documented activity relevant to cancer, Tier2: genes with strong indications of a role in cancer but with less extensive available evidence. Value set to 0 for non-cancer genes."
cancer_census_tissue_type	"L -> leukaemia/lymphoma, E -> epithelial, M -> mesenchymal, O -> other, etc.."
cancer_census_role	function of gene in cancer (TSG:tumor supressor gene)
vc_sqrt_sum	"sum of vc_sqrt (normalised Hi-C) for each extend DHS (from ABC file). Values are only shown for gRNA entirely within the extend DHS. If a gRNA entirely overlaps two extended DHS, the mean is shown."
DNase_CPM_per_1kbp	"DNAse CPM per 1kbp for each extend DHS (from ABC file). Values are only shown for gRNA entirely within the extend DHS. If a gRNA entirely overlaps two (or more) extended DHS, the mean is shown."
H3K27ac_CPM_per_1kbp	"H3K27ac CPM per 1kbp for each extend DHS (from ABC file). Values are only shown for gRNA entirely within the extend DHS. If a gRNA entirely overlaps two (or more) extended DHS, the mean is shown."
n_conserved_LindbladToh	"Number of base pairs in the DHS that are highly conserved accross mammals (Lindblad-Toh et al., Nature 2011)"
n_conserved_LindbladToh_per_bp	"Number of base pairs in the DHS that are highly conserved accross mammals (Lindblad-Toh et al., Nature 2011) (normalized for size of DHS)"
bin2_score_sigTop3	"mean of log2 fold changes for the ""top"" 3 bin2s in DHS (FDR < 0.1, ranked by adjusted p-value) All DHSs, whole-genome screen"
bin3_score_sigTop3	"mean of log2 fold changes for the ""top"" 3 bin3s in DHS (FDR < 0.1, ranked by adjusted p-value) All DHSs, whole-genome screen"
dhs_score_sigTop3	"log2 fold change of DHS (FDR < 0.1) All DHSs, whole-genome screen"
direction_wg	"direction of effect for DHSs containing significant gRNAs or bins. (enriched, depleted, both, non-sig) All DHSs, whole-genome screen"
gRNA_score_sigTop3	"mean of log2 fold changes for the ""top"" 3 gRNAs in DHS (FDR < 0.1, ranked by adjusted p-value) All DHSs, whole-genome screen"
wgCERES_score_sigTop3	"sum of each analysis top3 score (gRNA_score_sigTop3 + bin2_score_sigTop3 + bin3_score_sigTop3 + dhs_score_sigTop3) All DHSs, whole-genome screen"
gRNA_0_1_distal	Number of significant gRNAs in the DHS (FDR < 0.1) sublibrary followup screen in K562s
gRNA_0_05_distal	Number of significant gRNAs in the DHS (FDR < 0.05) sublibrary followup screen in K562s
gRNA_0_01_distal	Number of significant gRNAs in the DHS (FDR < 0.01) sublibrary followup screen in K562s
bin2_0_1_distal	Number of significant bins (2 gRNAs per bin) in the DHS (FDR < 0.1) sublibrary followup screen in K562s
bin2_0_05_distal	Number of significant bins (2 gRNAs per bin) in the DHS (FDR < 0.05) sublibrary followup screen in K562s
bin2_0_01_distal	Number of significant bins (2 gRNAs per bin) in the DHS (FDR < 0.01) sublibrary followup screen in K562s
bin3_0_1_distal	Number of significant bins (3 gRNAs per bin) in the DHS (FDR < 0.1) sublibrary followup screen in K562s
bin3_0_05_distal	Number of significant bins (3 gRNAs per bin) in the DHS (FDR < 0.05) sublibrary followup screen in K562s
bin3_0_01_distal	Number of significant bins (3 gRNAs per bin) in the DHS (FDR < 0.01) sublibrary followup screen in K562s
dhs_0_1_distal	"Was DHS (all gRNAs grouped) significant? (1 yes, 0 no) (FDR < 0.1) sublibrary followup screen in K562s"
dhs_0_05_distal	"Was DHS (all gRNAs grouped) significant? (1 yes, 0 no) (FDR < 0.05) sublibrary followup screen in K562s"
dhs_0_01_distal	"Was DHS (all gRNAs grouped) significant? (1 yes, 0 no) (FDR < 0.01) sublibrary followup screen in K562s"
gRNA_dir_distal	"Direction of fold change between control (no dCas9-KRAB) and treated (dCas9-KRAB) for gRNA analysis. 0 = no change, 1 = negative change (depletion), 2 = positive change (enrichment), 3 = mixed (significant gRNAs or bins that changed in both directions). FDR < 0.05 All DHSs, whole-genome screen"
bin2_dir_distal	"Direction of fold change between control (no dCas9-KRAB) and treated (dCas9-KRAB) for bin2 analysis. 0 = no change, 1 = negative change (depletion), 2 = positive change (enrichment), 3 = mixed (significant gRNAs or bins that changed in both directions). FDR < 0.05 All DHSs, whole-genome screen"
bin3_dir_distal	"Direction of fold change between control (no dCas9-KRAB) and treated (dCas9-KRAB) for bin3 analysis. 0 = no change, 1 = negative change (depletion), 2 = positive change (enrichment), 3 = mixed (significant gRNAs or bins that changed in both directions). FDR < 0.05 All DHSs, whole-genome screen"
dhs_dir_distal	"Direction of fold change between control (no dCas9-KRAB) and treated (dCas9-KRAB) for DHS analysis. 0 = no change, 1 = negative change (depletion), 2 = positive change (enrichment), 3 = mixed (significant gRNAs or bins that changed in both directions). FDR < 0.05 All DHSs, whole-genome screen"
gRNA_score_top5	"mean of log2 fold changes for the ""top"" 5 gRNAs in DHS (ranked by adjusted p-value) sublibrary followup screen in K562s"
gRNA_score_top10	"mean of log2 fold changes for the ""top"" 10 gRNAs in DHS (ranked by adjusted p-value) sublibrary followup screen in K562s"
bin2_score_top5	"mean of log2 fold changes for the ""top"" 5 bin2s in DHS (ranked by adjusted p-value) sublibrary followup screen in K562s"
bin2_score_top10	"mean of log2 fold changes for the ""top"" 10 bin2s in DHS (ranked by adjusted p-value) sublibrary followup screen in K562s"
bin3_score_top5	"mean of log2 fold changes for the ""top"" 5 bin3s in DHS (ranked by adjusted p-value) sublibrary followup screen in K562s"
bin3_score_top10	"mean of log2 fold changes for the ""top"" 10 bin3s in DHS (ranked by adjusted p-value) sublibrary followup screen in K562s"
dhs_score_top5	log2 fold change of DHS (weither significant or not) sublibrary followup screen in K562s
dhs_score_top10	log2 fold change of DHS (weither significant or not) sublibrary followup screen in K562s
wgCERES_score_top5	sum of each analysis top5 score (gRNA_score_top5 + bin2_score_top5 + bin3_score_top5 + dhs_score_top5) sublibrary followup screen in K562s
wgCERES_score_top10	sum of each analysis top10 score (gRNA_score_top10 + bin2_score_top10 + bin3_score_top10 + dhs_score_top10) sublibrary followup screen in K562s
direction_distal	"direction of effect for DHSs containing significant gRNAs or bins. (enriched, depleted, both, non-sig) sublibrary followup screen in K562s"
chromHMM_cat_longest	chromHMM automated annotation
segway_cat_longest	segway automated annotation