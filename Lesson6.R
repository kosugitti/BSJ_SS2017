#########################################
#
# 行動計量学会第19回春の合宿セミナー
#　　サンプルスクリプト
#      Lesson 6 より発展的なモデリング（前編）
#
#　　(c) Koij Kosugi(@kosugitti)
#
#########################################
set.seed(12345)

# 階層線形モデルの仮想データ
# チームの数
K <- 6
# 各チームから選出される人は20名
N <- 20
# チームの平均年俸(万円)
base <- c(500,600,700,800,900,1000)
# ヒット一本で上がる年俸
b1 <- 5
# ヒットの本数は1-210本の間で適当に決まるとする
X <- round(runif(N*K,1,210))
# 理論的予測値
Yhat <- X*b1 + rep(base,each=N)
# 実際には誤差があるので
Y <- rnorm(N*K,mean=Yhat,sd=10)
# データにまとめる
dat <- data.frame(team=rep(1:K,each=N),X=X,Y=Y)

# Stanで推定
library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
model8 <- stan_model("model8.stan",model_name="HLM model 1")
datastan <- list(K=K,L=nrow(dat),teamID=dat$team,X=dat$X,Y=dat$Y)
fit8 <- sampling(model8,datastan)
fit8

### 
# チームの平均年俸が分布する
base0 <- 1000
baseSig <- 200
base <- rnorm(K,base0,baseSig)
# ヒット一本で上がる年俸
b1 <- 5
# ヒットの本数は1-210本の間で適当に決まるとする
X <- round(runif(N*K,1,210))
# 理論的予測値
Yhat <- X*b1 + rep(base,each=N)
# 実際には誤差があるので
Y <- rnorm(N*K,mean=Yhat,sd=10)
# データにまとめる
dat <- data.frame(team=rep(1:K,each=N),X=X,Y=Y)


# Stanで推定
model8b <- stan_model("model8b.stan",model_name="HLM model 2")
datastan <- list(K=K,L=nrow(dat),teamID=dat$team,X=dat$X,Y=dat$Y)
fit8b <- sampling(model8b,datastan,iter=5000,thin=2)
fit8b




### 
# チームの平均年俸が分布する
base0 <- 1000
baseSig <- 200
base <- rnorm(K,base0,baseSig)
# ヒット一本で上がる年俸の傾きも分布する
beta0 <- 5
betaSig <- 10
beta <- rnorm(K,beta0,betaSig)
# ヒットの本数は1-210本の間で適当に決まるとする
X <- round(runif(N*K,1,210))
# 理論的予測値
Yhat <- X*rep(beta,each=N) + rep(base,each=N)
# 実際には誤差があるので
Y <- rnorm(N*K,mean=Yhat,sd=10)
# データにまとめる
dat <- data.frame(team=rep(1:K,each=N),X=X,Y=Y)

# Stanで推定
model8c <- stan_model("model8c.stan",model_name="HLM model 3")
datastan <- list(K=K,L=nrow(dat),teamID=dat$team,X=dat$X,Y=dat$Y)
fit8c <- sampling(model8c,datastan,iter=5000,thin=2)
fit8c


# Stanで推定
model8d <- stan_model("model8d.stan",model_name="HLM model 3 with Prior")
fit8d <- sampling(model8d,datastan,iter=5000,thin=2)
fit8d

# 実データでやってみる
baseball <- read.csv("baseball.csv",fileEncoding="UTF8")
# データの年収は1000万円単位にしている
datastan <- list(K=12,L=nrow(baseball),teamID=as.numeric(baseball$team),X=baseball$Hit,Y=baseball$pay/1000)
fit8d.ball <- sampling(model8d,datastan,iter=5000)
fit8d.ball


### 添え字ごとの階層
N1 <- 20
N2 <- 20
N3 <- 20
# 個人の能力（平均50,分散10）
theta1 <- rnorm(N1,50,10)
theta2 <- rnorm(N2,50,10)
theta3 <- rnorm(N3,50,10)
# 誤差分散の大きさ
sig <- 10
# ガムの力
gum <- 5
# パイの実の力
pai <- 3
# パイの実を食べる個数
ko <- round(runif(N3,1,10))
# 個々人の能力に応じて30回のトライアル
P1 <- matrix(nrow=N1,ncol=30)
P2 <- matrix(nrow=N2,ncol=30)
P3 <- matrix(nrow=N3,ncol=30)
# 前半15回
for(i in 1:N1){
  P1[i,1:15] <- rnorm(15,theta1[i],sig)
}
for(i in 1:N2){
  P2[i,1:15] <- rnorm(15,theta2[i],sig)
}
for(i in 1:N3){
  P3[i,1:15] <- rnorm(15,theta3[i],sig)
}
# 後半15回
for(i in 1:N1){
  P1[i,16:30] <- rnorm(15,theta1[i],sig)
}
for(i in 1:N2){
  P2[i,16:30] <- rnorm(15,theta2[i],sig)+gum
}
for(i in 1:N3){
  P3[i,16:30] <- rnorm(15,theta3[i],sig)+pai*ko[i]
}

# Stanで推定
model9 <- stan_model("model9.stan",model_name="OKASHI power")
datastan <- list(N1=N1,N2=N2,N3=N3,P1=P1,P2=P2,P3=P3,ko=ko)
fit9 <- sampling(model9,datastan,iter=5000)
print(fit9,pars=c("gum","pai","sig","theta_mu","theta_sd"))

# 実データでやってみる
dat <- read.csv("Kraepelin3.csv",fileEncoding = "UTF-8")
P1 <- subset(dat[4:33],dat$group=="Control")
P2 <- subset(dat[4:33],dat$group=="Gum")
P3 <- subset(dat[4:33],dat$group=="Pai")
ko <- dat[dat$group=="Pai",3]
datastan <- list(N1=nrow(P1),N2=nrow(P2),N3=nrow(P3),P1=as.matrix(P1),P2=as.matrix(P2),P3=as.matrix(P3),ko=ko)
fit9.pai <- sampling(model9,datastan,iter=5000)
print(fit9,pars=c("gum","pai","sig","theta_mu","theta_sd"))



### ロバストな回帰分析
N <- 1000
X <- runif(N,1,20)
Yhat <- 0.8 * X
sig <- 5
Y <- rnorm(N,Yhat,sig)
# 5こだけ外れ値を入れてみる
Y[1:5] <- Y[1:5] + 30
plot(X,Y)
datastan <- list(N=N,Y=Y,X=X)
# 普通の回帰分析
model10 <- stan_model("model10.stan",model_name="Normal Regression")
fit10 <- sampling(model10,datastan)
print(fit10,pars=c("beta0","beta1","sig"))
# studentのt分布を使う場合
model10a <- stan_model("model10a.stan",model_name="Robust Regression")
fit10a <- sampling(model10a,datastan)
print(fit10a,pars=c("beta0","beta1","sig","nu"))

# cauchy分布を使う場合
model10b <- stan_model("model10b.stan",model_name="Robust Regression 2")
fit10b <- sampling(model10b,datastan)
print(fit10b,pars=c("beta0","beta1","sig"))

library(loo)
log_lik <- extract(fit10,pars="log_lik")$log_lik
log_lik_t <- extract(fit10a,pars="log_lik")$log_lik
log_lik_cauchy <- extract(fit10b,pars="log_lik")$log_lik

waic(log_lik)
waic(log_lik_t)
waic(log_lik_cauchy)
