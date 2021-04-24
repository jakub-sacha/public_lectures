data {
  int pop; //population
}

generated quantities {
real theta = gamma_rng(20,430000);
int y = poisson_rng(10*theta*pop);
}
