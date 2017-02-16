data{
  int<lower=0> N1;
  int<lower=0> N2;
  int<lower=0> N3;
  real<lower=0> Y1[N1];
  real<lower=0> Y2[N2];
  real<lower=0> Y3[N3];
  real<lower=0> ko[N3];
}

parameters{
  real mu;
  real<lower=0> sig1;
  real<lower=0> sig2;
  real<lower=0> sig3;
  real gum;
  real pai;
}

model{
  for(i in 1:N1){
    Y1[i] ~ normal(mu,sig1);
  }
  for(i in 1:N2){
    Y2[i] ~ normal(mu+gum,sig2);
  }
  for(i in 1:N3){
    Y3[i] ~ normal(mu+(pai*ko[i]),sig3);
  }
}

generated quantities{
  real predY1[N1];
  real predY2[N2];
  real predY3[N3];
  
  for(i in 1:N1){
    predY1[i] = normal_rng(mu,sig1);
  }
  for(i in 1:N2){
    predY2[i] = normal_rng(mu+gum,sig1);
  }
  for(i in 1:N3){
    predY3[i] = normal_rng(mu+(pai*ko[i]),sig1);
  }
}
