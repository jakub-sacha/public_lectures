# Excercise 2 and 3

## Probabilistic building blocks

Recommended reading: [Probabilistic Building Blocks]
(https://betanalpha.github.io/assets/case_studies/probability_densities.html)
by Michael Betancourt([@ betanalpha](https://twitter.com/betanalpha))

### Part 1 - Sampling in Python and visualising samples.

We will analyze multiple probability distributions, that can be used as priors for Bayesian inference. We will be creating faceted histograms and cumulative distribution functions from pandas dataframes created with numpy.random module.
If names of columns are "pretty" then the plots will be well labeled.

The goal is to get a feel of parameters for certain popular distributions.

1. Normal distribution. Using [histograms](https://matplotlib.org/3.2.0/api/_as_gen/matplotlib.pyplot.hist.html) with and without cumulative option observe how increasing variance and mean changes look of the distribution. Check how number of bins influences the plots. Consider what would make normal distribution weekly informative and what will make it informative.
2. Transform samples from normal distribution with [inverse logit](https://docs.scipy.org/doc/scipy/reference/generated/scipy.special.logit.html). Consider how mean and standard deviation influence the shape of histogram and cdf. Is previously non-informative normal is still non-informative after transformation?
3. Poisson distribution. This distribution returns integers (give histogram location of bins instead of their numbers), depending on intensity. This is a good distribution for modelling countable effects. Observe how mean and variance influence the shape.
4. Beta distribution. This is a distribution defined on [0,1] interval. It is useful as a prior for probability parameters (like binomial distribution). Traditionally it is defined with $\alpha$ and $\beta$ parameters. There are however different reparametrizations possible. Verify how beta distributions behave for their natural parametrization, [location dispersion parametrization](https://betanalpha.github.io/assets/case_studies/probability_densities.html#242_the_location-dispersion_parameterization) and mean-population size parametrization (see lecture notes)
5. Log-normal distribution. This is a great distributions for positive variables, especially if scale can differ (for example salaries). Assumtion is that the logarithm of variable of interest is normaly distributed. Observe how mean and variance of normal distribution are propagating through transformation.


### Part 2 - Sampling in Stan

We will analyze more probability distributions this time using Stan and generated quantities block. Remember to set algorithm to "fixed params" (see notebooks). In order to find how to use distribution functions check [Stan documentation](https://mc-stan.org/users/documentation/), in particular [Stan Language Functions Reference](https://mc-stan.org/docs/2_23/functions-reference/index.html). All models used for sampling should take distribution parameters as data to avoid need for recompilation.

1. Gamma family distributions. These distributions are defined for positive real numbers.
Provide histograms of Gamma and invGamma distributions. See how tail behavior of those distributions behave. Using albebra_solver (see notebook from lecture on poisson distribution modelling) find parameters for Gamma and invGamma for which 98% probability is for values between 5 and 10. Sample for those distributions and compare histograms.

2. Negative binomial distribution.
Negative binomial distribution can be used in order to relax the constraints of equal mean and variance of Poissson distribution. Using both concentration and dispersion parametrization sample from negative binomial with fixed mean and see how it behaves in comparison to the Poisson with the same mean.

3. Student-t family distributions. Student-t distributions can be considered generalizations of Gaussian distributions with varying scale. Use both degrees of freedom and dispersion parametrizations to see how changing parameters moves from normal distribution. Take a special case of degrees of freedom equal to 1, as this is Cauchy distribution. See how mean and variance behave while you increase number of samples.

3. Multivariate normal distributions
Consider density plots and 2d histograms for visualisation of behavior of 2 dimensional Multivariate normal. Use the correlation matrix decompositon of covariance matrix to see how individual variances and correlations infulence the distribution.
For 3 and 4 dimensional normal distributions observe the marginals of variables with histograms.
