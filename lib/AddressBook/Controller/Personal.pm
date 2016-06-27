package AddressBook::Controller::Personal;
use Mojo::Base 'Mojolicious::Controller';

# GET /personal -> ( controller => 'Personal', action => 'index' );
sub index {
    my $self = shift;
    $self->render( text => 'index' );
    return;
}

# GET /personal/search -> ( controller => 'Personal', action => 'search' );
sub search {
    my $self = shift;
    $self->render( text => 'search' );
    return;
}

# GET /personal/create -> ( controller => 'Personal', action => 'create' );
sub create {
    my $self = shift;

    my $html = q{
        <form method="post" action="/personal">
        <p><input type="submit" value="新規作成する"></p>
        </form>
    };

    $self->render( text => $html );
    return;
}

# POST /personal -> ( controller => 'Personal', action => 'store' );
sub store {
    my $self = shift;
    $self->render( text => 'store' );
    return;
}

# GET /personal/10 -> ( controller => 'Personal', action => 'show' );
sub show {
    my $self = shift;

    my $html = q{
        <form method="post" action="/personal/10">
            <input type="hidden" name="_method" value="DELETE">
            <p><input type="submit" value="削除する"></p>
        </form>
    };

    $self->render( text => $html );
    return;
}

# GET /personal/10/edit -> ( controller => 'Personal', action => 'edit' );
sub edit {
    my $self = shift;

    my $html = q{
        <form method="post" action="/personal/10">
            <input type="hidden" name="_method" value="PUT">
            <p><input type="submit" value="更新する"></p>
        </form>
    };

    $self->render( text => $html );
    return;
}

# PUT /personal/10 -> ( controller => 'Personal', action => 'update' );
sub update {
    my $self = shift;
    $self->render( text => 'update' );
    return;
}

# DELETE /personal/10 -> ( controller => 'Personal', action => 'remove' );
sub remove {
    my $self = shift;
    $self->render( text => 'remove' );
    return;
}

1;

__END__
