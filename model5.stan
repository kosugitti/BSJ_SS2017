data{
  int<lower=0> N;
  vector[2] X[N];
}

parameters{
  vector[2] mu;
  vector<lower=0>[2] sig;
  real<lower=-1,upper=1> rho;
}

transformed parameters{
  matrix[2,2] Sigma;
  Sigma[1,1] = sig[1] * sig[1];
  Sigma[2,2] = sig[2] * sig[2];
  Sigma[1,2] = sig[1] * sig[2] * rho;
  Sigma[2,1] = sig[2] * sig[1] * rho;
}

model{
  for(i in 1:N){
    X[i] ~ multi_normal(mu,Sigma);
  }
}

generated quantities{
  real diff;
  diff = mu[1] - mu[2];
}
