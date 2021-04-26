data {
  int N;
  vector[N] weight;
  real heights[N];
}

parameters {
  real alpha;
  real beta_1;
  real beta_2;
  real<lower=0> sigma;
}

transformed parameters {
  vector[N] mu;
  for (i in 1:N) {
    mu[i] = weight[i]*beta_1+weight[i]^2*beta_2+alpha;
  }
}

model {
  alpha ~ normal(178,20);
  beta_1 ~ lognormal(0,1);
  beta_2 ~ normal(0,10);
  sigma ~ exponential(0.067);
  heights ~ normal(mu,sigma);
}

generated quantities {
  real height[N];
  for (i in 1:N) {
    height[i] = normal_rng(mu[i],sigma);
  }
}
