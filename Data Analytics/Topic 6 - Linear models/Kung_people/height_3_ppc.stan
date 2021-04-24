data {
  int N;
  real weight[N];
}

generated quantities {
  real alpha = normal_rng(178,20);
  real beta_1 = lognormal_rng(0,1);
  real beta_2 = normal_rng(0,10);
  real sigma = exponential_rng(0.067);
  real height[N];
  for (i in 1:N) {
    height[i] = normal_rng(weight[i]*beta_1+weight[i]^2*beta_2+alpha,sigma);
  }

}
