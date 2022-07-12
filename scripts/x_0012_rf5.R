#setwd
setwd("/hpc/home/jb621/WrayRot/CarlRF")

#source
source("/hpc/home/jb621/WrayRot/CarlRF/x_0011_lib-data.R")
source("/hpc/home/jb621/WrayRot/CarlRF/x_0011_fxns.R")
source("/hpc/home/jb621/WrayRot/CarlRF/x_0011_forest_io.R")

#rf call #1

tic()
pVal_Forest <- randomForest(x = ForestInput,  y = ForestOutput_pVal, ntree = 500, keep.forest = T, importance = TRUE)
toc() #expect ~3 hours

print(pVal_Forest)
print(CERES_Forest)

#save workspace image
save.image(file = "/Users/jamesonblount/Documents/Wray_Rotation/Carl/X_0012/myresults_phyloP/pVal_Forest.RData")
save(pVal_Forest, file = "/Users/jamesonblount/Documents/Wray_Rotation/Carl/X_0012/myresults_phyloP/pVal_Forest.Rda")
