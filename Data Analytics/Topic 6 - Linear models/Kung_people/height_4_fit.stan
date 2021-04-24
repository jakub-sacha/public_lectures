data {
  int N; //number of measurements
  int K; //number of predictors
  matrix [N,K] X; //design matrix
  real heights[N];
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
  alpha ~ normal(178,20);
  beta ~ normal(0,10);
  sigma ~ exponential(0.067);
  heights ~ normal(mu,sigma);
}

generated quantities {
  real height[N];
  for (i in 1:N) {
    height[i] = normal_rng(mu[i],sigma);
  }
}
