package AddressBook::Controller::Search;
use Mojo::Base 'Mojolicious::Controller';
use Data::Page::Navigation;
use HTML::FillInForm;
use Data::Dumper;

sub index {
    my $self = shift;

    my $url_path   = q{/search};
    my $url_public = '';
        if ( $self->app->mode ne 'local' ) {
        $url_path   = q{/AddressBook/script/address_book.cgi} . $url_path;
        $url_public = q{/AddressBook/public};
    }

    my $params = $self->req->params->to_hash;
    my @words = split '', $params->{q};

    # ページャー情報作成
    my $pager = $self->create_pager( \@words, $params );

    # 出力する検索結果のデーター構造作成
    my $search_list = $self->create_search_list( \@words, $pager );

    $self->stash( search_list => $search_list );
    $self->stash( pager       => $pager );
    $self->stash( url_path    => $url_path );
    $self->stash( q           => $params->{q} );
    $self->stash( url_public  => $url_public );

    my $html = $self->render_to_string->to_string;
    my $output = HTML::FillInForm->fill( \$html, $params );
    $self->render( text => $output );
    return;
}

# 出力する検索結果のデーター構造作成
sub create_search_list {
    my $self  = shift;
    my $words = shift;
    my $pager = shift;

    my $word_data = [];
    my $count     = $pager->entries_per_page;
    my $count_row = 0;

    for my $word ( @{$words} ) {
        push @{ $word_data->[$count_row] }, $word;
        $count -= 1;
        if ( !$count ) {
            $count = $pager->entries_per_page;
            $count_row += 1;
        }
    }

    my $output_page_index = $pager->current_page - 1;
    my $search_list       = $word_data->[$output_page_index];

    return $search_list;
}

# ページャーオブジェクト作成
sub create_pager {
    my $self   = shift;
    my $words  = shift;
    my $params = shift;
    my $page   = $params->{page};

    # ページャーオブジェクト
    my $pager = Data::Page->new();

    # すべての検索結果の件数を取得
    my $total_entries = scalar @{$words};
    $pager->total_entries($total_entries);

    # 1ページあたりの表示件数を設定
    my $entries_per_page = 5;
    $pager->entries_per_page($entries_per_page);

    # 1ページに表示されるページ番号の数
    my $pages_per_navigation = 5;
    $pager->pages_per_navigation($pages_per_navigation);

    # 現在のページ
    my $current_page = 1;
    if ($page) {
        $current_page = $page;
    }
    $pager->current_page($current_page);

    return $pager;
}

1;
