#########################################
#
# 行動計量学会第19回春の合宿セミナー
#　　サンプルスクリプト
#      階層線形モデルの最尤推定
#
#　　(c) Koij Kosugi(@kosugitti)
#
#########################################
#
set.seed(12345)

# 切片がチームごとに違うモデル
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

### 最尤法による答えの出し方
library(lmerTest)
result.HLM <- lmer(Y~X+(1|team),data=dat)
summary(result.HLM)



### 切片だけでなく傾きも異なるモデル
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

result.HLM2 <- lmer(Y~X+(1+X|team),data=dat)
summary(result.HLM2)

### ベイズ推定パッケージ
library(rstanarm)
options(mc.cores = parallel::detectCores())
# 使用例；切片が異なるモデル
result.HLM.bayes <- stan_lmer(Y~X+(1|team),data=dat)
