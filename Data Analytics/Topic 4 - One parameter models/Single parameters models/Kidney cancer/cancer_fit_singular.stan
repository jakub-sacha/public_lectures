data {
  int y; //observed cases at  observation
  int pop; //population at  observation
}

parameters {
  real<lower=0> theta;//estimated death parameters
}
transformed parameters {
  real<lower=0> lambda=10*pop * theta;
}

model {
  theta ~ gamma(20,430000);
  y ~ poisson(lambda);
}

generated quantities {
  int y_sim=0;
  y_sim = poisson_rng(lambda);
}
