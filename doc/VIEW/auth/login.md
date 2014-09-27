# AddressBookシステム ログイン(login)

## リクエスト

### URL: http://sample.com/auth/login
### METHOD: GET
### PARAMETER:
    FONTSIZELIST:
        (xx-large, x-large, large, medium, small, x-small, xx-small)
    COLORLIST:
        (black, dimgray, gray, darkgray, silver, lightgrey, gainsboro, whitesmoke, white, red)

## 画面の構成

#### 1: ヘッダーナビゲーション
    box:    背景 (color: gainsboro,)
    link:   アカウントを作成 (click: アカウント作成ページに遷移, font-color: black, font-size: large,)

#### 2: サイトタイトル
    text: address book (font-color: black, font-size: xx-large,)


#### 3: ログインフォーム

    from: メール (input: text, font-color: black, font-size: medium,)
    from: パスワード (input: text, font-color: black, font-size: medium,)

#### 4: ログイン実行ボタン

    button: 実行 (click: auth/login, font-color: black, font-size: small,)
    * 実行時はpostリクエスト
