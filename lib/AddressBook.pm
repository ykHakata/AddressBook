package AddressBook;
use Mojo::Base 'Mojolicious';
use Teng::Schema::Loader;


sub startup {
    my $self = shift;
    # model(Teng)
    $self->helper( model => sub {
        state $model = Teng::Schema::Loader->load(
            connect_info => ['dbi:SQLite:./lib/AddressBook/Model/address_book.db','',''],
            namespace    => 'table_name',
        );
        return $model;
    });
    # Router
    my $r = $self->routes;

    # サイト全体 開発用
    $r->route('/preview')->to(controller => 'Preview', action => 'list');
    # オープニング検索
    $r->route('/')->to(controller => 'Display', action => 'search');

    $r->route('/login')->to(controller => 'Auth', action => 'login');
    $r->route('/logout')->to(controller => 'Auth', action => 'logout');

#     $r->route('/member/create')->to(controller => 'member', action => 'create');

#     $r->get('/welcome')->to(controller => 'example', action => 'welcome');
    $r->route('/all')->to(controller => 'Display', action => 'all');
#     $r->route('/keyword')->to(controller => 'Display', action => 'keyword');
#     $r->route('/icon')->to(controller => 'Display', action => 'icon');

}

1;
