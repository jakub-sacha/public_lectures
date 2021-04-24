
data {
  int N;
}

generated quantities {
  real<lower=0,upper=1>theta=fabs(fmin(1,normal_rng(0.5,0.15)));
  int<lower=0>S_sim=binomial_rng(N,theta);
}
