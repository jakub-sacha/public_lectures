# Lab 2 -  Intro to stan
F - number of letters in first name
L - number of letters in last name


## Excercise 1 - generated quantities
1. Compile code_1.stan and sample from it using N=F
2. Create a pandas dataframe from resulting draws.
3. Plot a histogram for each of theta and lambda

## Excercise 2 - constraints on the data
1. Observe how constraints on data behave for code_2 and code_3

### Excercise 3 - constraints on the parameters
1. Constraints in parameters behave more subtely. We are infering theta without data from its prior.
2. Please see diagnostic messages from code_4 and how samples from it compare to the probability distribution.
3. Verify what changes if constraints are added as in code_5

### Excercise 4 - functions and different functionalities of stan
1. Stan outside of sampling allows for certain computational tools. In particular equation solving.
2. Using code_6 find the standard deviation of half_normal distribution, such that with 99% probability samples from it will be less than (F+L)/2.
