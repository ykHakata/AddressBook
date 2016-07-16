package AddressBook::Controller::Auth;
use Mojo::Base 'Mojolicious::Controller';
use HTML::FillInForm;
use Data::Dumper;

has [qw{mail password}];

sub auth {
    my $self = shift;

    my $params = $self->req->params->to_hash;

    my $auth_model = AddressBook::Controller::Auth->new($params);

    if ( $auth_model->_is_auth ) {

        # セッション書き込み
        $self->session( $auth_model->_get_session_params );
        $self->redirect_to('/personal');
        return;
    }

    $self->stash( template => 'auth/login', );

    my $html = $self->render_to_string->to_string;
    my $output = HTML::FillInForm->fill( \$html, $params );
    $self->render( text => $output );
    return;
}

sub _is_auth {
    my $self = shift;

    # dummy
    my $auth = +{
        mail     => 'yosizuka1@gmail.com',
        password => '0520',
    };

    return if !$self->mail;
    return if !$self->password;

    if (   $self->mail eq $auth->{mail}
        && $self->password eq $auth->{password} )
    {
        return 1;
    }
    return;
}

sub _get_session_params {
    my $self = shift;
    my $session_params = +{ mail => $self->mail, };
    return $session_params;
}

sub login {
    my $self = shift;

    return;
}

sub logout {
    my $self = shift;

    $self->session( expires => 1 );

    return;
}

1;

__END__
