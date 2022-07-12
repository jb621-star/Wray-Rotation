#!/bin/bash

cd /hpc/group/wraylab/carl/x_0012/scripts/


sbatch -p common --mem=50G --time=04:00:00 --wrap="module load R/4.0.3-rhel8 && Rscript --verbose --vanilla x_0012_rf1.R"
sbatch -p common --mem=50G --time=04:00:00 --wrap="module load R/4.0.3-rhel8 && Rscript --verbose --vanilla x_0012_rf2.R"
sbatch -p common --mem=50G --time=04:00:00 --wrap="module load R/4.0.3-rhel8 && Rscript --verbose --vanilla x_0012_rf3.R"
sbatch -p common --mem=50G --time=04:00:00 --wrap="module load R/4.0.3-rhel8 && Rscript --verbose --vanilla x_0012_rf4.R"
sbatch -p common --mem=50G --time=04:00:00 --wrap="module load R/4.0.3-rhel8 && Rscript --verbose --vanilla x_0012_rf5.R"
sbatch -p common --mem=50G --time=04:00:00 --wrap="module load R/4.0.3-rhel8 && Rscript --verbose --vanilla x_0012_rf6.R"
sbatch -p common --mem=50G --time=04:00:00 --wrap="module load R/4.0.3-rhel8 && Rscript --verbose --vanilla x_0012_rf7.R"
sbatch -p common --mem=50G --time=04:00:00 --wrap="module load R/4.0.3-rhel8 && Rscript --verbose --vanilla x_0012_rf8.R"


