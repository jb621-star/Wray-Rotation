#setwd
setwd("/hpc/home/jb621/WrayRot/CarlRF")

#source
source("/hpc/home/jb621/WrayRot/CarlRF/x_0011_lib-data.R")
source("/hpc/home/jb621/WrayRot/CarlRF/x_0011_fxns.R")
source("/hpc/home/jb621/WrayRot/CarlRF/x_0011_forest_io.R")

#rf call #1

tic()
CERES_Forest <- randomForest(x = ForestInput, y = ForestOutput_CERES,  ntree = 500, keep.forest = T, importance = TRUE)
toc() #expect ~3 hours

print(CERES_Forest)


#save workspace image
save.image(file = "/hpc/home/jb621/WrayRot/CarlRF/CERES_Forest.RData")
save(CERES_Forest, file = "/Users/jamesonblount/Documents/Wray_Rotation/Carl/X_0012/myresults_phyloP/CERES_Forest.Rda")
