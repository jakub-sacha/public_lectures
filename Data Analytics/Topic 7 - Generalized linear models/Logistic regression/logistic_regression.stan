data {
  int<lower=1> N; // Number of observations
  int<lower=1> M; // Number of covariates

  matrix[N, M] X;             // Covariate design matrix
  int<lower=0, upper=1> y[N]; // Binary variates

  int<lower=1> N_hand;           // Number of handedness groups
  int<lower=1, upper=2> hand[N]; // Handedness group assignments
}

transformed data {
  vector[N] ones_N = rep_vector(1, N);
}

parameters {
  vector[M] beta;      // Slopes
  real alpha;          // Intercept
}


model {
  beta ~ normal(0, 0.75);   // Prior model
  alpha ~ normal(0, 0.75);  // Prior model
  y ~ bernoulli_logit(X * beta + alpha);  // Observational model
}

// Simulate empirical probabilities from the current value of the parameters
generated quantities {
  real p_hat_ppc = 0;
  real p_hat_left_ppc = 0;
  real p_hat_right_ppc = 0;
  int y_ppc[N] = bernoulli_logit_rng(X * beta + ones_N*alpha);
  vector[N] prob_ppc = inv_logit(X * beta + ones_N*alpha);
  {
    int n_left = 0;
    int n_right = 0;

    for (n in 1:N) {

      p_hat_ppc = p_hat_ppc + y_ppc[n];
      if (hand[n] == 1) {
        p_hat_left_ppc = p_hat_left_ppc + y_ppc[n];
        n_left = n_left + 1;
      }
      else {
        p_hat_right_ppc = p_hat_right_ppc + y_ppc[n];
        n_right = n_right + 1;
      }
    }

    p_hat_ppc = p_hat_ppc / (n_left + n_right);
    p_hat_left_ppc = p_hat_left_ppc / n_left;
    p_hat_right_ppc = p_hat_right_ppc / n_right;
  }
}
