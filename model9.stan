data{
  int<lower=0> N1;
  int<lower=0> N2;
  int<lower=0> N3;
  real<lower=0> P1[N1,30];
  real<lower=0> P2[N2,30];
  real<lower=0> P3[N3,30];
  int<lower=0> ko[N3]; // 
}
parameters{
  real theta_mu;
  real<lower=0> theta_sd;
  real gum;
  real pai;
  real performance1[N1];
  real performance2[N2];
  real performance3[N3];
  real<lower=0> sig;
}
transformed parameters{
}
model{
    // First period. 1-15 cols
  for(j in 1:15){
    for(i in 1:N1){
      P1[i,j]~normal(performance1[i],sig);
    }
    for(i in 1:N2){
      P2[i,j]~normal(performance2[i],sig);
    }
    for(i in 1:N3){
      P3[i,j]~normal(performance3[i],sig);
    }
  }

    // Second period after 5 mins rest. 16-30 cols   
  for(j in 16:30){
    for(i in 1:N1){
      P1[i,j]~normal(performance1[i],sig);
    }
    for(i in 1:N2){
      P2[i,j]~normal(performance2[i]+gum,sig);
    }
    for(i in 1:N3){
      P3[i,j]~normal(performance3[i]+(pai*ko[i]),sig);
    }
  }

  performance1~normal(theta_mu,theta_sd);
  performance2~normal(theta_mu,theta_sd);
  performance3~normal(theta_mu,theta_sd);
  sig~cauchy(0,5);
  theta_sd ~ cauchy(0,5);
}

