data {
  int K; // number of categories
  int N; // total votes
}
generated quantities {
  simplex[K] theta = dirichlet_rng(rep_vector(1, K));
  int y_ppc[K] = multinomial_rng(theta,N);
}
