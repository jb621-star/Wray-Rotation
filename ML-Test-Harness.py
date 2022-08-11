#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul 13 11:00:28 2022

@author: jamesonblount
"""

# Compare Machine Learning Algorithms Consistently
# Using a consistent test harness

# In the example below 6 different algorithms are compared:

# 1. Logistic Regression
# 2. inear Discriminant Analysis
# 3. K-Nearest Neighbors
# 4. Classification and Regression Trees
# 5. Naive Bayes
# 6. Support Vector Machines

# The problem is a standard binary classification dataset called the Pima Indians 
# onset of diabetes problem using data gathered from the “National Institute 
# of Diabetes and Digestive and Kidney Diseases”. 
# The problem has two classes and eight numeric input variables of varying scales.

# Each algorithm is given a short name, useful for summarizing results afterward.

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

# In[]:
#Loading the data and checking for missing values
dataset=pd.read_csv('/Users/jamesonblount/Documents/Wray_Rotation/Code/pimaindiansdiabetes.csv')
dataset.isnull().sum()

# Checking the data set for any NULL values is very essential, as MLAs can not 
# handle NULL values. We have to either eliminate the records with NULL values 
# or replace them with the mean/median of the other values. we can see each of 
# the variables are printed with number of null values. This data set has no null 
# values so all are zero here.

# In[]:
# Creating variables for analysis
# As we can see that the data frame contains nine variables in nine columns. 
# The first eight columns contain the independent variables. These are some 
# physiological variables having a correlation with diabetes symptoms. The ninth 
# column shows if the patient is diabetic or not. So, here the x stores the 
# independent variables and y stores the dependent variable diabetes count.
x=dataset.iloc[:,: -1]
y=dataset.iloc[:,-1]

# In[]:
# Splitting train and split data
# The test data set size is 20% of the total records. This test data will not 
# be used in model training and work as an independent test data.
x_train, x_test, y_train, y_test=train_test_split(x,y,test_size=0.2, random_state=0)

# In[]:
# Application of all Machine Learning methods
# Some very popular MLAs we have selected here for comparison and stored in a 
# variable; so that they can be used at later part of the process. The MLAs 
# first we have taken up for comparison are Logistic Regression, Linear 
# Discriminant Analysis, K-nearest neighbour classifier, Decision tree classifier, 
# Naive-Bayes classifier and Support Vector Machine.
models = []
models.append(('LR', LogisticRegression()))
models.append(('LDA', LinearDiscriminantAnalysis()))
models.append(('KNN', KNeighborsClassifier()))
models.append(('CART', DecisionTreeClassifier()))
models.append(('NB', GaussianNB()))
models.append(('SVM', SVC()))

# In[]:
# evaluate each model in turn
results = []
names = []
scoring = 'accuracy'
for name, model in models:
	kfold = model_selection.KFold(n_splits=10, random_state=None, shuffle=False)
	cv_results = model_selection.cross_val_score(model, x_train, y_train, cv=kfold, scoring=scoring)
	results.append(cv_results)
	names.append(name)
	msg = "%s: %f (%f)" % (name, cv_results.mean(), cv_results.std())
	print(msg)
# boxplot algorithm comparison
fig = plt.figure()
fig.suptitle('Comparison between different MLAs')
ax = fig.add_subplot(111)
plt.boxplot(results)
ax.set_xticklabels(names)
plt.show()    
    
# In[]:
# Application of all Machine Learning methods
MLA = [
    #GLM
    linear_model.LogisticRegressionCV(max_iter=2000),
    linear_model.PassiveAggressiveClassifier(max_iter=2000),
    linear_model.SGDClassifier(max_iter=2000),
    linear_model.Perceptron(max_iter=2000),
    
    #Ensemble Methods
    ensemble.AdaBoostClassifier(),
    ensemble.BaggingClassifier(),
    ensemble.ExtraTreesClassifier(),
    ensemble.GradientBoostingClassifier(),
    ensemble.RandomForestClassifier(),

    #Gaussian Processes
    gaussian_process.GaussianProcessClassifier(),
    
    #SVM
    svm.SVC(probability=True),
    svm.NuSVC(probability=True),
    #svm.LinearSVC(max_iter=2000),
    
    #Trees    
    tree.DecisionTreeClassifier(),
  
    #Navies Bayes
    naive_bayes.BernoulliNB(),
    naive_bayes.GaussianNB(),
    
    #Nearest Neighbor
    neighbors.KNeighborsClassifier(),
    ]
  
# In[]:
    #Generating a dataframe to visualize comparison betweeen all algorithms
MLA_columns = []
MLA_compare = pd.DataFrame(columns = MLA_columns)

row_index = 0
for alg in MLA:  
    
    predicted = alg.fit(x_train, y_train).predict(x_test)
    fp, tp, th = roc_curve(y_test, predicted)
    MLA_name = alg.__class__.__name__
    MLA_compare.loc[row_index,'MLA used'] = MLA_name
    MLA_compare.loc[row_index, 'Train Accuracy'] = round(alg.score(x_train, y_train), 4)
    MLA_compare.loc[row_index, 'Test Accuracy'] = round(alg.score(x_test, y_test), 4)
    MLA_compare.loc[row_index, 'Precission'] = precision_score(y_test, predicted)
    MLA_compare.loc[row_index, 'Recall'] = recall_score(y_test, predicted)
    MLA_compare.loc[row_index, 'AUC'] = auc(fp, tp)

    row_index+=1
    
MLA_compare.sort_values(by = ['Test Accuracy'], ascending = False, inplace = True)    
MLA_compare

# In[]:
    # Creating plot to show the train accuracy
plt.subplots(figsize=(13,5))
sns.barplot(x="MLA used", y="Train Accuracy",data=MLA_compare,palette='hot',edgecolor=sns.color_palette('dark',7))
plt.xticks(rotation=90)
plt.title('MLA Train Accuracy Comparison')
plt.show()

# In[]:
    # Creating plot to show the test accuracy
plt.subplots(figsize=(13,5))
sns.barplot(x="MLA used", y="Test Accuracy",data=MLA_compare,palette='hot',edgecolor=sns.color_palette('dark',7))
plt.xticks(rotation=90)
plt.title('Accuraccy of different machine learning models')
plt.show()

# In[]:
    # Creating plots to compare precision of the MLAs
plt.subplots(figsize=(13,5))
sns.barplot(x="MLA used", y="Precission",data=MLA_compare,palette='hot',edgecolor=sns.color_palette('dark',7))
plt.xticks(rotation=90)
plt.title('Comparing different Machine Learning Models')
plt.show()

# In[]:
    # Creating plots for MLA recall comparison
plt.subplots(figsize=(13,5))
sns.barplot(x="MLA used", y="Recall",data=MLA_compare,palette='hot',edgecolor=sns.color_palette('dark',7))
plt.xticks(rotation=90)
plt.title('MLA Recall Comparison')
plt.show()

# In[]:
    # Creating plot for MLA AUC comparison
plt.subplots(figsize=(13,5))
sns.barplot(x="MLA used", y="AUC",data=MLA_compare,palette='hot',edgecolor=sns.color_palette('dark',7))
plt.xticks(rotation=90)
plt.title('MLA AUC Comparison')
plt.show()

# In[]:
  # Creating plot to show the ROC for all MLA
# Receiver Operating Characteristic (ROC) curve is a very important tool to 
# diagnose the performance of MLAs by plotting the true positive rates against 
# the false-positive rates at different threshold levels. The area under ROC 
# curve often called AUC and it is also a good measure of the predictability of 
# the machine learning algorithms. A higher AUC is an indication of more 
# accurate prediction
index = 1
for alg in MLA:
    
    
    predicted = alg.fit(x_train, y_train).predict(x_test)
    fp, tp, th = roc_curve(y_test, predicted)
    roc_auc_mla = auc(fp, tp)
    MLA_name = alg.__class__.__name__
    plt.plot(fp, tp, lw=2, alpha=0.3, label='ROC %s (AUC = %0.2f)'  % (MLA_name, roc_auc_mla))
   
    index+=1

plt.title('ROC Curve comparison')
plt.legend(bbox_to_anchor=(1.05, 1), loc=2, borderaxespad=0.)
plt.plot([0,1],[0,1],'r--')
plt.xlim([0,1])
plt.ylim([0,1])
plt.ylabel('True Positive Rate')
plt.xlabel('False Positive Rate')    
plt.show()  