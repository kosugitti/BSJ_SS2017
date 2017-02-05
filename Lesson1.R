#########################################
#
# 行動計量学会第19回春の合宿セミナー
#　　サンプルスクリプト
#      Lesson 1 Rの基本操作
#
#　　(c) Koij Kosugi(@kosugitti)
#
#########################################

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


# 外部ファイルの読み込み
baseball2016 <- read.csv("baseball2016.csv",
                         fileEncoding="UTF8",
                         na.strings="*")
summary(baseball2016)
str(baseball2016)

# データの一部を抜き出す

subSet1 <- baseball2016[baseball2016$height>180,]

subSet2 <- subset(baseball2016,baseball2016$weight>100)

subSet3 <- subset(baseball2016,select=c("height","weight"))

subSet4 <- baseball2016[baseball2016$height>180,c("height","weight")]



# データから新しく変数を作り出す

baseball2016$ID <- 1:nrow(baseball2016)

baseball2016$example <- 1


# 10年以上プレイしている選手はベテランとする
baseball2016$type <- ifelse(baseball2016$year>=10,1,2)
baseball2016$type <- factor(baseball2016$type,labels = c("old stager","young stager"))

# セ・リーグとパ・リーグを区別する
baseball2016$CP <- ifelse(baseball2016$team=="巨人",1,
                          ifelse(baseball2016$team=="阪神",1,
                                 ifelse(baseball2016$team=="広島",1,
                                        ifelse(baseball2016$team=="ヤクルト",1,
                                               ifelse(baseball2016$team=="中日",1,
                                                      ifelse(baseball2016$team=="DeNA",1,2))))))
baseball2016$CP <- factor(baseball2016$CP,labels=c("Central","Pacific"))



