data{
  int<lower=0> L;
  real X[L];
  int<lower=0> Y[L];
}

parameters{
  real beta;
}


model{
  for(l in 1:L){
    Y[l] ~ bernoulli_logit(X[l]*beta);
  }
}
