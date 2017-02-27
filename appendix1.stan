data{
  int<lower=0> L;
  real X[L];
  int<lower=0> Y[L];
}

parameters{
  real beta;
}

transformed parameters{
  real<lower=0> theta[L];
  for(l in 1:L){
    theta[l] = inv_logit(X[l]*beta);
  }
}

model{
  for(l in 1:L){
    Y[l] ~ bernoulli(theta[l]);
  }
}
