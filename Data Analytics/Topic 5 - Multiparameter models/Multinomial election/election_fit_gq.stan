data {
  int K; // number of categories
  int y[K]; //result of survey
}

parameters {
  simplex[K] theta;
}

model {
  y ~ multinomial(theta);
}
generated quantities {
  int y_sim[K];
  real advantage = theta[1]-theta[2];
  {
    int n;
    n = sum(y);
    y_sim = multinomial_rng(theta,n);
  }
}
