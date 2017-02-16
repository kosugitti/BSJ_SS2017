data{
  int<lower=0> N;
  int X1[N];
  int X2[N];
}

parameters{
  real theta[N];
  real effect;
}

model{
  for(i in 1:N){
    X1[i] ~ bernoulli_logit(theta[i]);
    X2[i] ~ bernoulli_logit(theta[i]+effect);
  }
  theta ~ normal(0,1);
  effect ~ uniform(0,1);
}
