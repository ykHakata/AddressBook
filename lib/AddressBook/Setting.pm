package AddressBook::Setting;
use Mojo::Base 'Mojolicious::Controller';
# use Readonly;
# use FormValidator::Lite qw{Email};
# use HTML::FillinForm;
use Data::Dumper;

sub account_edit {
    my $self = shift;
    my $model = $self->model;
    # 各種値の設定
    my $table = 'admin';
    my $cond = +{ };

    # パラメータ取得
    my $params = $self->req->params->to_hash;




if ($id) {
    # create id 無いとき
    my $create_id = $model->fast_insert($table, $cond);
}
else {
    # modify id 有るとき
    my $row = $teng->single($table, $cond);
    $row->update($update_hash);

    # delete id あって、delete_flagがあるとき

}








    return $self->render(template => 'setting/account_edit');
}

sub account_search {
    my $self = shift;
    my $model = $self->model;
    # 各種値の設定
    my $table = 'admin';
    my $cond = +{ };

    # 検索条件のリクエスト
    # パラメータ取得
    # my $params = $self->req->params->to_hash;

    my $params = +{hoge => 10};
    # パラメータ有るとき条件指定
    my @account_all;
    if (%{$params}) {
        # die Dumper $params;
        $cond = +{
            id => 1,
        };
    }
    else {
        # 全ての値を表示
    }
    @account_all = $model->search($table, $cond);


    # パラメータ無いとき全て実行

    # 条件の定義


    # 検索

    my $account_hash = [ map {$_->get_columns} @account_all ];

    # 検索結果のレスポンス
    $self->stash(account_hash => $account_hash);
    return $self->render(template => 'setting/account_search');
}

sub profile_edit {
    my $self = shift;

    return $self->render(template => 'setting/profile_edit');
}

sub profile_search {
    my $self = shift;

    return $self->render(template => 'setting/profile_search');
}

1;
