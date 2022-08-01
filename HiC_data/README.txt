These are instructions for the HiC TAD analysis pipeline using HiCExplorer.

Before you run any of these steps, assure you have set up an appropriate conda environment where HiCExplorer is installed. If you need more clarification,
you can find documentation of the original pipeline here: https://hicexplorer.readthedocs.io/en/latest/content/example_usage.html

1. Find the appropriate reference fasta, and run BWA.hg38index.sh. This will use BWA to index the reference genome.
2. Using your .fastq files, run reads_mapping.sh. This will use your reference file to create aligned .bam files from the .fastq files.
3. Run hicFindRestSite.sh using the same .fastq files. This identifies the restriction enzyme sites in your .fastq files in order to generate the
  correct HiC contact matrix. The HiC experiment here used restriction enzymes that binds to the sequence GATC, but make sure you input your own. 
  This will output .bed files with the locations of those sites.
4. Using the aligned .bam and .bed files, run hicBuildMatrix.sh. This will output a .h5 matrix that needs to be corrected
5. It is necessary to correct the bin size of the matrix "to remove GC, open chromatin biases and, most importantly, to normalize the number of 
  restriction sites per bin". You can do this by first printing the diagnostic plot, then running the HiCexplorer correction pipeline, both of
  which can be done by running hicCorrectMatrix.sh
6. With the HiC matrix corrected, you can print it with hicPlotMatrix.sh
7. hicTADs.sh will identify and display the TADs in the HiC_matrix_corrected.h5 file(s)
