data {
  int N;
}

generated quantities {
  real<lower=0,upper=1>theta=uniform_rng(0,1);
  int<lower=0>S_sim=binomial_rng(N,theta);
}
