package AddressBook::Auth;
use Mojo::Base 'Mojolicious::Controller';
use Readonly;
use FormValidator::Lite qw{Email};
use Data::Dumper;
sub login {
    my $self = shift;
    my $model = $self->model;
    # ログイン確認
    if (defined $self->session->{name}) {
        return $self->redirect_to('/');
    }
    # バリデートの為の改訂
    # postリクエストのみ,getの場合は無視
    if (uc $self->req->method eq 'POST') {
        # パラメーターを全て取得
        my $params = $self->req->params->to_hash;
        # バリデータのインスタンスを作成
        my $validator = FormValidator::Lite->new($self->req);
        # 入力値の存在確認
        my $res = $validator->check(
            mail => ['REQUIRED', 'EMAIL', 'NOT_NULL'],
            pass => ['REQUIRED', 'NOT_NULL'],
        );
        # バリデータ不合格の処置
        if ($validator->has_error) {
            # $self->stash(
            #     errors => Dumper($validator->errors()),
            # );
            # my $html = $self->render(template => 'auth/admin_login', partial => 1)->to_string;
            # $html = HTML::FillInForm->fill(\$html, $params,);
            # return $self->render(template => 'auth/admin_login', text => $html , format => 'html');
            # 開発中につきコンソールにwarnでメッセージ吐き出し
            # エラー内容を吐き出す 
            warn "error! validator!! : " . Dumper($validator->errors());
            return $self->render(template => 'auth/login');
        }
        # バリデータ合格の処置 存在確認
        my $admin = $model->single('admin', +{
            mail     => $params->{mail},
            password => $params->{pass},
        });
        # 存在の場合、セッション書き込みトップ画面遷移
        if (defined $admin) {
            $self->session(+{
                name => $admin->name,
            });
            return $self->redirect_to('/');
        }
        else {
        # 存在しない場合、エラーメッセージ表示
            # $self->stash(
            # errors => '存在しません',
            # );
            # my $html = $self->render(template => 'auth/admin_login', partial => 1)->to_string;
            # $html = HTML::FillInForm->fill(\$html, $params);
            # return $self->render(template => 'auth/admin_login', text => $html, format => 'html');
            # 開発中につきwarnでメッセージ吐き出し
            warn "error! Not exist!!";
            return $self->render(template => 'auth/login');
        }
    }

    return $self->render(template => 'auth/login');
}

sub logout {
    my $self = shift;
    # ログイン確認,セッション破棄
    if (defined $self->session->{name}) {
        $self->session(expires => 1);
        return $self->redirect_to('/');
    }
    else {
        return $self->redirect_to('/');
    }
}

1;
