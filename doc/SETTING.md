# AddressBookシステム (設定に関する資料)

## ローカル環境

    Perl5.18.2
    plenv versions # Perlバージョン確認
    plenv global 5.18.2 # Perlバージョン切替

    WEBフレームワーク
    Mojolicious4.47

    モジュール管理
    carton

    モジュール一式確認
    address_book/cpanfile の中身を参照

    address_bookシステム起動
    carton exec morbo script/address_book

    データベース
    sqlite3
    address_book/lib/AddressBook/Model/address_book.db

    データベースの中身をみる
    sqlite3 address_book.db

    テーブルの一覧を見る
    .tables

    すべてのテーブルの構造体を確認
    .schema

    ログイン
        id: address@book.com
        pass: book







