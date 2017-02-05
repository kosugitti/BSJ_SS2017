#########################################
#
# 行動計量学会第19回春の合宿セミナー
#　　サンプルスクリプト
#      インターミッション
#
#　　(c) Koij Kosugi(@kosugitti)
#
#########################################

# 同じ数字を反復して入力したい
#
# ex)実験条件1が5ケース，実験条件2が5ケース
condition <- c(1,1,1,1,1,2,2,2,2,2)
# 同じことをrep関数で
condition <- c(rep(1,5),rep(2,5))
# 繰り返す数字をベクトル与える
condition <- rep(1:2,each=5)
# eachオプションがないと
condition <- rep(1:2,5)

# 連続した数字を作る関数
seq(1,5,0.5)


# 乱数に基づく数字を発生させる
#
# 発生させる数
N <- 100 
# 正規分布は「平均」と「標準偏差」をパラメータとする。
# 平均0,標準偏差100
rnorm(N,0,100)
# 平均50,標準偏差10
rnorm(N,50,10)

# コイントスをした占いを考えたい
# 裏表の分布はベルヌーイ分布というのがある
# N回中k回表が出る確率，を表す二項分布を応用して使う
rbinom(N,1,0.5)


# タネを押さえておく
set.seed(12345)
rnorm(5,0,1) # 1回め
rnorm(5,0,1) # 2回め
set.seed(12345)
rnorm(5,0,1) # タネをセットして1回目


# 行と列をまとめる

# ベクトルをひっつけるのは簡単
x <- 1:4
y <- 100:150
c(x,y)

# 矩形のものを引っ付ける関数
x <- matrix(1:10,ncol=5)
y <- matrix(11:20,ncol=5)
cbind(x,y)
rbind(x,y)

# サイズが違うとエラーになる
x <- matrix(1:10,ncol=5)
y <- matrix(11:25,ncol=3)


# ワイド型とロング型の並べ替え
# ワイド型データ
dat <- read.csv("baseball2016.csv",fileEncoding = "UTF-8")
dat <- subset(dat,select=c("team","pay","Hit"))

# ここまでの技術を応用
dat.long <- rbind(cbind(dat$team,1,dat$pay),cbind(dat$team,2,dat$Hit))
dat.long <- data.frame(dat.long)
names(dat.long) <- c("team","variable","val")

# 便利なパッケージを使う
library(tidyr)
dat2 <- tidyr::gather(dat,key="variable",value="val",-team)

