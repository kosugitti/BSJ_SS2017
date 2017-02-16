data{
  int<lower=0> K;
  int<lower=0> L;
  int<lower=0> teamID[L];
  real X[L];
  real Y[L];
}

parameters{
  real base[K];
  real beta;
  real<lower=0> sig;
}

model{
  for(l in 1:L){
    Y[l] ~ normal( X[l]*beta + base[teamID[l]] , sig);
  }
}
