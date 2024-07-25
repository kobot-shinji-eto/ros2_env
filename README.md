# 1. 概要
このリポジトリはKobotインターン生がros2環境を容易に構築することを目的として作成した．Dockerfileに追記することで，後継者たちが不要なインストール作業や環境構築を行う手間を省くことができる．そのため，このリポジトリを使用するインターン生は適時Dockerfileに追記をお願いしたい．

# 2. フォルダ構成

```shell
ros2_env/
　├ catkin_ws/
　├ docker-compose.yaml
　├ dockerfile
　└ entrypoint.sh
```

| フォルダ/ファイル | 説明 |
| ---- | ---- |
| catkin_ws | ros開発の作業フォルダ |
| docker-compose.yaml | docker composeの構成 |
| dockerfile | dockerイメージの構成 |
| entrypoint.sh | エントリーポイントの構成 |

# 3. 手順

## 3.1 ros2環境の構築

### 3.1.1 wslのインストール
1. windowsの機能の有効化または無効化を開く．
![](./asset/img/img1.avif)

2. `Hyper-V` , `Linux 用 Windows サブシステム` または` Windows Subsystem for Linux` , `仮想マシンプラットフォーム` を有効にする.
![](./asset/img/img2.avif)
![](./asset/img/img3.avif)

3. PCを再起動

### 3.1.2 ubuntu20.04をインストール

powershellを起動してubuntu20.04をインストールする．

1. WSLバージョンを2に設定する．
```shell
wsl --set-default-version 2
```

2. Linuxディストリビューションをインストールする．
```shell
wsl --install -d Ubuntu-20.04

=============================

ダウンロード中: Ubuntu 20.04 LTS
インストール中: Ubuntu 20.04 LTS
Ubuntu 20.04 LTS はインストールされました。
Ubuntu 20.04 LTS を起動しています...
```

3. ubuntuを起動
ubuntuがインストールされているのでメニューから選択して起動する．
ユーザ名やパスワードを設定する．ここで，**パスワードは打ち込んでも見えない**ことに注意すること．

### 3.1.3 dockerをインストール

以降の作業はubuntuで行う．

1. パッケージの更新と依存ライブラリのインストール
```shell
$ sudo apt update
$ sudo apt install ca-certificates curl gnupg lsb-release
```

2. docker gpg鍵をaptに登録
```shell
$ sudo mkdir -p /etc/apt/keyrings
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
$ sudo chmod a+r /etc/apt/keyrings/docker.gpg
```
3. パッケージソースをシステムに追加し再度更新
```shell
$ echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
 https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
 sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
$ sudo apt update
```
4. dockerのインストール
```shell
$ sudo apt install docker-ce docker-ce-cli containerd.io
```

| 参考資料 | リンク |
| ---- | ---- |
| wsl2 | [LINK](https://qiita.com/ryome/items/240f36923f5cb989da27) |
| dockerインストール | [LINK](https://kinsta.com/jp/blog/install-docker-ubuntu/) |

### 3.1.4 dockerイメージをビルドする．

1. 作業フォルダの設定
`rosw_envの保存先パス`にはros2_envを保存したパスで置き換えることに注意する．

```shell
$ export WORK_DIR={ros2_envの保存先パス}
$ cd $WORK_DIR
```

2. dockerイメージをビルドする．
```shell
$ docker compose build
```

3. dockerコンテナを起動する．
```shell
$ docker compose up -d
```

4. (option) dockerイメージに追記してコンテナをリスタートする場合は`restart`コマンドを使用する．このコマンドは必要なときだけ実行すること．
```shell
$ docker compose restart
```

5. (option) dockerコンテナを終了する場合は`stop`コマンドを使用する．このコマンドは必要なときだけ実行すること．
```shell
$ docker compose stop
```