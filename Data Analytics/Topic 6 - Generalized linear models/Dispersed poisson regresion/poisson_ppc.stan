data {
  int<lower=0> M; // Number of covariates
  int<lower=0> N; // Number of observations
  matrix[N, M] X; // Covariate design matrix
  real<lower=0> sigma;      // prior_standard_deviation
}

transformed data {
  vector[N] ones_N = rep_vector(1, N);
  vector[M] ones_M = rep_vector(1, M);
}

// Simulate a full observation from the current value of the parameters
generated quantities {
  real  beta[M] = normal_rng(ones_M * 0,ones_M * sigma);  // Slopes
  real alpha = normal_rng(0,sigma);      // Intercept
  vector[N] lambda = X * to_vector(beta) + ones_N * alpha;
  int y_ppc[N] = poisson_log_rng(lambda);
}
