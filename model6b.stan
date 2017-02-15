data{
  int<lower=0> N;
  real A1B1[N];
  real A1B2[N];
  real A2B1[N];
  real A2B2[N];
}

parameters{
  real muA1B1;
  real muA2B1;
  real muA1B2;
  real muA2B2;
  real<lower=0> sig;
}

model{
  A1B1 ~ normal(muA1B1,sig);
  A1B2 ~ normal(muA1B2,sig);
  A2B1 ~ normal(muA2B1,sig);
  A2B2 ~ normal(muA2B2,sig);
}

generated quantities{
  real gm;
  real effectA;
  real effectB;
  real effectAB;
  gm = (muA1B1 + muA1B2 + muA2B1 + muA2B2)/4;
  effectA = (muA1B1+muA1B2)/2 - gm;
  effectB = (muA1B1+muA2B1)/2 - gm;
  effectAB = (muA1B1+muA2B2)/2 - gm;
}
