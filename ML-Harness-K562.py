#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul 13 14:21:08 2022

@author: jamesonblount
"""

# In[]:
# Importing required packages
#Importing basic packages
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

#Importing sklearn modules
from sklearn.metrics import mean_squared_error,confusion_matrix, precision_score, recall_score, auc,roc_curve
from sklearn import ensemble, linear_model, neighbors, svm, tree, neural_network
from sklearn.linear_model import Ridge
from sklearn.linear_model import LinearRegression
from sklearn.preprocessing import PolynomialFeatures
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.pipeline import make_pipeline
from sklearn import svm,model_selection, tree, linear_model, neighbors, naive_bayes, ensemble, discriminant_analysis, gaussian_process
from sklearn.linear_model import LogisticRegression
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
from sklearn.neighbors import KNeighborsClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.svm import SVC
from sklearn.preprocessing import OneHotEncoder
from sklearn.compose import make_column_transformer
from sklearn.ensemble import GradientBoostingRegressor
from sklearn.metrics import mean_absolute_error


from sklearn.ensemble import RandomForestClassifier

# In[]:
#Loading the data and checking for missing values
dataset=pd.read_csv('/Users/jamesonblount/Documents/Wray_Rotation/Carl/X_0012/data/x_0011_df_phyloP.csv')
dataset.isnull().sum()

datasetv2 = dataset.dropna(axis=1)
datasetv2.isnull().sum()
# Checking the data set for any NULL values is very essential, as MLAs can not 
# handle NULL values. We have to either eliminate the records with NULL values 
# or replace them with the mean/median of the other values. we can see each of 
# the variables are printed with number of null values. This data set has no null 
# values so all are zero here.

# In[]:
    # Transforming the categorical variables into numerical
# Instantiate OneHotEncoder
ohe = OneHotEncoder(sparse = False)
ohe.fit_transform(datasetv2[["chromHMM_cat_longest"]])[:5]
datasetv2['chromHMM_cat_longest'].head()
ohe.categories_

# In[]:
# Compare performance of ML between top quartile to bottom quartile of AUC (best)/peak size
bin_labels = ['Lower', 'Midlower','Midupper', 'Upper']
lower_bin = ['Lower']
upper_bin = ['Upper']
datasetv2['score_quart'] = pd.qcut(datasetv2['score'], q = 4, labels = bin_labels)
datasetLower = datasetv2[datasetv2['score_quart'].isin(lower_bin)]
datasetUpper = datasetv2[datasetv2['score_quart'].isin(upper_bin)]

# In[]:
    # here we'll start by using wgCERES_score_nosig as the response vector,
x = datasetv2[["DHS_prop_repeat", 
                    "DHS_prop_GC", "DHS_length", "n_SNV_Zhou_per_bp", 
                    "distanceToTSS", "zeta.human", "zeta.chimp", "PP_con", "PP_acc", 
                    "PhastCons",
                    "chromHMM_cat_longest", 
                    "annotation", "PhyloP_primates_score"]]
y = datasetv2["wgCERES_score_nosig"]
# For classifier ML techniques, i.e. SVM and Random Forest
# y = datasetv2["dhs_0_1_wg"]

# In[]:
    # Make column transformer
column_transform = []
column_transform = make_column_transformer(
    (ohe, ['chromHMM_cat_longest','annotation']))

#Apply column transformer to predictor variables
column_transform.fit(x)


# In[]:
# Splitting train and split data
# The test data set size is 20% of the total records. This test data will not 
# be used in model training and work as an independent test data.
x_train, x_test, y_train, y_test=train_test_split(x,y,test_size=0.2, random_state=0)

# In[]:
# Building the rest of the pipeline
# Instantiate pipeline with linear regression
lm  = LinearRegression()
lm_pipeline = make_pipeline(column_transform, lm)

# In[]:
# Instantiate pipeline with gradient boosting
gbm = GradientBoostingRegressor()
gbm_pipeline = make_pipeline(column_transform, gbm)

# In[]:
# Instantiate pipeline with logistic regression
lr = LogisticRegression()
lr_pipeline = make_pipeline(column_transform, lr)

# In[]:
# Instantiate pipeline for SVM
sv = SVC()
sv_pipeline = make_pipeline(column_transform, sv)

# In[]:
# Fit pipeline to training set and make predictions on test set

lm_pipeline.fit(x_train, y_train)
lm_predictions = lm_pipeline.predict(x_test)
print("First 5 LM predictions: ", list(lm_predictions[:5]))

gbm_pipeline.fit(x_train, y_train)
gbm_predictions = gbm_pipeline.predict(x_test)
print("First 5 GBM predictions: ", list(gbm_predictions[:5]))


# In[]:
# With predictions ready from the two pipelines, we can proceed to evaluate the 
# accuracy of these predictions using mean absolute error (MAE) and mean squared 
# error (RMSE).
# Calculate mean square error and root mean squared error

lm_mae = mean_absolute_error(lm_predictions, y_test)
lm_rmse = np.sqrt(mean_squared_error(lm_predictions, y_test))
print("LM MAE: {:.2f}".format(round(lm_mae, 2)))
print("LM RMSE: {:.2f}".format(round(lm_rmse, 2)))

gbm_mae = mean_absolute_error(gbm_predictions, y_test)
gbm_rmse = np.sqrt(mean_squared_error(gbm_predictions, y_test))
print("GBM MAE: {:.2f}".format(round(gbm_mae, 2)))
print("GBM RMSE: {:.2f}".format(round(gbm_rmse, 2)))


# In[]:
    # here we'll use dhs_0_1_wg as the response vector for the classifiers
x = datasetv2[["DHS_prop_repeat", 
                    "DHS_prop_GC", "DHS_length", "n_SNV_Zhou_per_bp", 
                    "distanceToTSS", "zeta.human", "zeta.chimp", "PP_con", "PP_acc", 
                    "PhastCons",
                    "chromHMM_cat_longest", 
                    "annotation", "PhyloP_primates_score"]]
y = datasetv2["dhs_0_1_wg"]

# In[]:
    # Make column transformer
column_transform = []
column_transform = make_column_transformer(
    (ohe, ['chromHMM_cat_longest','annotation']))

#Apply column transformer to predictor variables
column_transform.fit(x)


# In[]:
# Splitting train and split data
# The test data set size is 20% of the total records. This test data will not 
# be used in model training and work as an independent test data.
x_train, x_test, y_train, y_test=train_test_split(x,y,test_size=0.2, random_state=0)
# In[]:

lr_pipeline.fit(x_train, y_train)
lr_predictions = lr_pipeline.predict(x_test)
print("First 5 LR predictions: ", list(lr_predictions[:5]))

sv_pipeline.fit(x_train, y_train)
sv_predictions = sv_pipeline.predict(x_test)
print("First 5 SVM predictions: ", list(sv_predictions[:5]))

#rf_pipeline.fit(x_train, y_train)
#rf_predictions = rf_pipeline.predict(x_test)
#print("First 5 RF predictions: ", list(rf_predictions[:5]))
# To use random forest, need binary outcome

# In[]:
# With predictions ready from the two pipelines, we can proceed to evaluate the 
# accuracy of these predictions using mean absolute error (MAE) and mean squared 
# error (RMSE).
# Calculate mean square error and root mean squared error

lr_mae = mean_absolute_error(lr_predictions, y_test)
lr_rmse = np.sqrt(mean_squared_error(lr_predictions, y_test))
print("LR MAE: {:.2f}".format(round(lr_mae, 2)))
print("LR RMSE: {:.2f}".format(round(lr_rmse, 2)))

sv_mae = mean_absolute_error(sv_predictions, y_test)
sv_rmse = np.sqrt(mean_squared_error(sv_predictions, y_test))
print("SVM MAE: {:.2f}".format(round(sv_mae, 2)))
print("SVM RMSE: {:.2f}".format(round(sv_rmse, 2)))

# In[]:
# Performing this same pipeline but using the extreme subsets of "score"
# In[]:
    # here we'll start by using wgCERES_score_nosig as the response vector,
x = datasetLower[["DHS_prop_repeat", 
                    "DHS_prop_GC", "DHS_length", "n_SNV_Zhou_per_bp", 
                    "distanceToTSS", "zeta.human", "zeta.chimp", "PP_con", "PP_acc", 
                    "PhastCons",
                    "chromHMM_cat_longest", 
                    "annotation", "PhyloP_primates_score"]]
y = datasetLower["wgCERES_score_nosig"]
# For classifier ML techniques, i.e. SVM and Random Forest
# y = datasetLower["dhs_0_1_wg"]

# In[]:
    # Make column transformer
column_transform = []
column_transform = make_column_transformer(
    (ohe, ['chromHMM_cat_longest','annotation']))

#Apply column transformer to predictor variables
column_transform.fit(x)


# In[]:
# Splitting train and split data
# The test data set size is 20% of the total records. This test data will not 
# be used in model training and work as an independent test data.
x_train, x_test, y_train, y_test=train_test_split(x,y,test_size=0.2, random_state=0)

# In[]:
# Building the rest of the pipeline
# Instantiate pipeline with linear regression
lm  = LinearRegression()
lm_pipeline = make_pipeline(column_transform, lm)

# In[]:
# Instantiate pipeline with gradient boosting
gbm = GradientBoostingRegressor()
gbm_pipeline = make_pipeline(column_transform, gbm)

# In[]:
# Instantiate pipeline with logistic regression
lr = LogisticRegression()
lr_pipeline = make_pipeline(column_transform, lr)

# In[]:
# Instantiate pipeline for SVM
sv = SVC()
sv_pipeline = make_pipeline(column_transform, sv)

# In[]:
# Fit pipeline to training set and make predictions on test set

lm_pipeline.fit(x_train, y_train)
lm_predictions = lm_pipeline.predict(x_test)
print("First 5 LM predictions: ", list(lm_predictions[:5]))

gbm_pipeline.fit(x_train, y_train)
gbm_predictions = gbm_pipeline.predict(x_test)
print("First 5 GBM predictions: ", list(gbm_predictions[:5]))


# In[]:
# With predictions ready from the two pipelines, we can proceed to evaluate the 
# accuracy of these predictions using mean absolute error (MAE) and mean squared 
# error (RMSE).
# Calculate mean square error and root mean squared error

lm_mae = mean_absolute_error(lm_predictions, y_test)
lm_rmse = np.sqrt(mean_squared_error(lm_predictions, y_test))
print("LM MAE: {:.2f}".format(round(lm_mae, 2)))
print("LM RMSE: {:.2f}".format(round(lm_rmse, 2)))

gbm_mae = mean_absolute_error(gbm_predictions, y_test)
gbm_rmse = np.sqrt(mean_squared_error(gbm_predictions, y_test))
print("GBM MAE: {:.2f}".format(round(gbm_mae, 2)))
print("GBM RMSE: {:.2f}".format(round(gbm_rmse, 2)))


# In[]:
    # here we'll use dhs_0_1_wg as the response vector for the classifiers
x = datasetLower[["DHS_prop_repeat", 
                    "DHS_prop_GC", "DHS_length", "n_SNV_Zhou_per_bp", 
                    "distanceToTSS", "zeta.human", "zeta.chimp", "PP_con", "PP_acc", 
                    "PhastCons",
                    "chromHMM_cat_longest", 
                    "annotation", "PhyloP_primates_score"]]
y = datasetLower["dhs_0_1_wg"]

# In[]:
    # Make column transformer
column_transform = []
column_transform = make_column_transformer(
    (ohe, ['chromHMM_cat_longest','annotation']))

#Apply column transformer to predictor variables
column_transform.fit(x)


# In[]:
# Splitting train and split data
# The test data set size is 20% of the total records. This test data will not 
# be used in model training and work as an independent test data.
x_train, x_test, y_train, y_test=train_test_split(x,y,test_size=0.2, random_state=0)
# In[]:

lr_pipeline.fit(x_train, y_train)
lr_predictions = lr_pipeline.predict(x_test)
print("First 5 LR predictions: ", list(lr_predictions[:5]))

sv_pipeline.fit(x_train, y_train)
sv_predictions = sv_pipeline.predict(x_test)
print("First 5 SVM predictions: ", list(sv_predictions[:5]))

#rf_pipeline.fit(x_train, y_train)
#rf_predictions = rf_pipeline.predict(x_test)
#print("First 5 RF predictions: ", list(rf_predictions[:5]))
# To use random forest, need binary outcome

# In[]:
# With predictions ready from the two pipelines, we can proceed to evaluate the 
# accuracy of these predictions using mean absolute error (MAE) and mean squared 
# error (RMSE).
# Calculate mean square error and root mean squared error

lr_mae = mean_absolute_error(lr_predictions, y_test)
lr_rmse = np.sqrt(mean_squared_error(lr_predictions, y_test))
print("LR MAE: {:.2f}".format(round(lr_mae, 2)))
print("LR RMSE: {:.2f}".format(round(lr_rmse, 2)))

sv_mae = mean_absolute_error(sv_predictions, y_test)
sv_rmse = np.sqrt(mean_squared_error(sv_predictions, y_test))
print("SVM MAE: {:.2f}".format(round(sv_mae, 2)))
print("SVM RMSE: {:.2f}".format(round(sv_rmse, 2)))

# In[]:
    # here we'll start by using wgCERES_score_nosig as the response vector,
x = datasetUpper[["DHS_prop_repeat", 
                    "DHS_prop_GC", "DHS_length", "n_SNV_Zhou_per_bp", 
                    "distanceToTSS", "zeta.human", "zeta.chimp", "PP_con", "PP_acc", 
                    "PhastCons",
                    "chromHMM_cat_longest", 
                    "annotation", "PhyloP_primates_score"]]
y = datasetUpper["wgCERES_score_nosig"]
# For classifier ML techniques, i.e. SVM and Random Forest
# y = datasetUpper["dhs_0_1_wg"]

# In[]:
    # Make column transformer
column_transform = []
column_transform = make_column_transformer(
    (ohe, ['chromHMM_cat_longest','annotation']))

#Apply column transformer to predictor variables
column_transform.fit(x)


# In[]:
# Splitting train and split data
# The test data set size is 20% of the total records. This test data will not 
# be used in model training and work as an independent test data.
x_train, x_test, y_train, y_test=train_test_split(x,y,test_size=0.2, random_state=0)

# In[]:
# Building the rest of the pipeline
# Instantiate pipeline with linear regression
lm  = LinearRegression()
lm_pipeline = make_pipeline(column_transform, lm)

# In[]:
# Instantiate pipeline with gradient boosting
gbm = GradientBoostingRegressor()
gbm_pipeline = make_pipeline(column_transform, gbm)

# In[]:
# Instantiate pipeline with logistic regression
lr = LogisticRegression()
lr_pipeline = make_pipeline(column_transform, lr)

# In[]:
# Instantiate pipeline for SVM
sv = SVC()
sv_pipeline = make_pipeline(column_transform, sv)

# In[]:
# Fit pipeline to training set and make predictions on test set

lm_pipeline.fit(x_train, y_train)
lm_predictions = lm_pipeline.predict(x_test)
print("First 5 LM predictions: ", list(lm_predictions[:5]))

gbm_pipeline.fit(x_train, y_train)
gbm_predictions = gbm_pipeline.predict(x_test)
print("First 5 GBM predictions: ", list(gbm_predictions[:5]))


# In[]:
# With predictions ready from the two pipelines, we can proceed to evaluate the 
# accuracy of these predictions using mean absolute error (MAE) and mean squared 
# error (RMSE).
# Calculate mean square error and root mean squared error

lm_mae = mean_absolute_error(lm_predictions, y_test)
lm_rmse = np.sqrt(mean_squared_error(lm_predictions, y_test))
print("LM MAE: {:.2f}".format(round(lm_mae, 2)))
print("LM RMSE: {:.2f}".format(round(lm_rmse, 2)))

gbm_mae = mean_absolute_error(gbm_predictions, y_test)
gbm_rmse = np.sqrt(mean_squared_error(gbm_predictions, y_test))
print("GBM MAE: {:.2f}".format(round(gbm_mae, 2)))
print("GBM RMSE: {:.2f}".format(round(gbm_rmse, 2)))


# In[]:
    # here we'll use dhs_0_1_wg as the response vector for the classifiers
x = datasetUpper[["DHS_prop_repeat", 
                    "DHS_prop_GC", "DHS_length", "n_SNV_Zhou_per_bp", 
                    "distanceToTSS", "zeta.human", "zeta.chimp", "PP_con", "PP_acc", 
                    "PhastCons",
                    "chromHMM_cat_longest", 
                    "annotation", "PhyloP_primates_score"]]
y = datasetUpper["dhs_0_1_wg"]

# In[]:
    # Make column transformer
column_transform = []
column_transform = make_column_transformer(
    (ohe, ['chromHMM_cat_longest','annotation']))

#Apply column transformer to predictor variables
column_transform.fit(x)


# In[]:
# Splitting train and split data
# The test data set size is 20% of the total records. This test data will not 
# be used in model training and work as an independent test data.
x_train, x_test, y_train, y_test=train_test_split(x,y,test_size=0.2, random_state=0)
# In[]:

lr_pipeline.fit(x_train, y_train)
lr_predictions = lr_pipeline.predict(x_test)
print("First 5 LR predictions: ", list(lr_predictions[:5]))

sv_pipeline.fit(x_train, y_train)
sv_predictions = sv_pipeline.predict(x_test)
print("First 5 SVM predictions: ", list(sv_predictions[:5]))

#rf_pipeline.fit(x_train, y_train)
#rf_predictions = rf_pipeline.predict(x_test)
#print("First 5 RF predictions: ", list(rf_predictions[:5]))
# To use random forest, need binary outcome

# In[]:
# With predictions ready from the two pipelines, we can proceed to evaluate the 
# accuracy of these predictions using mean absolute error (MAE) and mean squared 
# error (RMSE).
# Calculate mean square error and root mean squared error

lr_mae = mean_absolute_error(lr_predictions, y_test)
lr_rmse = np.sqrt(mean_squared_error(lr_predictions, y_test))
print("LR MAE: {:.2f}".format(round(lr_mae, 2)))
print("LR RMSE: {:.2f}".format(round(lr_rmse, 2)))

sv_mae = mean_absolute_error(sv_predictions, y_test)
sv_rmse = np.sqrt(mean_squared_error(sv_predictions, y_test))
print("SVM MAE: {:.2f}".format(round(sv_mae, 2)))
print("SVM RMSE: {:.2f}".format(round(sv_rmse, 2)))

# In[]:
    # After filtering for OCRs that are only present within certain TADs,
    # reading in that dataset here and testing the harness again
dataset=pd.read_csv('/Users/jamesonblount/Documents/Wray_Rotation/Carl/X_0012/data/OCRs_inTADs.csv')
dataset.isnull().sum()

datasetv2 = dataset.dropna(axis=1)
datasetv2.isnull().sum()
# Checking the data set for any NULL values is very essential, as MLAs can not 
# handle NULL values. We have to either eliminate the records with NULL values 
# or replace them with the mean/median of the other values. we can see each of 
# the variables are printed with number of null values. This data set has no null 
# values so all are zero here.
# In[]:
    # here we'll start by using wgCERES_score_nosig as the response vector,
x = datasetv2[["DHS_prop_repeat", 
                    "DHS_prop_GC", "DHS_length", "n_SNV_Zhou_per_bp", 
                    "distanceToTSS", "zeta.human", "zeta.chimp", "PP_con", "PP_acc", 
                    "PhastCons",
                    "chromHMM_cat_longest", 
                    "annotation", "PhyloP_primates_score"]]
y = datasetv2["wgCERES_score_nosig"]
# For classifier ML techniques, i.e. SVM and Random Forest
# y = datasetv2["dhs_0_1_wg"]

# In[]:
    # Make column transformer
column_transform = []
column_transform = make_column_transformer(
    (ohe, ['chromHMM_cat_longest','annotation']))

#Apply column transformer to predictor variables
column_transform.fit(x)


# In[]:
# Splitting train and split data
# The test data set size is 20% of the total records. This test data will not 
# be used in model training and work as an independent test data.
x_train, x_test, y_train, y_test=train_test_split(x,y,test_size=0.2, random_state=0)

# In[]:
# Building the rest of the pipeline
# Instantiate pipeline with linear regression
lm  = LinearRegression()
lm_pipeline = make_pipeline(column_transform, lm)

# In[]:
# Instantiate pipeline with gradient boosting
gbm = GradientBoostingRegressor()
gbm_pipeline = make_pipeline(column_transform, gbm)

# In[]:
# Instantiate pipeline with logistic regression
lr = LogisticRegression()
lr_pipeline = make_pipeline(column_transform, lr)

# In[]:
# Instantiate pipeline for SVM
sv = SVC()
sv_pipeline = make_pipeline(column_transform, sv)

# In[]:
# Fit pipeline to training set and make predictions on test set

lm_pipeline.fit(x_train, y_train)
lm_predictions = lm_pipeline.predict(x_test)
print("First 5 LM predictions: ", list(lm_predictions[:5]))

gbm_pipeline.fit(x_train, y_train)
gbm_predictions = gbm_pipeline.predict(x_test)
print("First 5 GBM predictions: ", list(gbm_predictions[:5]))


# In[]:
# With predictions ready from the two pipelines, we can proceed to evaluate the 
# accuracy of these predictions using mean absolute error (MAE) and mean squared 
# error (RMSE).
# Calculate mean square error and root mean squared error

lm_mae = mean_absolute_error(lm_predictions, y_test)
lm_rmse = np.sqrt(mean_squared_error(lm_predictions, y_test))
print("LM MAE: {:.2f}".format(round(lm_mae, 2)))
print("LM RMSE: {:.2f}".format(round(lm_rmse, 2)))

gbm_mae = mean_absolute_error(gbm_predictions, y_test)
gbm_rmse = np.sqrt(mean_squared_error(gbm_predictions, y_test))
print("GBM MAE: {:.2f}".format(round(gbm_mae, 2)))
print("GBM RMSE: {:.2f}".format(round(gbm_rmse, 2)))


# In[]:
    # here we'll use dhs_0_1_wg as the response vector for the classifiers
x = datasetv2[["DHS_prop_repeat", 
                    "DHS_prop_GC", "DHS_length", "n_SNV_Zhou_per_bp", 
                    "distanceToTSS", "zeta.human", "zeta.chimp", "PP_con", "PP_acc", 
                    "PhastCons",
                    "chromHMM_cat_longest", 
                    "annotation", "PhyloP_primates_score"]]
y = datasetv2["dhs_0_1_wg"]

# In[]:
    # Make column transformer
column_transform = []
column_transform = make_column_transformer(
    (ohe, ['chromHMM_cat_longest','annotation']))

#Apply column transformer to predictor variables
column_transform.fit(x)


# In[]:
# Splitting train and split data
# The test data set size is 20% of the total records. This test data will not 
# be used in model training and work as an independent test data.
x_train, x_test, y_train, y_test=train_test_split(x,y,test_size=0.2, random_state=0)
# In[]:

lr_pipeline.fit(x_train, y_train)
lr_predictions = lr_pipeline.predict(x_test)
print("First 5 LR predictions: ", list(lr_predictions[:5]))

sv_pipeline.fit(x_train, y_train)
sv_predictions = sv_pipeline.predict(x_test)
print("First 5 SVM predictions: ", list(sv_predictions[:5]))

#rf_pipeline.fit(x_train, y_train)
#rf_predictions = rf_pipeline.predict(x_test)
#print("First 5 RF predictions: ", list(rf_predictions[:5]))
# To use random forest, need binary outcome

# In[]:
# With predictions ready from the two pipelines, we can proceed to evaluate the 
# accuracy of these predictions using mean absolute error (MAE) and mean squared 
# error (RMSE).
# Calculate mean square error and root mean squared error

lr_mae = mean_absolute_error(lr_predictions, y_test)
lr_rmse = np.sqrt(mean_squared_error(lr_predictions, y_test))
print("LR MAE: {:.2f}".format(round(lr_mae, 2)))
print("LR RMSE: {:.2f}".format(round(lr_rmse, 2)))

sv_mae = mean_absolute_error(sv_predictions, y_test)
sv_rmse = np.sqrt(mean_squared_error(sv_predictions, y_test))
print("SVM MAE: {:.2f}".format(round(sv_mae, 2)))
print("SVM RMSE: {:.2f}".format(round(sv_rmse, 2)))