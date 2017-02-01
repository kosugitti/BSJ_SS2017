# 行動計量学会第19回春の合宿セミナー Aコース 「今日から始めるベイジアンモデリング」に参加される皆様へ
#　準備のご案内
文責；小杉考司（山口大学教育学部）

# ご案内
この度はAコース「今日から始めるベイジアンモデリング」に参加いただきありがとうございます。
この講習にはソフトウェアを使った演習が含まれます。
以下のフリーソフトウェアを使いますので，次のものをインストールしたPCを当日はお持ちください。

+ 統計環境R
+ 総合開発環境RStudio
+ Rのパッケージとして
	+ RStan(ならびにRStanが必要とする他の依存パッケージ)
	+ MASSパッケージ

かつてインストールしたことがある，という方も，いずれも最新バージョンにバージョンアップしておいてください。

+ この記事を書いている**2017年1月20日**段階での最新バージョンは次の通りです

	+ R ; ver 3.3.2
	+ RStudio ; ver 1.0.136
	+ RStan ; ver 2.14.1

# 導入方法について

## RとRStudioの導入

それぞれの公式サイトより，自分のPC環境にあったインストーラーをダウンロードし，実行してください。

+ Rの公式サイトは[こちら](https://www.r-project.org)です。
+ RStudioの公式サイトは[こちら](https://www.rstudio.com/products/rstudio/download/)です。

## RStanパッケージの導入について

RStanパッケージの導入については，[こちらのサイト](https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started-(Japanese))に詳しい説明がありますのでよく読んでインストールしてください。

このサイト内にあるRStanの使用方法の

```
 library(rstan) #スタートアップのメッセージが表示される
```

が問題なくできれば準備完了です。

**コンパイラ導入に関する注意**

+ Windowsをお使いの方は，Rtoolsをダウンロードする必要があります。
	+ Rtoolsは[こちらのサイト](https://cran.r-project.org/bin/windows/Rtools/)にあります。Rのバージョンにあったものをダウンロード＆インストールしてください。
	+ [こちらのサイト](https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started-(Japanese))にありますように，インストール画面の途中で**環境変数PATHを編集するステップに注意してください。**
+ Macをお使いの方は，Xcodeと呼ばれる開発環境をAppStoreからダウンロードする必要があります。数Gバイトの大きなファイルサイズですので，時間に余裕を見てご準備ください。
	+ OS X 10.9 “Marvericks” ,10.8 “Mountain Lion”をお使いの方は，App Storeで「Xcode」を検索してダウンロード＆インストールしていただく必要があります
	+ OS X 10.7 “Lion” , 10.6 “Snow Leopard”をお使いの方は，Apple Developerに登録(無料)して，XcodeとCommand-Line Toolsをダウンロード＆インストールしていただく必要があります。
+ Linux環境の方は次のコマンドを実行してください。

```
sudo apt-get install build-essential
```

# 問い合わせ先

どうしてもインストール方法がわからない，という方はkosugi[at]yamaguchi-u.ac.jpまでご一報ください。([at]はアットマークに変換してください。)

