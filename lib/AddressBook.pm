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
    # [Auth]ログイン機能
    $r->route('/auth/login')->to(controller => 'Auth', action => 'login');
    $r->route('/auth/logout')->to(controller => 'Auth', action => 'logout');
    # [Setting]設定機能
    $r->route('/setting/account_edit')->to(controller => 'Setting', action => 'account_edit');
    $r->route('/setting/account_search')->to(controller => 'Setting', action => 'account_search');
    $r->route('/setting/profile_edit')->to(controller => 'Setting', action => 'profile_edit');
    $r->route('/setting/profile_search')->to(controller => 'Setting', action => 'profile_search');

    $r->route('/all')->to(controller => 'Display', action => 'all');
}

1;
