# 四則演算
1+2
2-3
3*4
4/5
(2+3)/4
(2+3)/(5-3)

# 関数の利用
sqrt(16)
help(sqrt)

# ベクトルをつかう
bsj <- c(5,6,7,8)
bsj
BSJ <- 1:4
BSJ
bsj + 2
BSJ * 2
mean(bsj)
sd(BSJ)
bsj + BSJ
cor(bsj, BSJ)

# 単純なプロット
plot(bsj,BSJ)

# 行列型のデータ
bsj2 <- matrix(1:10,ncol=2,nrow=5)
bsj2
bsj3 <- matrix(1:10,ncol=2,nrow=5,byrow=TRUE)
bsj3

bsj3[1,]
bsj3[,1]
bsj3[1,2]

# データフレーム型の例
bsj.df <- as.data.frame(bsj2)
bsj.df
bsj.df[,2]
bsj.df$V1

# Rのもつサンプルデータ
data(iris)
summary(iris)
# 構造を見る
str(iris)

# Factor型は特殊
summary(iris$Species)
iris$Species

# list型
BSJ.list <- list(
  names = c("Taro","Hanako","Yoshio","Keiko","Teppei"),
  ID = 1:20,
  height = c(160,150,170,166,132),
  values = matrix(1:100,nrow=20)
)

str(BSJ.list)

# 外部ファイルの読み込み
baseball2016 <- read.csv("baseball2016.csv",
                         fileEncoding="UTF8",
                         na.strings="*")
summary(baseball2016)
str(baseball2016)


