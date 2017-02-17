data{
  int<lower=0> N;
  int<lower=0> Nmiss;
  real X[N];
  real Y[N];
}

parameters{
  real beta0;
  real beta1;
  real<lower=0> sig;
  real missY[Nmiss];
}

model{
  {
    int count;
    count = 0;
    for(i in 1:N){
      if(Y[i]!=9999){
        Y[i] ~ normal(beta0 + beta1 * X[i],sig);
      }else{
        count = count +1;
        missY[count] ~ normal(beta0 + beta1 * X[i],sig);
      }
    }
  }
}
