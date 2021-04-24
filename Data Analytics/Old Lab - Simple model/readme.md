# Creating a simple Bayesian model

Using the data from following table create a model predicting number of passenger deaths. Use poisson distribution in two variants

1. The rate is constant for all years and not depending on anything.
2. The intensity is constant, but rate is a product of intensity and miles flown.

Select appropriate priors, perform prior predictive checks, fit the model and using posterior predictive distribution predict the death rates from the model.

| Year | Fatal accidents | Passenger deaths | Death rate | Miles flown [100 mln miles] |
|------|-----------------|------------------|------------|-----------------------------|
| 1976 | 24              | 734              | 0.19       | 3863.0                      |
| 1977 | 25              | 516              | 0.12       | 4300.0                      |
| 1978 | 31              | 754              | 0.15       | 5027.0                      |
| 1979 | 31              | 877              | 0.16       | 5481.0                      |
| 1980 | 22              | 814              | 0.14       | 5814.0                      |
| 1981 | 21              | 362              | 0.06       | 6033.0                      |
| 1982 | 26              | 764              | 0.13       | 5877.0                      |
| 1983 | 20              | 809              | 0.13       | 6223.0                      |
| 1984 | 16              | 223              | 0.03       | 7433.0                      |
| 1985 | 22              | 1066             | 0.15       | 7107.0                      |
