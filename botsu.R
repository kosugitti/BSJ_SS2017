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
# 仮想データの後半分に対して，無情報事前分布で推定
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
