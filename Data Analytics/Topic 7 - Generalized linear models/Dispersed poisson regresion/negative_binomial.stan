data {
  int<lower=0> M; // Number of covariates
  int<lower=0> N; // Number of observations
  matrix[N, M] X; // Covariate design matrix
  int y[N];      // Variates
}

parameters {
  vector[M] beta;        // Slopes
  real alpha;            // Intercept
  real<lower=0> inv_phi; // Over-dispersion parameter
}

transformed parameters {
  // Save phi
  real<lower=0> phi = 1 / inv_phi;
}

model {
  // Prior model
  beta ~ normal(0, 2);
  alpha ~ normal(0, 2);

  // inv_phi is more interpretable because inv_phi = 0
  // corresponds to the initial Poisson model
  inv_phi ~ exponential(1);

  // Observational model
  y ~ neg_binomial_2_log(X * beta + alpha, phi);
}

// Simulate a full observation from the current value of the parameters
generated quantities {
  int y_ppc[N];
  for (n in 1:N)
    y_ppc[n] = neg_binomial_2_log_rng(X[n] * beta + alpha, phi);
}
