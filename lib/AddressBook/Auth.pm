package AddressBook::Auth;
use Mojo::Base 'Mojolicious::Controller';
use Readonly;

sub login {
    my $self = shift;
    my $model = $self->model;
    # ログイン確認
    if (defined $self->session->{name}) {
        return $self->redirect_to('/');
    }
    # バリデートは今回後回し
    my $mail = $self->param('mail');
    my $pass = $self->param('pass');
    # 入力値でdbに問合せ
    my $admin = $model->single('admin', +{
        mail     => $mail,
        password => $pass,
    });
    # 取得したデータをセッションに渡す
    my $session_name;

    if ($admin) {
      $session_name = $admin->name;
      $self->session(+{
          name => $session_name,
      });

      return $self->redirect_to('/');
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
