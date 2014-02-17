package AddressBook;
use Mojo::Base 'Mojolicious';
use Teng::Schema::Loader;


sub startup {
    my $self = shift;

    $self->helper( model => sub {
        state $model = Teng::Schema::Loader->load(
            connect_info => ['dbi:SQLite:./lib/AddressBook/Model/address_book.db','',''],
            namespace    => 'table_name',
        );
        return $model;
    });

    my $r = $self->routes;

    # サイト全体 開発用
    $r->route('/preview')->to(controller => 'Preview', action => 'list');
    # オープニング検索
    $r->route('/')->to(controller => 'Display', action => 'search');

    $r->route('/login')->to(controller => 'Auth', action => 'login');
    $r->route('/logout')->to(controller => 'Auth', action => 'logout');

    $r->route('/all')->to(controller => 'Display', action => 'all');
}

1;
