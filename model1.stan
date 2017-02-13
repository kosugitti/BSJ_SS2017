data{
  int<lower=0> N;
  real y[N];
}
parameters{
  real mu;
  real<lower=0> sig;
}
model{
  // Likelihood(model)
  for(i in 1:N){
    y[i] ~ normal(mu,sig);
  }
  // Prior
  mu ~ uniform(-100,100);
  sig ~ uniform(0,100);  
}
