data {
  int S; //number of successes
  int N; //number of trials
}

parameters {
  real <lower=0,upper=1> theta;
}

model {
  theta ~ normal(0.5,0.15);
  S ~ binomial(N,theta);
}
generated quantities {
  int S_sim=0;
  S_sim = binomial_rng(N,theta);
}
