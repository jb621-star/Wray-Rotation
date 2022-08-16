#!/bin/bash

sbatch -p common --mem=300G --wrap="module unload R && module load R/4.1.1-rhel8 && Rscript --verbose --vanilla K562_ContactMat.R"

