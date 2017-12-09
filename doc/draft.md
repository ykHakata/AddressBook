アドレスブックサイト開発メモ

*****

2013-10-16

perlbrew install 5.18.1

perlbrew switch 5.18.1

カートンインストール
cpanm Carton

gitにてバージョン管理
リポジトリ作成
git init address_book


カートンにてモジュール管理
address_bookディレクトリにcpanfile作成
requires 'Mojolicious', '4.47';


カートンでモジュールインストール
carton install


gitで履歴をとる
localディレクトリ(cpanモジュール一式)はgit管理対象外
echo local >> .gitignore

git add .
(カレントディレクトリをすべて保存)
git commit -m "add Mojolicious"

mojoでひな形をつくる
carton exec mojo generate app AddressBook

address_book内のファイル一式を移動
mv address_book/* .
address_book空ディレクトリを削除
rmdir address_book

gitで履歴をとる
git add .
git commit -m "add address_book AppModel"

mojo立ち上げ
carton exec morbo script/address_book

データベースはsqlite3を利用
モジュール追加
requires 'Teng', '0.20';
requires 'DBD::SQLite', '1.40';

carton install

sqliteとtengの接続を確認するため
サンプルデータと出力のスクリプトを書く
*****
sqlite3 sample.db

create table personal(id integer,name text);

insert into personal values(1,'katuo');

.exit
*****

teng_loader.pl

carton exec perl teng_loader.pl
*****

lib/AddressBook/Example.pm
teng_loaderを記入
lib/AddressBook/sample.db
(テスト用データ)
出力してみる。
*****
各資料を保存するディレクトリ
doc
開発メモファイル
draft.txt
次回、仕様書作成
*****
2013-11-16
  ・天神Perlにて
  ・perlbrewにてperl5.18.1インストール、開発再開
  ・カートンインストール
  ・基本的なテーブル、sqlファイル作成
    address_book_test.sql
  ・sqlite新規データベース作り方
    sqlite3 address_book.db
  ・sqlファイルを読み込んでのテーブル作成
    sqlite3 address_book.db < address_book_test.sql
  ・テーブルの中身をみる
    sqlite3 address_book.db
    .tables
  ・テーブルのカラム名をみる
    .schema
  ・テスト表示用のダミーデータを作成sqlファイルを作る
    address_book_test_add.sql
  ・テスト用ダミーデータ読み込み
    sqlite3 address_book.db < address_book_test_add.sql
  ・teng接続、何かを表示する
  ・「全てを表示する」画面を作ってみる。
  ・ファイルをつくる。
  コントローラー　住所録表示　Display.pm
    アクション　all
                keyword
                icon
  templates
    display
      all.html.ep
      keyword.html.ep
      icon.html.ep
    ・ルートを作る
*****
2013-11-17
・テーブルデータ作り直し
sqlite3 address_book.db < address_book_1117.sql
*****
2013-11-19
・オープニング画面、ログインから始まるので、認証 auth.pm、
・テンプレート auth
  オープニング top
  ログイン画面 login

・addressbook会員のためのページ機能
  ・新規登録 Member.pm/create
  ・登録内容確認 /list
  ・登録内容変更 /modify
  ・登録内容削除 /delete

・サイト全体のイメージをつけるための画面一覧を作る
  /preview
  Preview.pm
    list
*****
2013-11-20
  ・目次の完成
  ・cssディレクトリの導入(yoyakkuをコピー)
    すこしづつ改良してゆく
*****
2013-11-24
  ・jsの導入
  ・all画面のリスト表示、非表示機能を導入
*****
2013-12-07

  ・色の見直し、cssの構成
    モノクロ
    black
    dimgray
    gray
    darkgray
    silver
    lightgrey
    gainsboro
    whitesmoke
    white
    強調
    crimson
    red
    orangered
    tomato
    coral


*****
2013-12-08

*****
2013-12-14
  天神Perlにて
  ・本日の作業

  ・ログイン機能の実装
    ・ログインの為の登録情報のデータベース作成
      ・テーブル名   admin
      ・カラム名
        id  | name | mail | password | delete_flag | create_on | modify_on
        INT | TEXT | TEXT | TEXT     | INT         | TEXT      | TEXT
      ・ログイン用のサンプルデーターの準備
        KurosawaMiyuki  nzoqryrumiyuki773@fajinb.iwet.en    6714
        MarutaMiyuki    imaruta@zuehdupsrf.oti  2233
        TakaharaYuina   yuina31295@waxyzduc.xj  5947
        OotsuChiaki chiaki06166@tuynmtegvp.fium.up  7291
        NagaseReina reina0586@gijxylbay.zjnlz.hni   7985
        AzumaAkane  akane191@tszdgr.pzc 9829
        YanagidaMinako  minako21547@zjeozcnptw.xeyfx.ipd    3398
        NiimuraMayuko   mayuko9663@cbas.rsgke.jsx   9119
        IkutaTorao  torao_ikuta@pbpklkqros.ni   1017
        OonukiSatomi    satomi41141@wpazliol.ufe    1850
        ・sqlliteへの実行
          sqlite3 address_book.db < address_book_1214.sql
        ・確認
          ・テーブルの中身をみる
            sqlite3 address_book.db
            .tables
          ・テーブルのカラム名をみる
            .schema
          ・APIの実装
            Auth.pm
          ・画面の作成
            auth/login.html.ep
  ・検索機能の実装
    ・シンプルに名前の検索を出来るようにする。
        下の名前だけでの検索
        検索結果を下の部分に表示
    ・オープニングの検索画面を作る。
      Display.pm search
      display/search.html.ep
*****
2014-02-16
  ・gitでのバーション管理再開合わせてファイルを整理
  ・とりあえずはすべてをコミット "git管理再開"
  ・.gitignoreにyoyakku と同じように記載
  ・docに 作業履歴(WORKHISTORY.md) を追加 ディレクトリの整理から始める
*****
2014-02-17
    ・久しぶりなので、現状を確認まとめる。
    ・api
        ・yoyakkuにならい、開発管理者向けの画面を作成
        ・Manager.pm
        ・templates/manager/list.html.ep or myadmin.html.ep
        ・public/js/manager/myadmin.js
        ・開発中につきログイン機能なし
        ・開発管理者のルートを記載
        ・要件をまとめて、一度コミット、そのあとブランチ作成、作業開始

        ・api Manager.pmを作成
*****
2014-02-19
    ・githubへのpushの手順
https://github.com/ykHakata
・右上+ newRepository
owner ykHakata
Repository name address_book

https://github.com/ykHakata/address_book.git

・リモートリポジトリ作成
    ・リモートリボジトリ確認 git remote -v
    ・リモートリポジトリ作成 リモートリポジトリ名前,url
    git remote add origin https://github.com/ykHakata/address_book.git

    ・すでにあるgitをリポートのgitにおくる
      git push origin develop-0002
      git push origin master



      ・githubで管理してみる。
  ・github/ykHakata
  ・ID YKHakata パスワード githubkabe0520
  ・Repositries New yoyakku
  ・今回はhttp接続で https://github.com/ykHakata/yoyakku.git
  ・リモートリポジトリを作成
    ・リモートリボジトリ確認 git remote -v
    ・リモートリポジトリ作成 リモートリポジトリ名前,url
      origin
      https://github.com/ykHakata/yoyakku.git
    ・すでにあるgitをリポートのgitにおくる
      git push origin master
*****
2014-02-22
    ・天神Perlにて作業
    ・作業環境を整える
    ・perlbrewにてPerl5.18に切替
    ・perlbrew switch 5.18.1
    ・確認 perlbrew list
    ・githubとsoureTreeで作業状況を管理
        ブックマークに adress_bookを追加
        ・リモートリポジトリと同期させる git pull
    ・今日の作業内容を決める
        ・ReadMeをきちんと書いてみる
        ・作業履歴に記録を残しておく
        ・いちいちgitでコミットして、gitとgithubの使い方になれる
        ・各画面と各機能を分かりやすく命名して、整備する。
            ・ログイン画面(機能)
        ・git stash save "0003"
        ・git stash pop

    ・作業を開始する
        ・ブランチを作成
        develop-0004
        ・コミット
        "[Auth]ログイン機能(新規) 0004"
        基本要件を定義
        git checkout -b develop-0004
        git branch
        git add -A
        git commit -m "[Auth]ログイン機能(新規) 0004"

    ・いったん、リモートリポジトリに更新
        master更新
        readmeを更新してみる

        git add -A
        git commit -m "資料の整備(README.md) 0001"
        gti push origin master

        develop-0004に移動して、push

        ログイン機能のルートの書き直し作業
        ルートの記述を変更し、画面の方も反映させる
        grep で　login logout と 記述してある個所を検索
        該当ファイルを洗い出し
        ファイルを複数検索させる
        grepコマンド
        grep -r "login" .
        grep -r "logout" .
        /auth
        ・動作確認、コミット
        git add -A
        git commit -m "[Auth]ログイン機能(ルート記述変更) 0004"
        git push origin develop-0004

        ・次の作業
        ログイン機能の見直し
        バリデート機能の実装
        バリデートの為のモジュールを導入
        requires 'FormValidator::Lite', '0.37';
        cpanfile 記述 実行
        carton install

        git add -A
        git commit -m "[Auth]ログイン機能(FormValidator::Lite) 0004"
        git push origin develop-0004
        "[Auth]ログイン機能(FormValidator::Lite) 0004"

        ・バリデーターの基本形を作成
        バリデータについてはjsと両方で実施する
        "[Auth]ログイン機能(バリデート原型) 0004"
*****
2014-03-15
    ・本日の作業予定
        ・前回までの進捗確認
            ・作業履歴を確認
                ・ログイン機能の実装の続きをする。

        ・作業環境準備
            ・perlbrewにてPerl5.18に切替
            ・perlbrew switch 5.18.1
            ・確認 perlbrew list
            ・github、soureTreeで作業状況を管理
            ・addressbookサイトを起動
            mojo立ち上げ
            carton exec morbo script/address_book
            ・リモートリポジトリと同期させる git pull
        ・作業予定を設定
            ・ログイン機能実装のつづき
                ・ログインapiの仕様を作ってみる
                    類似資料を参考に
                ・api仕様に基づいて、実装
                    仕様書が無いので、簡単に
                    リクエスト
                        /auth/login
                        post
                            mail : メールアドレス (例: address@book.com)
                            pass : パスワード (例: book)
                    レスポンス
                        sessonに引き渡し
                            mail : メールアドレス (例: address@book.com)
                            name : ログイン名 (例: MisterBook)
                        成功の場合
                            / トップページにリダイレクト
                        失敗の場合
                            /auth/login を再度表示
                            入力された値も再度表示(フィルインをつかう)
                    リクエスト
                        /auth/login
                        get の場合 パラメーターなし
                    レスポンス
                        /auth/login を表示
                    ***
                時間があれば画面の方の作業をすすめる
        ・作業開始
        requires 'HTML::FillInForm', '2.20';
        モジュールインストールし、フィルイン機能、バリデートを完成させる
        API Auth.pm実装
        ・ログインボタンの位置を変更、全ての画面のヘッダーで機能するようにする

        ・作業内容の記録
            ・workhistory.mdに記入、gitにてpush, githubにも反映すみ
            ・次回の作業の予定を考える
            ・ログイン者が各設定を行える機能の仕様と実装を考えてみる
            ・設定機能 Setting.pm
                ・アカウント管理
                    ・登録ID パスワード
                ・プロフィール管理
                    ・登録者情報
                        ・名前 メルアド 電話 アイコン画像 住所
*****
2014-04-19
    ・本日の作業予定
        ・前回までの進捗確認
            ・ログイン周りの機能を実装、バリデータ、フィルイン機能

        ・作業環境準備
            ・perlbrewにてPerl5.18に切替
            ・perlbrew switch 5.18.1
            ・確認 perlbrew list
            ・github、soureTreeで作業状況を管理
            ・addressbookサイトを起動
            mojo立ち上げ
            carton exec morbo script/address_book
            ・リモートリポジトリと同期させる git pull
        ・作業予定を設定
            ・前回要件定義をした、設定機能をすすめる。
            ・設定機能にディレクトリ構造準備

            git にてブランチ作成、push

        "[Setting]設定機能(新規) 0005"

        ・現状のDBを再確認
        アカウントのadminテーブルはあるので、account_searchから実装
*****
2014-06-07
    ・本日の作業予定
        ・前回までの進捗確認
            ・perlbrewからplenvに乗り換え
            ・まずは動かしてみる
              carton exec morbo script/address_book
              yoyakku同様仕様書づくりをやってみる、
              設定関連をまとめた仕様書
              doc/
                API/           # API仕様書
                MODEL/         # DB関連仕様書
                VIEW/          # 画面仕様書
                SETTING.md     # 設定、環境構築などの仕様書
                WORKHISTORY.md # 作業履歴

        ・作業環境準備
            ・SETTING.md にまとめ

        ・画面の仕様書の作成をやってみる
            ・原案のキーノートを確認
*****
2014-08-09
  ・本日の作業予定
    ・plenvにのりかえた、plenv確認、最新の5.20
    ・久しぶりに動かしてみる、ブラウザをFirefoxにすることに
  carton exec morbo script/address_book
    perlのバージョンが違うと、5.18を利用するように設定する
    plenv local 5.18.2

    本日は、前回つくった画面仕様書をもとに
    うごきのない静的な画面を先に作り、最低限のjs、
    その後、動きを実現するためのAPIの実装の順に、
    そしてそのAPIを実現するために最低限のDB(model)の作成
    最小の単位でテスココードをつくってみる

    ログイン画面(/auth/login)をつくってみる

    public/auth/login.html
      を作ってみる。

    ざっとできたのでcssのディレクトリ構造を考えてみる

    css/
      import.css # すべてはこれを読み込み

      layouts/ # 共通で利用するcssディレクトリ
        reset.css # ブラウザのデフォルトの設定をリセット
        structure.css # 基本になるcss
        header.css # ヘッダーのcss
        contents.css # コンテンツの基本css
        footer.css # フッダーのcss


      auth/ # 認証関連ファイルのcssディレクトリ
        login.css # ログイン画面の個別のcss

*****
2014-10-09
  ・本日の作業予定

  ・前回までの進捗をおさらい
      とりあえず起動してみる
      git の状態をみてみる
      develop-0005

      前回はログイン画面を作り直し

      進め方を変更する、
      作業履歴はgithub のイシューをつかう
      １人でやってるのでgitのブランチはdevelopなどつかわず
      masterブランチにどんどんコミットで履歴を残しておく
      とりあえず現状をpushして、masterとマージさせてみる

      コミット
      "ログイン画面のみを作り直し"

      github のpushのしかたsshに変更する

    git remote で httpでcloneしたあとでもssh接続に切り替えられる

    git remote set-url origin git@github.com:ykHakata/address_book.git

    つぎにgithubでブランチを一つにしてみる
    $ git merge develop-0005

    githubにpush
    $ git push origin master

    ブランチ削除
    $ git branch -d develop-0005
    $ git push --delete origin develop-0005

    テストコードの実行
    carton exec ./script/address_book test t/basic.t

# 2016/05/28

    開発を再開
    README を更新
    perl 5.24.0
    cpanfile モジュールは全て最新に更新

    '環境再構築'

    スマホに対応のレスポンシブルにするため bootstrap 導入

# 2016/05/29

    さくらのレンタルサーバーにこの環境を構築してみたい
    cpanm がつかえるかためしてみる。

    -----

    AddressBook アプリをさくらのレンタルサーバーでみれるようにする。

    現状が動く状態か確認

    一旦コミット
    'bootstrap 導入'

    cgi 用の起動スクリプトを作成(ローカル環境)

    $ pwd
    /Users/yk/Github/AddressBook

    $ cp ./script/address_book ./script/address_book.cgi

    $ ls -al ./script/
    total 16
    drwxr-xr-x   4 yk  staff  136  5 29 14:19 .
    drwxr-xr-x  14 yk  staff  476  5 28 22:33 ..
    -rwxr-xr-x   1 yk  staff  236  5 29 13:56 address_book
    -rwxr-xr-x   1 yk  staff  236  5 29 14:19 address_book.cgi

    実行権限はすでにあるのでそのまま
    コードを若干修正

    ```perl
    #!/usr/bin/env perl

    use strict;
    use warnings;

    use FindBin;
    BEGIN { unshift @INC, "$FindBin::Bin/../lib" }
    BEGIN { unshift @INC, "$FindBin::Bin/../local/lib/perl5" }

    # Start command line interface for application
    require Mojolicious::Commands;
    Mojolicious::Commands->start_app('AddressBook');
    ```

    'cgi 用起動ファイル'

    サーバーへ

    % pwd
    /home/yonabemt/www

    % git clone git@github.com:ykHakata/AddressBook.git

    % ls -al AddressBook/
    total 92
    drwxr-xr-x  8 yonabemt  users    512 May 29 14:28 .
    drwxr-xr-x  7 yonabemt  users    512 May 29 14:28 ..
    drwxr-xr-x  7 yonabemt  users    512 May 29 14:28 .git
    -rw-r--r--  1 yonabemt  users     25 May 29 14:28 .gitignore
    -rw-r--r--  1 yonabemt  users      7 May 29 14:28 .perl-version
    -rw-r--r--  1 yonabemt  users    221 May 29 14:28 README.md
    -rw-r--r--  1 yonabemt  users    147 May 29 14:28 cpanfile
    -rw-r--r--  1 yonabemt  users  44728 May 29 14:28 cpanfile.snapshot
    drwxr-xr-x  3 yonabemt  users    512 May 29 14:28 lib
    drwxr-xr-x  6 yonabemt  users    512 May 29 14:28 public
    drwxr-xr-x  2 yonabemt  users    512 May 29 14:28 script
    drwxr-xr-x  2 yonabemt  users    512 May 29 14:28 t
    drwxr-xr-x  8 yonabemt  users    512 May 29 14:28 templates

    モジュールのインストール(git clone してからおこなう)
    % cpanm -l ~/www/AddressBook/local/ Mojolicious
    % cpanm -l ~/www/AddressBook/local/ Teng
    % cpanm -l ~/www/AddressBook/local/ DBD::SQLite
    % cpanm -l ~/www/AddressBook/local/ Readonly
    % cpanm -l ~/www/AddressBook/local/ FormValidator::Lite
    % cpanm -l ~/www/AddressBook/local/ HTML::FillInForm

    作業中の静的ファイルを表示
    http://yonabemt.sakura.ne.jp/AddressBook/script/address_book.cgi/index.html

    'readme 更新'
    いろんなもののまとめの記事を保存しておく git を作っておく
    Summary

    'cpanm まとめ追加'

    '見本のページ追加'
    'ラベル追加'

    画面の url を考えてみる

    /
    最初の画面

    公開されているアドレスブックを検索する画面
        /search
        /search?q=日下部&type=html&
    ログイン入力画面

    新規アカウントを作成する画面

    ためしてみる画面

    すべて表示画面

    キーワード表示画面

    アイコン表示画面

    個人情報の画面

# 2016/06/03

    'オープニング画面'
    'テンプレートレイアウト'


# 2016/06/07

    ログイン、ログアウト画面をつくる

    /login

    /logout

# 2016/06/09

    'ログイン機能'

# 2016/06/11

    'ヘルプ機能変更'

    公開されているアドレス帳の検索
    addressbook/share/search

    公開されているアドレス帳詳細情報
    addressbook/share/10

    個人が所有しているアドレス帳検索
    addressbook/personal/search

    個人が所有しているアドレス帳詳細
    addressbook/personal/10

    個人が所有しているアドレス帳更新
    addressbook/personal/10/update

    個人が所有しているアドレス帳新規作成
    addressbook/personal/create

# 2016/07/16

    テストコードを追加する

    開発のコードと同じようなディレクトリ構成で作成することにする
    テストコードに設計仕様に関するメモも書く事にする

