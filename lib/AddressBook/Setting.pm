package AddressBook::Setting;
use Mojo::Base 'Mojolicious::Controller';
# use Readonly;
# use FormValidator::Lite qw{Email};
# use HTML::FillinForm;
use Data::Dumper;

sub account_edit {
    my $self = shift;

    return $self->render(template => 'setting/account_edit');
}

sub account_search {
    my $self = shift;

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
