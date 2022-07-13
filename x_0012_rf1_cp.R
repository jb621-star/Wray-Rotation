#setwd
setwd("/Users/jamesonblount/Documents/Wray_Rotation/Carl/X_0012")

#source
source("/Users/jamesonblount/Documents/Wray_Rotation/Carl/X_0012/scripts/x_0011_lib-data.R")
source("/Users/jamesonblount/Documents/Wray_Rotation/Carl/X_0012/scripts/x_0011_fxns.R")
source("/Users/jamesonblount/Documents/Wray_Rotation/Carl/X_0012/scripts/x_0011_forest_io.RR")

#rf call #1

tic()
CERES_Forest <- randomForest(x = ForestInput, y = ForestOutput_CERES,  ntree = 500)
toc() #expect ~3 hours

print(CERES_Forest)
save(CERES_Forest, file = "/Users/jamesonblount/Documents/Wray_Rotation/Code/results/CERES_Forest.Rda")

# Plotting MSE, RSQ
# Output is ForestData$wgCERES_score_nosig
#CERES_Forest_tested

plot(CERES_Forest_tested$mse)

plot(CERES_Forest_tested$rsq)

plot(CERES_Forest_tested$importance)

# %IncMSE is the most robust and informative measure. It is the increase in mse 
# of predictions(estimated with out-of-bag-CV) as a result of variable j being 
# permuted(values randomly shuffled).

# IncNodePurity is the total decrease in node impurities, measured by the Gini 
# Index from splitting on the variable, averaged over all trees

### Visualize variable importance ----------------------------------------------

#CERES
# Get variable importance from the model fit
CERESImpData <- as.data.frame(importance(CERES_Forest))
CERESImpData$Var.Names <- row.names(CERESImpData)

ggplot(CERESImpData, aes(x=Var.Names, y=`%IncMSE`)) +
  geom_segment( aes(x=Var.Names, xend=Var.Names, y=0, yend=`%IncMSE`), color="skyblue") +
  geom_point(aes(size = IncNodePurity), color="blue", alpha=0.6) +
  theme_light() +
  coord_flip() +
  theme(
    legend.position="bottom",
    panel.grid.major.y = element_blank(),
    panel.border = element_blank(),
    axis.ticks.y = element_blank()
  )

#how does my forest look?
randomForest::varImpPlot(x = CERES_Forest, sort = TRUE, n.var = 12)

# CERES tested
# Get variable importance from the model fit
CERESImpData.tested <- as.data.frame(importance(CERES_Forest_tested))
CERESImpData.tested$Var.Names <- row.names(CERESImpData.tested)

ggplot(CERESImpData.tested, aes(x=Var.Names, y=`%IncMSE`)) +
  geom_segment( aes(x=Var.Names, xend=Var.Names, y=0, yend=`%IncMSE`), color="skyblue") +
  geom_point(aes(size = IncNodePurity), color="blue", alpha=0.6) +
  theme_light() +
  coord_flip() +
  theme(
    legend.position="bottom",
    panel.grid.major.y = element_blank(),
    panel.border = element_blank(),
    axis.ticks.y = element_blank()
  )

#how does my forest look?
randomForest::varImpPlot(x = CERES_Forest_tested, sort = TRUE, n.var = 12)

# dhsWGsig
# Get variable importance from the model fit
dhsWGsigImpData <- as.data.frame(importance(dhsWGsig_Forest))
dhsWGsigImpData$Var.Names <- row.names(dhsWGsigImpData)

ggplot(dhsWGsigImpData, aes(x=Var.Names, y=`%IncMSE`)) +
  geom_segment( aes(x=Var.Names, xend=Var.Names, y=0, yend=`%IncMSE`), color="skyblue") +
  geom_point(aes(size = IncNodePurity), color="blue", alpha=0.6) +
  theme_light() +
  coord_flip() +
  theme(
    legend.position="bottom",
    panel.grid.major.y = element_blank(),
    panel.border = element_blank(),
    axis.ticks.y = element_blank()
  )

#how does my forest look?
randomForest::varImpPlot(x = dhsWGsig_Forest, sort = TRUE, n.var = 12)

# pVal
pValImpData <- as.data.frame(importance(pVal_Forest))
pValImpData$Var.Names <- row.names(pValImpData)

ggplot(pValImpData, aes(x=Var.Names, y=`%IncMSE`)) +
  geom_segment( aes(x=Var.Names, xend=Var.Names, y=0, yend=`%IncMSE`), color="skyblue") +
  geom_point(aes(size = IncNodePurity), color="blue", alpha=0.6) +
  theme_light() +
  coord_flip() +
  theme(
    legend.position="bottom",
    panel.grid.major.y = element_blank(),
    panel.border = element_blank(),
    axis.ticks.y = element_blank()
  )

#how does my forest look?
randomForest::varImpPlot(x = pVal_Forest, sort = TRUE, n.var = 12)

# pVal tested
pValImpData.tested <- as.data.frame(importance(pVal_Forest_tested))
pValImpData.tested$Var.Names <- row.names(pValImpData.tested)

ggplot(pValImpData.tested, aes(x=Var.Names, y=`%IncMSE`)) +
  geom_segment( aes(x=Var.Names, xend=Var.Names, y=0, yend=`%IncMSE`), color="skyblue") +
  geom_point(aes(size = IncNodePurity), color="blue", alpha=0.6) +
  theme_light() +
  coord_flip() +
  theme(
    legend.position="bottom",
    panel.grid.major.y = element_blank(),
    panel.border = element_blank(),
    axis.ticks.y = element_blank()
  )

#how does my forest look?
randomForest::varImpPlot(x = pVal_Forest_tested, sort = TRUE, n.var = 12)

# Signal tested
SignalImpData <- as.data.frame(importance(Signal_Forest))
SignalImpData$Var.Names <- row.names(SignalImpData)

ggplot(SignalImpData, aes(x=Var.Names, y=`%IncMSE`)) +
  geom_segment( aes(x=Var.Names, xend=Var.Names, y=0, yend=`%IncMSE`), color="skyblue") +
  geom_point(aes(size = IncNodePurity), color="blue", alpha=0.6) +
  theme_light() +
  coord_flip() +
  theme(
    legend.position="bottom",
    panel.grid.major.y = element_blank(),
    panel.border = element_blank(),
    axis.ticks.y = element_blank()
  )

#how does my forest look?
randomForest::varImpPlot(x = Signal_Forest, sort = TRUE, n.var = 12)



