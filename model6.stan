data{
  int<lower=0> N;
  real A1B1[N];
  real A1B2[N];
  real A2B1[N];
  real A2B2[N];
}

parameters{
  real mu;
  real effectA;
  real effectB;
  real effectAB;
  real<lower=0> sig;
}

transformed parameters{
  real ideal11;
  real ideal12;
  real ideal21;
  real ideal22;
  ideal11 = mu + effectA + effectB + effectAB;
  ideal12 = mu + effectA - effectB - effectAB;
  ideal21 = mu - effectA + effectB - effectAB;
  ideal22 = mu - effectA - effectB + effectAB;
}

model{
  for(i in 1:N){
    A1B1[i] ~ normal(ideal11,sig);
    A1B2[i] ~ normal(ideal12,sig);
    A2B1[i] ~ normal(ideal21,sig);
    A2B2[i] ~ normal(ideal22,sig);
  }
}

