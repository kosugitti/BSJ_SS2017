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
  // Prior
  mu ~ normal(180,20);
}

