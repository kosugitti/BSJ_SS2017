N <- 5000000
x <- rnorm(N,0,1)
x.df <- data.frame(val=x)
x.df$group <- factor(ifelse(x.df$val<1.96,1,2))

library(ggplot2)
g <- ggplot(data=x.df,aes(x=val,group=group,fill=group))
g <- g + geom_histogram(binwidth=0.05)
g



# 事前分布による先行データの活用
N <- 100
mu <- 170
sig <- 10
Y <- rnorm(N,mu,sig)
Ypre <- Y[1:(N/2)]
Ypost <- Y[(N/2)+1:(N/2)]
# Step.1
# データ全体に対して，無情報事前分布で推定
datastan <- list(N=N,Y=Y)
fit3_all <- sampling(model1,data=datastan)
# データ全体の結果
print(fit3_all)

# Step.2
# 仮想データの前半分に対して，無情報事前分布で推定
datastan <- list(N=length(Ypre),Y=Ypre)
fit3_pre <- sampling(model1,data=datastan)
# 前半分データの結果
print(fit3_pre)

# Step.3
# 仮想データの後半分に対して，無情報事前分布で推定n
datastan <- list(N=length(Ypost),Y=Ypost)
fit3_post_null <- sampling(model1,data=datastan)
print(fit3_post_null)

# Step.4
# 前半分データの平均値を推定値としてとりだす
estMu <- extract(fit3_pre,pars="mu")$mu
estSig <- extract(fit3_pre,pars="sig")$sig
# 平均値と標準偏差の平均値を事前分布情報として使うモデル
model3 <-  stan_model("priorTest.stan",model_name="single Norm with Prior2")
# 仮想データの後半分に対して，前半分データの推定値を事前分布として渡す
datastan <- list(N=length(Ypost),Y=Ypost,
                 prior_mu=mean(estMu),prior_mu_sd=sd(estMu),
                 prior_sd_mean=mean(estSig),prior_sd_sd=sd(estSig))
fit3_post <- sampling(model3,data=datastan)

print(fit3_all)
print(fit3_pre)
print(fit3_post_null)
print(fit3_post)
# 
# # クレペリンデータの整理
# dat <- read.csv("Kraepelin.csv",fileEncoding = "UTF-8")
# dat$age <- NULL
# dat$group <- factor(dat$group,labels=c("Control","Gum","Pai"))
# dat$gender <- factor(dat$gender,labels=c("Male","Female"))
# Order <- c("ID","group","gender","pai",paste0("tr",1:30),paste0("er",1:30))
# dat <- dat[Order]
# write.table(dat,"Kraepelin.csv",row.names=F)
# delVal <- c("ID","group","pai",paste0("tr",1:30))
# dat2 <- subset(dat,select=delVal)
# dat2$group <- factor(dat2$group,labels=c("Control","Gum","Pai"))
# write.csv(dat2,"Kraepelin3.csv",row.names = F)

## ボーリングデータの整理
# dat <- read.csv("bowling.csv",fileEncoding = "UTF-8",na.strings=".")
# dat$name <- NULL
# dat$G1ext <- NULL
# dat$G2ext <- NULL
# dat[10,"pond"] <- 11
# dat
# write.csv(dat,"bowling.csv",row.names=F)

# 回帰線の上に正規分布
library(purrr)
library(ggplot2)
g <- 1:5 %>%
  map(~ ggplot(data.frame(x = c(-10, 10)), aes(x)) +
        stat_function(fun = dnorm, args = list(mean = ., sd = sqrt(.)), colour = "red") +
        coord_flip() + theme_void() + lims(x = c(-10, 10), y = c(0, 1))) %>%
  map(ggplotGrob)

a <- map2(g,1:5, ~ annotation_custom(.x, xmin = .y, xmax = .y + 1, ymin = .y - 1, ymax = .y + 1))
ggplot(data.frame(x = c(0, 5)), aes(x)) + stat_function(fun = identity) + a


# 裾の長い分布
curve(dnorm(x,0,1),from=-8,to=-2,lty=1,lwd=2,col="blue")
curve(dcauchy(x,0,1),from=-8,to=-2,lwd=2,col="red",add=T)
curve(dt(x,1,1),from=-8,to=-2,lwd=2,col="green",add=T)

# ゼロ過剰ポアソンの図
x <- rep(0:20)
y <- dbinom(x,size=10,prob=0.5)
y[1] <- 0.8
y <- y/sum(y)
plot(x,y,type="b")

x <- rep(0:20)
y <- dbinom(x,size=10,prob=0.5)
plot(x,y,type="b")

hist(rbinom(100,1,0.2))

rm(list=ls())
# B-MDS
library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

# 1 dimensional Mixed Gauss
#  K個の正規分布を混ぜる

K <- 3
mean1 <- 5
mean2 <- -5
sd1 <- 5
sd2 <- 4.5

N1 <- 5000
N2 <- 3000
N <- N1+N2
X <-c(rnorm(N1,mean1,sd1),rnorm(N2,mean2,sd2))
dat <- data.frame(ID=c(rep(1,N1),rep(2,N2)),val=X)
dat$ID <- factor(dat$ID)
library(ggplot2)
g <- ggplot(dat,aes(x=val,group=ID,fill=ID))+geom_density(alpha=0.5,position="identity")
g
