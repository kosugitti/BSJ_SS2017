data{
  int<lower=0> N;
  int X1[N];
  int X2[N];
}

parameters{
  real theta[N];
  real<lower=0> effect;
}

transformed parameters{
  real<lower=0,upper=1> thetaPre[N];
  real<lower=0,upper=1> thetaPost[N];
  for(i in 1:N){
    thetaPre[i] = 1/(1+exp(-theta[i]));
    thetaPost[i] = 1/(1+exp(-(theta[i]+effect)));
  }
}

model{
  for(i in 1:N){
    X1[i] ~ bernoulli(thetaPre[i]);
    X2[i] ~ bernoulli(thetaPost[i]);
  }
  theta ~ normal(0,1);
  effect ~ uniform(0,1);
}
