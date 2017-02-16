data{
  int<lower=0> K;
  int<lower=0> L;
  int<lower=0> teamID[L];
  real X[L];
  real Y[L];
}

parameters{
  real base0;
  real<lower=0> baseSig;
  real base[K];
  real beta0;
  real<lower=0> betaSig;
  real beta[K];
  real<lower=0> sig;
}

model{
  for(k in 1:K){
    base[k] ~ normal(base0,baseSig);
    beta[k] ~ normal(beta0,betaSig);
  }
  
  for(l in 1:L){
    Y[l] ~ normal( X[l]*beta[teamID[l]] + base[teamID[l]] , sig);
  }
}
