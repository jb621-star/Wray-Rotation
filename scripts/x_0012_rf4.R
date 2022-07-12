#setwd
setwd("/hpc/home/jb621/WrayRot/CarlRF")

#source
source("/hpc/home/jb621/WrayRot/CarlRF/x_0011_lib-data.R")
source("/hpc/home/jb621/WrayRot/CarlRF/x_0011_fxns.R")
source("/hpc/home/jb621/WrayRot/CarlRF/x_0011_forest_io.R")

#rf call #1

tic()
dhsWGsig_Forest_tested <- randomForest(x = ForestInput, y = ForestOutput_dhs_wg_sig, ntree = 500, xtest = FuInput, ytest = FuOutput_dhs_wg_sig, keep.forest = T, importance = TRUE)
toc() #expect ~3 hours

print(dhsWGsig_Forest_tested)
#saveRDS(CERES_Forest_tested, file = here::here("results", "CERES_Forest_tested.Rds))


#save workspace image
save.image(file = "/hpc/home/jb621/WrayRot/CarlRF/dhsWGsig_Forest_tested.RData")
save(dhsWGsig_Forest_tested, file = "/Users/jamesonblount/Documents/Wray_Rotation/Carl/X_0012/myresults_phyloP/dhsWGsig_Forest_tested.Rda")
