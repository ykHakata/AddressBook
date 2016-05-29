# NAME

    AddressBook - 検索、登録ができる共用の住所録

# URL

    開発初期の見本、静的なページ
    http://yonabemt.sakura.ne.jp/AddressBook/script/address_book.cgi/index.html

    アプリケーション
    http://yonabemt.sakura.ne.jp/AddressBook/script/address_book.cgi

# HISTORY

    2013-10 作成開始
    福岡Perlコミュニティーによる勉強会 天神Perlでの制作課題

    2016/05/28 開発再開

# DEPLOYMENT

レンタルサーバーへ接続

```bash
# 鍵認証による接続
$ ssh yonabemt@yonabemt.sakura.ne.jp
```

レンタルサーバーでのサイトの更新

```sh
# さくらのレンタルサーバーは csh
% pwd
/home/yonabemt/www/AddressBook

# (リポジトリを最新の状態に)
% git fetch

# (ローカルと同じ状態)
% git pull origin master
```

モジュールの追加

```sh
# 例: Mojolicious をインストールの場合
% cpanm -l ~/www/AddressBook/local/ Mojolicious
```
