data{
  int<lower=0> N3;
  real<lower=0> Y3[N3];
  real<lower=0> ko[N3];
}

parameters{
  real mu;
  real<lower=0> sig3;
  real pai;
}

model{
  for(i in 1:N3){
    Y3[i] ~ normal(mu+(pai*ko[i]),sig3);
  }
}
