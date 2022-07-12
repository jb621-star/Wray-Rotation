#setwd
setwd("/hpc/home/jb621/WrayRot/CarlRF")

#source
source("/hpc/home/jb621/WrayRot/CarlRF/x_0011_lib-data.R")
source("/hpc/home/jb621/WrayRot/CarlRF/x_0011_fxns.R")
source("/hpc/home/jb621/WrayRot/CarlRF/x_0011_forest_io.R")

#rf call #1

tic()
Signal_Forest_tested <- randomForest(x = ForestInput, y = ForestOutput_Signal, ntree = 500, xtest = FuInput, ytest = FuOutput_Signal, keep.forest = TRUE, importance = TRUE)
toc() #expect ~3 hours

print(Signal_Forest_tested)
#saveRDS(Signal_Forest_tested, file = here::here("results", "Signal_Forest_tested.Rds))


#save workspace image
save.image(file = "/hpc/home/jb621/WrayRot/CarlRF/Signal_Forest_tested.RData")
save(Signal_Forest_tested, file = "/Users/jamesonblount/Documents/Wray_Rotation/Carl/X_0012/myresults_phyloP/Signal_Forest_tested.Rda")
