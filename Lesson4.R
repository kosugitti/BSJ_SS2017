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
baseball <- read.csv("baseball2016.csv",fileEncoding = "utf-8")
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



