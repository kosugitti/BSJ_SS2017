# 正誤の回答率がpre postで変化する
N <- 1000
theta <- rnorm(N,0,1)
effect <- 0.1 # 回答者の偏差値が30上がるとする

# logit変換
theta.pre <- 1/(1+exp(-theta))
theta.post <- 1/(1+exp(-(theta + effect)))


X1 <- rbinom(N,1,theta.pre)
X2 <- rbinom(N,1,theta.post)

library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
model <- stan_model("ans1.stan")
datastan <- list(N=N,X1=X1,X2=X2)
fit <- sampling(model,datastan,iter=5000)
print(fit,pars="effect")
