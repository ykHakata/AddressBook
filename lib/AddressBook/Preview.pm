package AddressBook::Preview;
use Mojo::Base 'Mojolicious::Controller';
use Readonly;

Readonly my $SPACE     => q{ };
Readonly my $EMPTY_STR => '';

# use Data::Dumper;
sub list {
  my $self = shift;
     $self->flash(logout => 'logout Thanks!');

  return $self->render(template => 'list');
}


1;
