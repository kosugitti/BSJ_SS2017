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

baseball <- read.csv("baseball.csv",head=T,fileEncoding = "UTF-8")

# BMIを計算する。身長がメートル単位でなければならないことに注意。
baseball$BMI <- baseball$weight / (baseball$height/100)^2

# 「セ・リーグとパ・リーグを区別する」もう少しかっこいい方法
# チーム名が入ったベクトルを用意する
Central <- c("巨人","阪神","広島","ヤクルト","中日","DeNA")
# match関数で判断させる
baseball$CP <- ifelse(is.na(match(baseball$team,Central)),2,1)

# パ・リーグの投手のデータだけ抜き出す例1

# まずパリーグだけ抜き出して，
baseball$CP <- factor(baseball$CP,labels=c("Central","Pacific"))
Pa <- subset(baseball,baseball$CP=="Pacific")
# つぎにその中から投手だけを抜き出す方法
Pa.Pitcher <- subset(Pa,Pa$position=="投手")


# パ・リーグの投手のデータだけ抜き出す例2
# 二つの条件が合致するケースを抜き出す方法
Pa.Pitcher <- subset(baseball,(baseball$CP=="Pacific" & baseball$position=="投手"))
