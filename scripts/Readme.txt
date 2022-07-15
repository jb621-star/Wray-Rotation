x_0012 - I've built code to make random forests in x_0011 that take depmap, selection, and ceres data and integrate them. The idea here is to use the forests to understand more about what variables are important in predicting functional vulnerability of non-coding elements. My computer is not capable of generating forests for the whole dataset as the number of variables grows. This needs to be shifted to the cluster, and that is what I'm doing in experiment ID x_0012. Some general goals:

package code in a way that is convenient for cluster computing (i.e., is modular)
Figure out how to export plots from cluster jobs
Figure out how to parallelize/speed up the jobs
Look into implementing some sort of gradient boosting technique (like adaboost)
	Random Forests are not super sexy in ML world
	Boosting might outperform vanilla forest
	Developing a suite of transparent models might give me some insights that can be leveraged
		better/smarter black-box modeling
		summary algorithms (superlearner)
		bench-amenable questions

switched from hardac to dcc for R/4.x.x availability. 
looking into scikit-learn/tensorflow for running on hardac. will necessitate learning more python. 
apparently there is a tensorflow implementation for rstudio, which ive installed also and plan to play around with. This required miniconda installation. Also installing vanilla tensorflow via anaconda navigator.

I created a directory structure that I like for this project, and split the code into a modular format where i can source bits and pieces as needed:

x_0012/
x_0012/RImages/
x_0012/data/
x_0012/data/x_0011_df.csv
x_0012/results/
x_0012/scripts/
x_0012/scripts/batch_rf.sh
x_0012/scripts/slurm-7323113.out
x_0012/scripts/slurm-7323114.out
x_0012/scripts/x_0011_forest_io.R
x_0012/scripts/x_0011_fxns.R
x_0012/scripts/x_0011_lib-data.R
x_0012/scripts/x_0012_rf1.R
x_0012/scripts/x_0012_rf2.R
x_0012/scripts/trashed/


here, my data is the x_0011_df.csv file. x_0012_rf\d.R reads that in and loads libraries, and then sources x_0011_fxns.R and x_0011_forest_io.R, and finally makes a random forest and saves that object and some plots made from it. x_0011_fxns.R loads in my functions and x_0011_forest_io.R parsea the data, making input dataframes and matching output vectors that are compatible with the randomForest R package. Finally, batch_rf.sh contains a simple shell script that submits the x_0012\d.R scripts as individual jobs, parallelizing the workflow. 



