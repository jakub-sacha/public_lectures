# Excercise 1 

## Review of data wrangling and visualization in Python

In this excercise we will familiarize ourselves with pandas, and matplotlib package.

Course of excercise:

1. Import Data1.csv file to python.
2. Set first column as the index.
3. Plot all columns as time series.
4. Plot histograms of all columns, verify bin size. Plot all on a single, faceted plot.
5. Plot KDE-s (Kernel Denisty Estimators) for all columns. 
6. Repeat analysis for columns $\theta_1$-$\theta_4$ in 2018.

# Excercise 2

Installation of [```cmdstanpy```](https://cmdstanpy.readthedocs.io/en/v0.9.68/index.html)
1. Install ```cmdstanpy``` package
2. Install cmdstan
2. Create a dataset (as a dictionary) of F+L binary samples with F zeros and L ones, with F=number of letters in first name, L=number of letters in last name. Dictionary needs to consist of N=F+L, and y = list of samples.
3. Create a cmdstanpy model from ```bern_1.stan``` code provided.
4. Sample from the model using the dataset and ```.sample()``` method
5. Extract $\theta$ variable and create its histogram.
6. Using ```.summary()``` method get mean, median and 5% and 95% quantiles of theta, and mark them on the histogram.
