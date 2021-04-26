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
  vector[M] beta;        // Slopes
  vector[N_hand] alpha;  // Intercepts for each handedness group
}

model {
  beta ~ normal(0, 0.75);   // Prior model
  alpha ~ normal(0, 0.75);  // Prior model
  y ~ bernoulli_logit(X * beta + alpha[hand]);  // Observational model
}

// Simulate empirical probabilities from the current value of the parameters
generated quantities {
  real p_hat_ppc = 0;
  real p_hat_left_ppc = 0;
  real p_hat_right_ppc = 0;
  vector[N] prob_ppc = inv_logit(X * beta + (to_vector(hand)-ones_N)*alpha[2]+(2*ones_N-to_vector(hand))*alpha[1]);

  {
    int n_left = 0;
    int n_right = 0;

    for (n in 1:N) {
      int y_ppc = bernoulli_logit_rng(X[n] * beta + alpha[hand[n]]);

      p_hat_ppc = p_hat_ppc + y_ppc;
      if (hand[n] == 1) {
        p_hat_left_ppc = p_hat_left_ppc + y_ppc;
        n_left = n_left + 1;
      }
      else {
        p_hat_right_ppc = p_hat_right_ppc + y_ppc;
        n_right = n_right + 1;
      }
    }

    p_hat_ppc = p_hat_ppc / (n_left + n_right);
    p_hat_left_ppc = p_hat_left_ppc / n_left;
    p_hat_right_ppc = p_hat_right_ppc / n_right;
  }
}
