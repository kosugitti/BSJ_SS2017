data {
  int n;              # サンプルサイズ
  vector[n] W;        # 体重データ
}
parameters {
  real muZero;         # 左端
  vector[n] mu;        # 確率的レベル
  real<lower=0> sdV;   # 観測誤差の大きさ
  real<lower=0> sdW;   # 過程誤差の大きさ
}
model {
  # 状態方程式の部分
  # 左端から初年度の状態を推定する
  mu[1] ~ normal(muZero, sdV);  

  # 観測方程式の部分
  for(i in 1:n) {
    W[i] ~ normal(mu[i], sdV);
  }

  # 状態の遷移
  for(i in 2:n){
    mu[i] ~ normal(mu[i-1], sdW);
  }
  sdV ~ cauchy(0,5);
  sdW ~ cauchy(0,5);
}

