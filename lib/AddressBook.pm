package AddressBook;
use Mojo::Base 'Mojolicious';
use Data::Dumper;

# use Teng::Schema::Loader;

sub startup {
    my $self = shift;

    my $home      = $self->home->to_string;
    my $mode      = $self->mode;
    my $moniker   = $self->moniker;
    my $conf_file = qq{$home/etc/$moniker.$mode.conf};

    # 設定ファイル
    $self->plugin( Config => +{ file => $conf_file } );

    # /perldoc
    $self->plugin('PODRenderer');

    my $r = $self->routes;

    # /
    $r->get('/')->to( controller => 'Search', action => 'index' );

    # /search
    $r->get('/search')->to( controller => 'Search', action => 'index' );

    # /login
    $r->get('/login')->to( controller => 'Auth', action => 'login' );
    $r->post('/login')->to( controller => 'Auth', action => 'auth' );

    # /logout
    $r->post('/logout')->to( controller => 'Auth', action => 'logout' );

# $self->helper( model => sub {
#     state $model = Teng::Schema::Loader->load(
#         connect_info => ['dbi:SQLite:./lib/AddressBook/Model/address_book.db','',''],
#         namespace    => 'table_name',
#     );
#     return $model;
# });

    # my $r = $self->routes;

# # サイト全体 開発用
# $r->route('/preview')->to(controller => 'Preview', action => 'list');
# # オープニング検索
# $r->route('/')->to(controller => 'Display', action => 'search');
# # [Auth]ログイン機能
# $r->route('/auth/login')->to(controller => 'Auth', action => 'login');
# $r->route('/auth/logout')->to(controller => 'Auth', action => 'logout');
# # [Setting]設定機能
# $r->route('/setting/account_edit')->to(controller => 'Setting', action => 'account_edit');
# $r->route('/setting/account_search')->to(controller => 'Setting', action => 'account_search');
# $r->route('/setting/profile_edit')->to(controller => 'Setting', action => 'profile_edit');
# $r->route('/setting/profile_search')->to(controller => 'Setting', action => 'profile_search');

    # $r->route('/all')->to(controller => 'Display', action => 'all');
}

1;
