This is a short description of the Homer motif analysis pipeline
Before beginning this analysis, make sure you have created a conda environment with Homer installed.
Additionally, have in mind what kind of cells/sequences you would like to use as background, as this is a very important part of detecting enriched motifs
 in the desired target sequences. The full documentation for Homer's motif-finding function can be seen here: http://homer.ucsd.edu/homer/motif/fasta.html

1. Download an appropriate reference .fa file, here that would be hg19.fa
2. Use the OCRsbed.R file to generate a fasta file that contains all the DHS sequences you are interested in.
3. Use the same R file to read in and generate a similar fasta file for your background seuqences. Here I used the DHSs of the Cerebellum, 
  extracted from the UCSC database.
4. Run HOMER.findMotifs.sh. This will output many files containing some motifs of interest, but it is easiest to visualize them using the html files 
  that were also outputted. 
