data{
  int<lower=0> Nobs;
  int<lower=0> Nmiss;
  vector[2] obsX[Nobs];
  real missX[Nmiss];
}

parameters{
  vector[2] mu;
  real<lower=0> sd1;
  real<lower=0> sd2;
  real<lower=0,upper=1> rho;
}

transformed parameters{
  cov_matrix[2] Sig;
  Sig[1,1] = sd1 * sd1;
  Sig[2,2] = sd2 * sd2;
  Sig[1,2] = sd1 * sd2 * rho;
  Sig[2,1] = sd2 * sd1 * rho;
}

model{
  obsX ~ multi_normal(mu,Sig);
  missX ~ normal(mu[1],sd1);
}

