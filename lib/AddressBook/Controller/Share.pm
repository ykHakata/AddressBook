package AddressBook::Controller::Share;
use Mojo::Base 'Mojolicious::Controller';

# GET /share -> ( controller => 'Share', action => 'index' );
sub index {
    my $self = shift;
    $self->render( text => 'index' );
    return;
}

# GET /share/search -> ( controller => 'Share', action => 'search' );
sub search {
    my $self = shift;
    $self->render( text => 'search' );
    return;
}

# GET /share/create -> ( controller => 'Share', action => 'create' );
sub create {
    my $self = shift;

    my $html = q{
        <form method="post" action="/share">
        <p><input type="submit" value="新規作成する"></p>
        </form>
    };

    $self->render( text => $html );
    return;
}

# POST /share -> ( controller => 'Share', action => 'store' );
sub store {
    my $self = shift;
    $self->render( text => 'store' );
    return;
}

# GET /share/10 -> ( controller => 'Share', action => 'show' );
sub show {
    my $self = shift;

    my $html = q{
        <form method="post" action="/share/10">
            <input type="hidden" name="_method" value="DELETE">
            <p><input type="submit" value="削除する"></p>
        </form>
    };

    $self->render( text => $html );
    return;
}

# GET /share/10/edit -> ( controller => 'Share', action => 'edit' );
sub edit {
    my $self = shift;

    my $html = q{
        <form method="post" action="/share/10">
            <input type="hidden" name="_method" value="PUT">
            <p><input type="submit" value="更新する"></p>
        </form>
    };

    $self->render( text => $html );
    return;
}

# PUT /share/10 -> ( controller => 'Share', action => 'update' );
sub update {
    my $self = shift;
    $self->render( text => 'update' );
    return;
}

# DELETE /share/10 -> ( controller => 'Share', action => 'remove' );
sub remove {
    my $self = shift;
    $self->render( text => 'remove' );
    return;
}

1;

__END__
