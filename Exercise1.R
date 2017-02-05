#########################################
#
# 行動計量学会第19回春の合宿セミナー
#　　サンプルスクリプト
#
#　　(c) Koij Kosugi(@kosugitti)
#
# 練習問題1　回答例
#
#  できていれば必ずしもこのやり方である必要はありません。
#  あくまでも回答「例」です。
#
#########################################

dat <- read.csv("baseball2016.csv",head=T,fileEncoding = "UTF-8")

# BMIを計算する。身長がメートル単位でなければならないことに注意。
dat$BMI <- dat$weight / (dat$height/100)^2

# 「セ・リーグとパ・リーグを区別する」もう少しかっこいい方法
# チーム名が入ったベクトルを用意する
Central <- c("巨人","阪神","広島","ヤクルト","中日","DeNA")
# match関数で判断させる
baseball2016$CP <- ifelse(is.na(match(baseball2016$team,Central)),2,1)

# パ・リーグの投手のデータだけ抜き出す例1

# まずパリーグだけ抜き出して，
Pa <- subset(dat,dat$CP=="Pacific")
# つぎにその中から投手だけを抜き出す方法
Pa.Pitcher <- subset(Pa,subdat$position=="投手")


# パ・リーグの投手のデータだけ抜き出す例2
# 二つの条件が合致するケースを抜き出す方法
Pa.Pitcher <- subset(dat,(dat$CP=="Pacific" & dat$position=="投手"))
