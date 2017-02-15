# 行動計量学会第19回春の合宿セミナー　Aコース
# 今日から始めるベイジアンモデリング

**準備中**

## はじめに

## このセミナーの目標

### 考え方の目標（伝えたいこと）

1. 「与えられたデータの特徴を探る」研究から「データを作り出すメカニズムを考える」研究へ変わること。
2. 求めるものが確率変数になること。
3. サンプルから作られた事後分布の近似データを解釈することにより間違いが生じにくくなること。

### 技術的な目標（学んで欲しいこと）

1. MCMCサンプルの読み方
2. 仮装データの組み立て方
3. 添字の使い方（階層性への自然な拡張）


## 準備にあたって

準備にあたっては，別に用意しました[準備用のページ](junbi.md)にアクセスしてください。
R，RStudio，rstanパッケージのインストールの方法が書いてあります。

本セミナーで使うRのパッケージは次の通りです。

+ rstanパッケージ
+ tidyrパッケージ
+ ggplot2パッケージ
+ MASSパッケージ
+ looパッケージ

発展的な利用のために，次のパッケージがあると便利です
+ psychパッケージ
+ dplyrパッケージ

## 第一講　環境の準備

+ [Rの基本的な操作法(前半)](Lesson1.R)
+ 外部ファイルのサンプルデータは[baseball2016.csv](baseball2016.csv)です。
+ 練習問題1の解答例は[Exercise1.R](Exercise1.R)です。
+ [Rの基本的な操作法(インターミッション)](InterMission.R)
+ [Rの基本的な操作法(後半)](Lesson2.R)
+ 練習問題2の解答例は[Exercise2.R](Exercise2.R)です。

## 第二講　考え方の準備
## 第三講　Stan入門

+ 公式サンプル(8schools)のファイルは[8shcool.stan](8school.stan)です。
+ 公式サンプルを呼び出して使うRコードは[Lesson3.R](Lesson3.R)です。

## 第四講　ベイジアンモデラーへの道

+ 第四講　Rのソースコードは[Lesson4.R](Lesson4.R)です。
+ モデルコード 一つの正規分布[model1.stan](model1.stan)
+ モデルコード 事前分布を置いた[model2.stan](model2.stan)
+ モデルコード 事後予測分布を描く[model3.stan](model3.stan)
+ モデルコード 対数尤度を算出[model3b.stan](model3b.stan)
+ モデルコード 二群の平均値を推定[model4.stan](model4.stan)
+ モデルコード アンバランスで等分散な二群[model4b.stan](model4b.stan)
+ モデルコード アンバランスで等分散でない二群[model4c.stan](model3c.stan)
+ モデルコード さまざまな生成量[model4d.stan](model4d.stan)

+ 参考論文；[岡田謙介(2014)ベイズ統計による情報仮説の評価は分散分析にとって代わるのか?,基礎心理学研究，32(2),223-231](http://www3.psy.senshu-u.ac.jp/~ken/JJPS2014.pdf)
+ 参考文献；[お菓子の力を推定してみました](http://qiita.com/painomi2/items/8827611c344258b715c7)

## 第五講　ベイジアンモデラーへの道

+ 第五講　Rのソースコードは[Lesson5.R](Lesson5.R)です。
+ モデルコード 対応のある2群の場合[model5.stan](model5.stan)
+ モデルコード 分散分析モデル[model6.stan](model6.stan)
+ モデルコード 分散分析モデルの別解[model6b.stan](model6b.stan)
+ 参考文献；[球面性仮定の出力](http://riseki.php.xdomain.jp/index.php?ANOVA君%2F球面性検定の出力)



