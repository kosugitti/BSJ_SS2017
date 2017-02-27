#########################################
#
# 行動計量学会第19回春の合宿セミナー
#　　サンプルスクリプト
#      Lesson 5 ベイジアンモデラーへの道
#
#　　(c) Koij Kosugi(@kosugitti)
#
#########################################
set.seed(12345)
# 多変量正規分布をつかって対応のある2群を考える
# 乱数に使う基本的な設定
library(MASS)
mu <- c(10,20)
sig1 <- 5
sig2 <- 5
rho <- 0.3
Sigmatrix <- matrix(nrow=2,ncol=2)
Sigmatrix[1,1] <- sig1^2
Sigmatrix[2,2] <- sig2^2
Sigmatrix[1,2] <- sig1 * sig2 * rho
Sigmatrix[2,1] <- sig1 * sig2 * rho
# 乱数を生成
N <- 100
X <- mvrnorm(N,mu,Sigmatrix,empirical = TRUE)
cor(X)
# Stanで推定
library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
datastan <- list(N=N,X=X)
model5 <- stan_model("model5.stan",model_name="paired T")
fit <- sampling(model5,datastan)
fit

# 間(2)間(2)のANOVA
N <- 10
mu <- 50
effectA <- 5
effectB <- 8
effectAB <- 0
error <- 3
a1b1 <- mu + effectA + effectB + effectAB
a1b2 <- mu + effectA - effectB - effectAB
a2b1 <- mu - effectA + effectB - effectAB
a2b2 <- mu - effectA - effectB + effectAB
dataA1B1 <- rnorm(N,a1b1,error)
dataA1B2 <- rnorm(N,a1b2,error)
dataA2B1 <- rnorm(N,a2b1,error)
dataA2B2 <- rnorm(N,a2b2,error)
# anovaで確かめてみる
value <- c(dataA1B1,dataA1B2,dataA2B1,dataA2B2)
designA <- c(rep(0,N),rep(0,N),rep(1,N),rep(1,N))
designB <- c(rep(0,N),rep(1,N),rep(0,N),rep(1,N))
dataset <- data.frame(designA,designB,value)
summary(aov(value~designA*designB,data=dataset))
# Bayesian Modeling
model6 <- stan_model("model6.stan",model_name="Between ANOVA")
datastan <- list(N=N,A1B1=dataA1B1,A1B2=dataA1B2,A2B1=dataA2B1,A2B2=dataA2B2)
fit6 <- sampling(model6,datastan)
fit6


model6b <- stan_model("model6b.stan",model_name="Between ANOVA 2")
fit6b <- sampling(model6b,datastan)
fit6b


##  パイの実力
dat <- read.csv("Kraepelin2.csv",fileEncoding = "UTF-8")
summary(dat)
library(ggplot2)
g <- ggplot(dat,aes(x=total,group=group,fill=group))+geom_density(alpha=0.7)
g

# データの分割
CTRL <- subset(dat,dat$group=="Control")
GUM <- subset(dat,dat$group=="Gum")
PAI <- subset(dat,dat$group=="Pai")

model7 <- stan_model("model7.stan",model_name="Power of PAI")
datastan <- list(N1=nrow(CTRL),N2=nrow(GUM),N3=nrow(PAI),Y1=CTRL$total,Y2=GUM$total,Y3=PAI$total,ko=PAI$pai)
fit7 <- sampling(model7,datastan)
print(fit7,pars=c("mu","sig1","sig2","sig3","gum","pai"))

# shinystan
library(shinystan)
launch_shinystan(fit7)

### パイの実回帰分析
model7b <- stan_model("model7b.stan",model_name="Power of PAI / only PAI group")
datastan <- list(N3=nrow(PAI),Y3=PAI$total,ko=PAI$pai)
fit7b <- sampling(model7b,datastan,iter=10000,thin=2)
print(fit7b)

summary(lm(total~pai,data=PAI))


