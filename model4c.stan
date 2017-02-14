data{
  int<lower=0> N1;
  int<lower=0> N2;
  real X1[N1];
  real X2[N2];
}

parameters{
  real muA;
  real muB;
  real<lower=0> sigA;
  real<lower=0> sigB;
}

model{
  X1 ~ normal(muA,sigA);
  X2 ~ normal(muB,sigB);
}

