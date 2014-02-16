package AddressBook::Member;
use Mojo::Base 'Mojolicious::Controller';
use Readonly;

Readonly my $SPACE     => q{ };
Readonly my $EMPTY_STR => '';

# use Data::Dumper;
sub list {
  my $self = shift;

  return $self->render(template => 'member/list');
}

sub create {
  my $self = shift;
  
  return $self->render(template => 'member/create');
}

sub modify {
  my $self = shift;
  
  return $self->render(template => 'member/modify');
}

1;
