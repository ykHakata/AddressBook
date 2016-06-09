package AddressBook::Controller::Search;
use Mojo::Base 'Mojolicious::Controller';
use Data::Page::Navigation;
use HTML::FillInForm;
use Data::Dumper;

sub index {
    my $self = shift;

    my $params = $self->req->params->to_hash;
    my @words = split '', $params->{q};

    # ページャー情報作成
    my $pager = $self->create_pager( \@words, $params );

    # 出力する検索結果のデーター構造作成
    my $search_list = $self->create_search_list( \@words, $pager );

    $self->stash( search_list => $search_list );
    $self->stash( pager       => $pager );

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
    my $icon_list = $self->_icon_list;
    for my $word ( @{$words} ) {
        my $icon = shift @{$icon_list};
        push @{ $word_data->[$count_row] },
            +{
            icon  => $icon,
            title => $word,
            };
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

sub _icon_list {
    my $self = shift;
    my $icon = [
        q{18_YukioKusakabe.png}, q{icon_158150_256.png},
        q{icon_158160_256.png},  q{icon_158580_256.png},
        q{icon_158840_256.png},  q{icon_158850_256.png},
        q{icon_158860_256.png},  q{icon_159080_256.png},
        q{icon_159090_256.png},  q{icon_159100_256.png},
        q{icon_159890_256.png},  q{icon_160440_256.png},
        q{icon_160450_256.png},  q{icon_161720_256.png},
        q{icon_161770_256.png},  q{icon_161780_256.png},
        q{icon_162270_256.png},  q{icon_162280_256.png},
        q{icon_162290_256.png},  q{icon_162530_256.png},
        q{icon_162550_256.png},  q{icon_162570_256.png},
    ];
    return $icon;
}

1;
