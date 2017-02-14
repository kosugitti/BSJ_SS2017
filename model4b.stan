data{
  int<lower=0> N1;
  int<lower=0> N2;
  real X1[N1];
  real X2[N2];
}

parameters{
  real muA;
  real muB;
  real<lower=0> sig;
}

model{
  X1 ~ normal(muA,sig);
  X2 ~ normal(muB,sig);
}

