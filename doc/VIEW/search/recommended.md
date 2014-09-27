recommended.md

# AddressBookシステム おすすめ検索(recommended)

## リクエスト

### URL: http://sample.com/search/recommended
### URL: http://sample.com/
### METHOD: GET
### PARAMETER:
    FONTSIZELIST:
        (xx-large, x-large, large, medium, small, x-small, xx-small)
    COLORLIST:
        (black, dimgray, gray, darkgray, silver, lightgrey, gainsboro, whitesmoke, white, red)

## 画面の構成

#### 1: ヘッダーナビゲーション
    box:    背景 (color: gainsboro,)
    link:   ためしてみる (click: サンプルアカウントログイン後このページを表示, font-color: black, font-size: large,)

#### 2: ログインリンク
    link:   ログイン (click: サンプルアカウントログイン後このページを表示, font-color: black, font-size: large,)

#### 3: サイトタイトル
    text: address book (font-color: black, font-size: xx-large,)

#### 4: 検索フォーム
    from: 検索入力 (input: text, font-color: black, font-size: medium,)

#### 5: 検索実行ボタン
    button: 実行 (click: auth/login, font-color: black, font-size: small,)
    * 実行時はpostリクエスト
