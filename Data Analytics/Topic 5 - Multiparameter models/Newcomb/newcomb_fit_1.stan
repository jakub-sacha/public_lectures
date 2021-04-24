data {
  int N; //number of samples
  real y[N];//measurements
}

parameters {
  real<lower=0> sigma;
  real mu;
}

model {
  target+=-2*log(sigma);
  target+=normal_lpdf(y|mu,sigma);
}

generated quantities {
    vector[N] log_lik;
    real mu_hat;
    for (j in 1:N) {
        log_lik[j] = normal_lpdf(y[j] | mu, sigma);
    }
    mu_hat = normal_rng(mu,sigma);
}
