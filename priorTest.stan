data{
  int<lower=0> N;
  real Y[N];
  real prior_mu;
  real<lower=0> prior_mu_sd;
  real<lower=0> prior_sd_mean;
  real<lower=0> prior_sd_sd;
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
  // Prior
  mu ~ normal(prior_mu,prior_mu_sd);
  sig ~ normal(prior_sd_mean,prior_sd_sd);
}

