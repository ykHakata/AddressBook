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

    # REST 対応
    $self->hook(
        before_dispatch => sub {
            my $c       = shift;
            my $method  = $c->req->method;
            my $_method = $c->req->param('_method');
            if ( $method eq 'POST' && $_method ) {
                my $methods = [qw/GET POST PUT DELETE/];
                if ( grep { $_ eq $_method } @{$methods} ) {
                    $c->req->method($_method);
                }
            }
        }
    );

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

    # トップページ
    # addressbook/
    # $r->get('/')->to( controller => 'Share', action => 'index' );

    # 公開されているアドレス帳の検索画面
    # addressbook/share
    # $r->get('/share')->to( controller => 'Share', action => 'index' );

  # 公開されているアドレス帳の検索
  # addressbook/share/search
  # $r->get('/share/search')->to( controller => 'Share', action => 'search' );

    # 公開されているアドレス帳詳細情報
    # addressbook/share/10
    # $r->get( '/share/:id' => [ id => qr/\d+/ ] )
    #     ->to( controller => 'Share', action => 'show' );

    # -----

    $r->add_shortcut(
        resource => sub {
            my ( $r, $name ) = @_;

            # ショートカット to(action => 'index') -> to('#index')
            my $resource = $r->any("/$name")->to( controller => $name );

            # 検索入力画面
            $resource->get->to('#index')->name($name);

            # 検索実行
            $resource->get('/search')->to('#search')->name("search_$name");

            # 新規作成入力画面
            $resource->get('/create')->to('#create')->name("create_$name");

            # 新規データ保存
            $resource->post->to('#store')->name("store_$name");

            # 詳細画面
            $resource->get('/:id')->to('#show')->name("show_$name");

            # 更新入力画面
            $resource->get('/:id/edit')->to('#edit')->name("edit_$name");

            # 更新データ保存
            $resource->put('/:id')->to('#update')->name("update_$name");

            # 削除実行
            $resource->delete('/:id')->to('#remove')->name("remove_$name");

            return $resource;
        }
    );

    # 個人が所有しているアドレス帳
    $r->resource('personal');

    # 共用のアドレス帳
    $r->resource('share');

   # 例: personal の場合
   # GET /personal -> ( controller => 'Personal', action => 'index' );
   # GET /personal/search -> ( controller => 'Personal', action => 'search' );
   # GET /personal/create -> ( controller => 'Personal', action => 'create' );
   # POST /personal -> ( controller => 'Personal', action => 'store' );
   # GET /personal/10 -> ( controller => 'Personal', action => 'show' );
   # GET /personal/10/edit -> ( controller => 'Personal', action => 'edit' );
   # PUT /personal/10 -> ( controller => 'Personal', action => 'update' );
   # DELETE /personal/10 -> ( controller => 'Personal', action => 'remove' );

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
