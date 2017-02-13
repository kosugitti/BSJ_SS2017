#########################################
#
# 行動計量学会第19回春の合宿セミナー
#　　サンプルスクリプト
#      Lesson 2 Rの基本操作(後半)
#
#　　(c) Koij Kosugi(@kosugitti)
#
#########################################

# 数値例を発生
set.seed(12345)
# 標準正規分布から発生する100個の乱数をつくってみる
x100 <- rnorm(100,0,1)
mean(x100)        # 平均値
var(x100)         # 分散
sd(x100)          # 標準偏差
max(x100)         # 最大値
min(x100)         # 最小値
median(x100)      # 中央値

# パーセンタイル
# 0%, 25%, 50%, 75%, 100%
quantile(x100,probs=c(0,0.25,0.5,0.75,1))

################

# 最頻値の関数はないのでヒストグラムから作る
h1 <- hist(x100)
h1$mids[which.max(h1$counts)]
# 階級幅を変える
h2 <- hist(x100,breaks=seq(-5,5,0.1))
h2$mids[which.max(h2$counts)]
# 階級幅が違うと最頻値は変わる
h3 <- hist(x100,breaks=seq(-5,5,1))
h3$mids[which.max(h3$counts)]

################
# 毎回答えが違う
x100.1 <- rnorm(100,0,1)
x100.2 <- rnorm(100,0,1)
x100.3 <- rnorm(100,0,1)

mean(x100.1)
mean(x100.2)
mean(x100.3)

# サンプルサイズを増やすと理論値に近づく
x1000 <-  rnorm(1000,0,1)
mean(x1000)

x10000 <- rnorm(10000,0,1)
mean(x10000)

x100000 <-  rnorm(100000,0,1)
mean(x100000)

# 確率点
quantile(x100000,probs=c(0,0.25,0.33,0.75,1))
qnorm(0.25,0,1)
qnorm(0.33,0,1)
qnorm(0.75,0,1)

# 累積分布；ある数字よりも大きく(小さく)なる確率
length(x100000[x100000<1.96])/length(x100000)
pnorm(1.96,0,1)


################
# 図にするとわかりやすい
hist(x100)
hist(x1000)
hist(x10000)
hist(x100000)

# plot 関数
x <- 1:10
y <- 1:10
plot(x,y)
plot(x,y,xlim=c(-10,10),ylim=c(-10,10))
plot(x,y,main="Title",xlab="X axis",ylab="Y axis")

# もう一度野球のデータを例にしましょう
baseball2016 <- read.csv("baseball2016.csv",
                         fileEncoding="UTF8",
                         na.strings="*")

# ggplot2パッケージが超おすすめ
library(ggplot2)
g <- ggplot(baseball2016,aes(x=height,y=weight))
g <- g + geom_point()
g

# 文字化けするMacユーザは次の呪文を唱えてから実行すると良い
#　　参考 >　奥村研究室　https://oku.edu.mie-u.ac.jp/~okumura/stat/ggplot2.html 
old = theme_set(theme_gray(base_family="HiraKakuProN-W3"))

# 色分け情報追加
g <- ggplot(baseball2016,aes(x=height,y=weight,color=team))
g <- g + geom_point()
g

# かき分け情報追加
g <- g + facet_wrap(~position)
g

# 色分けとかき分け
g <- ggplot(baseball2016,aes(x=HR,y=pay,color=position))
g <- g + geom_point()
g <- g + facet_wrap(~team)
g



# ヒストグラム（y軸情報はない)
g <- ggplot(baseball2016,aes(x=pay)) + geom_histogram(binwidth = 500)
g

# グループごとのヒストグラム
g <- ggplot(baseball2016,aes(x=pay,fill=team))
g <- g + geom_histogram(binwidth=500)
g <- g + facet_wrap(~team)
g

# 密度にする
g <- ggplot(baseball2016,aes(x=pay,y=..density..,fill=team))
g <- g + geom_histogram(binwidth=500,alpha=0.5,position="identity")
g <- g + geom_density(alpha=0.5)
g <- g + facet_wrap(~team)
g


# 横軸がカテゴリカル
g <- ggplot(baseball2016,aes(x=team,y=pay,fill=team))
g <- g + geom_boxplot()
g

# バイオリンプロット(分布がイメージしやすい)
g <- ggplot(baseball2016,aes(x=team,y=pay,fill=team))
g <- g + geom_violin()
g
