data {
  int<lower=0> n;              # データ総数
  vector[n] W;                  # 体重データ
  int<lower=0> Nmiss;          # 欠損値の数
}
parameters {
  real muZero;            # 左端
  vector[n] mu;           # 確率的レベル
  vector<lower=0>[Nmiss] Miss_W;
  real<lower=0> sdV;   # 観測誤差の大きさ
  real<lower=0> sdW;   # 過程誤差の大きさ
}
model {
  # 状態方程式の部分
  # 左端から初年度の状態を推定する
  mu[1] ~ normal(muZero, sdV);  

  # 観測方程式の部分
  {
    int nmiss;
    nmiss = 0;
    for(i in 1:n) {
      if(W[i]!=9999){
        W[i] ~ normal(mu[i], sdV);
      }else{
        nmiss = nmiss+1;
        Miss_W[nmiss] ~ normal(mu[i],sdV);
      }
    }
  }

  # 状態の遷移
  for(i in 2:n){
    mu[i] ~ normal(mu[i-1], sdW);
  }
  sdV ~ cauchy(0,5);
  sdW ~ cauchy(0,5);
}
