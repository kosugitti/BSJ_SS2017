data{
  int<lower=0> N;
  real Y[N];
  real X[N];
}

parameters{
  real beta0;
  real<lower=0> sig;
  real beta1;
}

model{
  for(i in 1:N){
    Y[i] ~ cauchy(beta0+(beta1*X[i]),sig);
  }
  sig ~ student_t(4,0,5);
}

generated quantities{
  real log_lik[N];
  for(i in 1:N){
    log_lik[i] = cauchy_lpdf(Y[i]|beta0+(beta1*X[i]),sig);
  }
}

