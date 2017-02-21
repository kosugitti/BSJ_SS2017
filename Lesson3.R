#########################################
#
# 行動計量学会第19回春の合宿セミナー
#　　サンプルスクリプト
#      Lesson 3 考え方の準備
#
#　　(c) Koij Kosugi(@kosugitti)
#
#########################################

# 正規分布を描く
library(ggplot2)
g <- ggplot(data=data.frame(X=c(-4,4)), aes(x=X))
g <- g + stat_function(fun=dnorm, args=list(mean=0, sd=1),color=1)
g <- g + stat_function(fun=dnorm, args=list(mean=0, sd=2),color=2)
g <- g + stat_function(fun=dnorm, args=list(mean=-1, sd=1),color=3)
g <- g + stat_function(fun=dnorm, args=list(mean=1, sd=0.7),color=4)
g

set.seed(12345)
N <-  1000
x <- rnorm(N,170,10)
g <- ggplot(data=data.frame(x),aes(x))
g <- g + geom_histogram(aes(y=..density..),alpha=0.5,binwidth=1)
g

# finding mu
g <- g + stat_function(fun=dnorm, args=list(mean=159, sd=10),color=1)
g <- g + stat_function(fun=dnorm, args=list(mean=163, sd=10),color=2)
g <- g + stat_function(fun=dnorm, args=list(mean=172, sd=10),color=3)
g <- g + stat_function(fun=dnorm, args=list(mean=179, sd=10),color=4)
g

mean(x)
sd(x)

# likelihood
g <- ggplot(data=data.frame(X=c(150,200)), aes(x=X))
g <- g + stat_function(fun=dnorm, args=list(mean=190, sd=10),color=4)
g <- g + stat_function(fun=dnorm, args=list(mean=170, sd=10),color=2)
g

dnorm(165,170,10)*dnorm(173,170,10)*dnorm(182,170,10)
dnorm(165,190,10)*dnorm(173,190,10)*dnorm(182,190,10)



## 公式サンプル8schoolを実行してみよう
library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
schools_dat <- list(J = 8, 
                    y = c(28,  8, -3,  7, -1,  1, 18, 12),
                    sigma = c(15, 10, 16, 11,  9, 11, 10, 18))
fit <- stan(file = '8schools.stan', data = schools_dat, 
            iter = 1000, chains = 4)
print(fit)

print(fit,pars="mu")
stan_trace(fit,pars="mu")
stan_hist(fit,pars="mu")

# 事後分布のサンプルを考える
sampled.mu <- extract(fit,pars="mu")$mu
summary(sampled.mu)
quantile(sampled.mu,probs=c(0,0.25,0.5,0.75,1))
# ある確率が生じる臨界値
quantile(sampled.mu,probs=c(0.48))
# ある値より大きい確率
length(sampled.mu[sampled.mu>10])/length(sampled.mu)*100

