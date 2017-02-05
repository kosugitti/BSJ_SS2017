#########################################
#
# 行動計量学会第19回春の合宿セミナー
#　　サンプルスクリプト
#
#　　(c) Koij Kosugi(@kosugitti)
#
# 練習問題2　回答例
#
#  できていれば必ずしもこのやり方である必要はありません。
#  あくまでも回答「例」です。
#
#########################################
set.seed(12345)
N <- 100
male.height <- rnorm(N,170,5)
female.height <- rnorm(N,150,3)
male.weight <- rnorm(N,80,5)
female.weight <- rnorm(N,50,2)

height <- c(male.height,female.height)
weight <- c(male.weight,female.weight)

dat <- data.frame(cbind(height,weight))
dat$gender <- c(rep(1,N),rep(2,N))
dat$gender <- factor(dat$gender,label=c("male","female"))

# データの特徴の記述
summary(dat)

# 男性ごと，女性ごとの特徴の記述
summary(dat[dat$gender=="male",])
summary(dat[dat$gender=="female",])

# psychパッケージを使うと群ごとの記述も簡単
library(psych)
psych::describeBy(dat,group=dat$gender)

# dplyrパッケージを使ってグルーピングする方法もよく知られています
library(dplyr)
dat.group <- dplyr::group_by(dat,gender)
dplyr::summarise_all(dat.group,mean)


# データの描画
library(ggplot2)
g <- ggplot(dat,aes(x=height,y=weight,color=gender,fill=gender))
g + geom_point()

g <- ggplot(dat,aes(x=height,group=gender,fill=gender))
g + geom_histogram(binwidth=0.5,alpha=0.7)+facet_wrap(~gender)



# 身長と体重の相関係数が0.8ぐらいある場合
# 多変量正規分布に従う乱数を発生させる必要がある
# MASSパッケージのmvrnorm関数を使う
# 詳しくはこの後の講釈で
library(MASS)
N <- 100
male.mu <- c(170,80)
sd.vec <- c(5,3)
cor <- 0.8
Sigma <- sd.vec %*% t(sd.vec)*cor
diag(Sigma) <- sd.vec^2
male <- mvrnorm(N,male.mu,Sigma)
cor(male)
