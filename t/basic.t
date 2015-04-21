use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('AddressBook');


# ログイン画面の描写のみ


# ステータスの確認
$t->get_ok('/auth/login')->status_is(200);

# 表示内容の確認
$t->content_like(qr{addressbook/login},                                     'title'        );
$t->content_like(qr{アカウントを作成},                                      'headerNavi'   );
$t->content_like(qr{address book},                                          'siteTitle'    );
$t->content_like(qr{メールアドレス：},                                      'inputMail'    );
$t->content_like(qr{パスワード：},                                          'inputPassword');
$t->content_like(qr{実行},                                                  'inputSubmit'  );
$t->content_like(qr{Copyright \(C\) ADDRESSBOOK Inc. All Rights Reserver.}, 'copyright'    );

# ログイン入力実行
$t->post_ok('/auth/login')->status_is(200);

# バリデート
$t->content_like(qr{メールアドレスを入力});

$t->post_ok('/auth/login' => form => {mail => 'hoge'})->status_is(200);

$t->content_unlike(qr{メールアドレスを入力});


# フィルイン表示

# ログイン成功



done_testing();
