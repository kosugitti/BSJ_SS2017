data{
  int<lower=0> N;
  real X1[N];
  real X2[N];
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

