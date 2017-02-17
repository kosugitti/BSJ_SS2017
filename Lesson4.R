#########################################
#
# 行動計量学会第19回春の合宿セミナー
#　　サンプルスクリプト
#      Lesson 4 ベイジアンモデリングの実際
#
#　　(c) Koij Kosugi(@kosugitti)
#
#########################################

# ひとつのデータの例
set.seed(12345)
N <- 100
mu <- 170
sig <- 10
Y <- rnorm(N,mu,sig)
mean(Y)
sd(Y)

library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
model1 <-  stan_model("model1.stan",model_name="single Norm")
datastan <- list(N=N,Y=Y)
fit1 <- sampling(model1,data=datastan,iter=3000,warmup=1000,chains=2)
print(fit1)
stan_hist(fit1,pars="mu",bins=50)
stan_hist(fit1,pars="sig")

# データを増やしてみる
N <- 1000
mu <- 170
sig <- 10
Y <- rnorm(N,mu,sig)
mean(Y)
sd(Y)
datastan <- list(N=N,Y=Y)
fit1.2 <- sampling(model1,data=datastan,iter=3000,warmup=1000,chains=2)
print(fit1.2)

# 実際のデータでやってみる
baseball <- read.csv("baseball.csv",fileEncoding = "utf-8")
datastan <- list(N=nrow(baseball),Y=baseball$height)
fit1.3 <- sampling(model1,data=datastan)
print(fit1.3)


# 事前分布の指定
datastan <- list(N=nrow(baseball),Y=baseball$height)
model2 <-  stan_model("model2.stan",model_name="single Norm with Prior")
fit2 <- sampling(model2,data=datastan)
print(fit2)

# 事後予測分布の生成
datastan <- list(N=nrow(baseball),Y=baseball$height)
model3 <-  stan_model("model3.stan",model_name="single Norm and PPD")
fit3 <- sampling(model3,data=datastan)
# モデルから生成されたデータを抜き出す
predY <- extract(fit3,pars="predY")$predY

# 描画
library(ggplot2)
# 実データと抜きだした生成データを結合
value <-  c(baseball$height,predY)
# 実データと生成データを区別する変数を作る
ID <- c(rep(1,length(baseball$height)),rep(2,length(predY)))
# あわせてデータフレームに
plotData <- data.frame(cbind(ID,value))
# 識別変数をfactor型に
plotData$ID <- factor(plotData$ID,labels=c("observed","predicted"))
# plot
g <- ggplot(data=plotData,aes(x=value,group=ID,fill=ID))
g <- g + geom_density(alpha=0.5,position="identity")
g


# WAICの計算
datastan <- list(N=nrow(baseball),Y=baseball$height)
model3b <-  stan_model("model3b.stan",model_name="single Norm and PPD/Log_lik")
fit3 <- sampling(model3b,data=datastan)
# モデルから生成されたデータを抜き出す
logLik <- extract(fit3,pars="log_lik")$log_lik
# looパッケージで計算してもらう
library(loo)
waic(logLik)
loo(logLik)

########################### 二群の平均値の差を比べる

# 仮想データ
N <- 100
muA <- 20
muB <- 30
sigA <- 10
sigB <- 20
X1 <- rnorm(N,muA,sigA)
X2 <- rnorm(N,muB,sigB)
t.test(X1,X2)

model4 <- stan_model("model4.stan",model_name="Two groups")
datastan <- list(N=N,X1=X1,X2=X2)
fit4 <- sampling(model4,datastan)
print(fit4)

# サンプルサイズの違いに対応
# 等分散モデル
N1 <- 100
N2 <- 200
muA <- 20
muB <- 30
sig <- 10
X1 <- rnorm(N1,muA,sig)
X2 <- rnorm(N2,muB,sig)
t.test(X1,X2)
model4b <- stan_model("model4b.stan",model_name="Two groups model2")
datastan <- list(N1=N1,N2=N2,X1=X1,X2=X2)
fit4b <- sampling(model4b,datastan)
print(fit4b)

# 実際のデータでやってみる
baseball <- read.csv("baseball.csv",fileEncoding = "utf-8")
# セ・パを判別する
Central <- c("巨人","阪神","広島","ヤクルト","中日","DeNA")
# match関数で判断させる
baseball$CP <- ifelse(is.na(match(baseball$team,Central)),2,1)
# セリーグのデータ
X1 <- baseball$height[baseball$CP==1]
X2 <- baseball$height[baseball$CP==2]
t.test(X1,X2)

model4c <- stan_model("model4c.stan",model_name="Two groups unbalanced data")
datastan <- list(N1=length(X1),N2=length(X2),X1=X1,X2=X2)
fit4c <- sampling(model4c,datastan)
print(fit4c)

# 積極的な仮説検証
model4d <- stan_model("model4d.stan",model_name="Over the NHST")
datastan <- list(N1=length(X1),N2=length(X2),X1=X1,X2=X2)
fit4d <- sampling(model4d,datastan)
print(fit4d)
stan_plot(fit4d,pars="diff")
