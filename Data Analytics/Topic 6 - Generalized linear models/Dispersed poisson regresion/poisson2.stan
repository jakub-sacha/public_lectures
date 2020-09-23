data {
  int<lower=0> M; // Number of covariates
  int<lower=0> N; // Number of observations
  matrix[N, M] X; // Covariate design matrix
  int y[N];      // Variates
}

transformed data {
  vector[N] ones_N = rep_vector(1, N);
}

parameters {
  vector[M] beta;  // Slopes
  real alpha;      // Intercept
}

model {
  // Prior model
  beta ~ normal(0, 2);
  alpha ~ normal(0, 2);

  // Observational model

  // poisson_log automatically exponentiates the input
  // poisson_log(X * beta + alpha) = poisson(exp(X * beta + alpha))
  y ~ poisson_log(X * beta + alpha);
}

// Simulate a full observation from the current value of the parameters
generated quantities {
  int y_ppc[N] = poisson_log_rng(X * beta + ones_N*alpha);
}
