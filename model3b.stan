data{
  int<lower=0> N;
  real Y[N];
}

parameters{
  real mu;
  real<lower=0> sig;
}

model{
  // Likelihood(model)
  for(i in 1:N){
    Y[i] ~ normal(mu,sig);
  }
}

generated quantities{
  real predY;
  real log_lik[N];
  predY = normal_rng(mu,sig);

  for(i in 1:N){
    log_lik[i] = normal_lpdf(Y[i] | mu,sig);
  }
}
