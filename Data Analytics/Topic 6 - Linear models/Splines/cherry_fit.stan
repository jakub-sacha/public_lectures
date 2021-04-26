data {
  int N; //number of measurements
  int K; //number of basis functions
  matrix [N,K] X; //design matrix
  real y[N]; //measurements
}

parameters {
  real alpha;
  vector[K] beta;
  real<lower=0> sigma;
}

transformed parameters {
  vector[N] mu = X*beta+alpha;
}

model {
  alpha ~ normal(100,10);
  beta ~ normal(0,10);
  sigma ~ exponential(1);
  y ~ normal(mu,sigma);
}

generated quantities {
  real y_pred[N];
  for (i in 1:N) {
    y_pred[i] = normal_rng(mu[i],sigma);
  }
}
