package AddressBook::Manager;
use Mojo::Base 'Mojolicious::Controller';
use Readonly;
use Data::Dumper;

Readonly my $SPACE     => q{ };
Readonly my $EMPTY_STR => '';

sub myadmin {
    my $self = shift;

    return $self->render(template => 'manager/myadmin');
}

sub list {
    my $self = shift;

    $self->flash(logout => 'logout Thanks!');

    return $self->render(template => 'manager/list');
}

1;
