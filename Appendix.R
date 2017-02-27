#########################################
#
# 行動計量学会第19回春の合宿セミナー
#　　サンプルスクリプト
#      一般化線形モデルの例
#
#　　(c) Koij Kosugi(@kosugitti)
#
#########################################
#
library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
set.seed(12345)
# 二値データに対するモデリング
# ベルヌーイ分布回帰(ロジスティック回帰)
N <- 100
beta <- 0.5
# 独立変数は一様乱数から適当に決める
X <- runif(N,0,10)
# 理論的予測値
Yhat <- 1/(1+exp(-1*(X*beta)))
# 実際には誤差があるので
Y <- rbinom(N,1,Yhat)
# データにまとめる
dat <- data.frame(X=X,Y=Y)
modelA1 <- stan_model("appendix1.stan",model_name="GLM;Bernoulli")
datastan <- list(L=nrow(dat),X=dat$X,Y=dat$Y)
fitA1 <- sampling(modelA1,datastan)
print(fitA1)

modelA2 <- stan_model("appendix2.stan",model_name="GLM;Bernoulli")
datastan <- list(L=nrow(dat),X=dat$X,Y=dat$Y)
fitA2 <- sampling(modelA2,datastan)
print(fitA2)

# セリーグとパリーグの違いを年俸から予測する
baseball <- read.csv("baseball.csv",fileEncoding="UTF8")
Central <- c("巨人","阪神","広島","ヤクルト","中日","DeNA")
baseball$CP <- ifelse(is.na(match(baseball$team,Central)),2,1)
datastan <- list(L=nrow(baseball),X=baseball$pay/1000,Y=as.numeric(baseball$CP)-1)
fitA2b <- sampling(modelA2,datastan)
print(fitA2b)


# カウントデータに対するモデリング
N <- 100
beta <- 0.5
# 独立変数は一様乱数から適当に決める
X <- runif(N,1,10)
# 理論的予測値
Yhat <- exp(X*beta)
# 実際には誤差があるので
Y <- rpois(N,Yhat)
# データにまとめる
dat <- data.frame(X=X,Y=Y)
modelA3 <- stan_model("appendix3.stan",model_name="GLM;Poisson")
datastan <- list(L=nrow(dat),X=dat$X,Y=dat$Y)
fitA3 <- sampling(modelA3,datastan)
print(fitA3,pars="beta")

modelA4 <- stan_model("appendix4.stan",model_name="GLM;Poisson")
datastan <- list(L=nrow(dat),X=dat$X,Y=dat$Y)
fitA4 <- sampling(modelA4,datastan)
fitA4
# 実データでやってみる
# Stanで推定
baseball <- read.csv("baseball.csv",fileEncoding="UTF8")
datastan <- list(L=nrow(baseball),X=baseball$pay/1000,Y=baseball$HR)
fitA4b <- sampling(modelA4,datastan)
fitA4b
