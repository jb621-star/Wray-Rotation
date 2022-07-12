#setwd
setwd("/hpc/home/jb621/WrayRot/CarlRF")

#source
source("/hpc/home/jb621/WrayRot/CarlRF/x_0011_lib-data.R")
source("/hpc/home/jb621/WrayRot/CarlRF/x_0011_fxns.R")
source("/hpc/home/jb621/WrayRot/CarlRF/x_0011_forest_io.R")

#rf call #1

tic()
Signal_Forest <- randomForest(x = ForestInput, y = ForestOutput_Signal, ntree = 500, keep.forest = TRUE, importance = TRUE)
toc() #expect ~3 hours

print(Signal_Forest)


#save workspace image
save.image(file = "/Users/jamesonblount/Documents/Wray_Rotation/Carl/X_0012/myresults_phyloP/Signal_Forest.RData")
save(Signal_Forest, file = "/Users/jamesonblount/Documents/Wray_Rotation/Carl/X_0012/myresults_phyloP/Signal_Forest.Rda")
