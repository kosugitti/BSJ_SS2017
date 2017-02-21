#########################################
#
# 行動計量学会第19回春の合宿セミナー
#　　サンプルスクリプト
#      Lesson 7 より発展的なモデリング（後編）
#
#　　(c) Koij Kosugi(@kosugitti)
#
#########################################
library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
set.seed(12345)
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


#### 欠損値の推定
# 相関係数の場合
library(MASS)
N <- 2000
mu <- c(50,60)
sd <- c(10,10)
rho <- 0.7
Sig <- matrix(nrow=2,ncol=2)
Sig[1,1] <- sd[1]*sd[1]
Sig[1,2] <- sd[1]*sd[2]*rho
Sig[2,1] <- sd[2]*sd[1]*rho
Sig[2,2] <- sd[2]*sd[2]
X <- mvrnorm(N,mu,Sig,empirical=T)
dat <- data.frame(X)
dat$FLG <- factor(ifelse(dat$X1>40,1,2),labels=c("pass","fail"))
# 描画
library(ggplot2)
g <- ggplot(dat,aes(x=X1,y=X2,group=FLG,color=FLG)) + geom_point()
g
# 相関係数の算出
cor(X)
cor(X[X[,1]>40,])
# 欠損値を作る
X[,2] <- ifelse(X[,1]<=40,NA,X[,2])

# 欠損値のあるデータとそうでないデータに分ける
completeX <- subset(X,X[,1]>40)
missingX <- subset(X[,1],X[,1]<=40)
datastan <- list(Nobs=nrow(completeX),Nmiss=length(missingX),
                 obsX=completeX,missX=missingX)
model11 <- stan_model("model11.stan",model_name="Missing Corr")
fit11 <- sampling(model11,datastan)
print(fit11,pars=c("mu","sd1","sd2","rho"))


## 回帰分析モデルがある場合
N <- 1000
X <- round(runif(N,1,100))
Yhat <- 0.8 * X + 10
sig <- 10
Y <- rnorm(N,Yhat,sig)
# 最初の20個を欠損値にする
Y[1:20] <- NA
# 欠損値の数を数える
Nmiss <- sum(is.na(Y))
# 欠損値を「あり得ない数字」にする
Y <- ifelse(is.na(Y),9999,Y)


model12 <- stan_model("model12.stan",model_name="regression with missing")
datastan <- list(N=N,Nmiss=Nmiss,X=X,Y=Y)
fit12 <- sampling(model12,datastan)
fit12


#############状態空間モデル
dat <- read.csv("weight.csv",fileEncoding = "UTF-8")
dat.comp <- na.omit(dat)
datastan <- list(n=nrow(dat.comp),W=dat.comp$weight)

model13 <- stan_model("model13.stan",model_name="state space modeling")
fit13 <- sampling(model13,data=datastan)
fit13


###########  欠損値対応&未来予測
#データの体重部分
W <- dat$weight 
#欠測値の数を数えます
Nmiss <- sum(is.na(W))
# 予測したい日数
predN <- 10
Nmiss <- Nmiss + predN　
#データがもし欠損であれば9999という数字を入れます
W <- ifelse(is.na(W),9999,W)　
predW <- rep(9999,predN)
W <- c(W,predW)
W
model7.missing <- stan_model("model13b.stan",model_name="Missing and Predict")
datastan <- list(n=length(W),W=W,Nmiss=Nmiss)
fit13b <- sampling(model7.missing,data=datastan)
print(fit13b,pars=c("sdV","sdW"))
print(fit13b,pars=c("mu"))
print(fit13b,pars=c("Miss_W"))
