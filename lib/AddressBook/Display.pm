package AddressBook::Display;
use Mojo::Base 'Mojolicious::Controller';
use Readonly;

Readonly my $SPACE     => q{ };
Readonly my $EMPTY_STR => '';

use Data::Dumper;
sub search {
  my $self = shift;
  my $model = $self->model;

  my $address_detail = +{ };

  if (uc $self->req->method eq 'POST') {
      # バリデートは今回後回し
      my $word = $self->param('word');
      #sql問合せ
      my $search = $model->single('address_book_test', +{ first_name => $word, });
      #存在
      if (defined $search) {
          # アドレス詳細
          $address_detail = +{
              id        => $search->id,
              full_name => $search->last_name . $SPACE . $search->first_name,
              tel       => $search->tel,
              mail      => $search->mail,
              zip       => $search->zip,
              pref      => $search->pref,
              city      => $search->city,
              below1    => $search->below1,
              below2    => $search->below2,
          };
      }
  }

    $self->stash(+{
      address_detail => $address_detail,
    });
  
  return $self->render(template => 'display/search');
}

sub all {
  my $self = shift;
  # セッションの確認
  if (! defined $self->session->{name}) {
    return $self->redirect_to('/');
  }
  # sql問合せ全て(削除されていないもの)デリートフラグが0のもの
  my @addresses = $self->model->search('address_book_test', 
    +{delete_flag => 0}, +{order_by => 'last_name'}
  );
  # アドレス詳細
  my $multiple_address_detail = [ map {
    +{
      id        => $_->id,
      full_name => $_->last_name . $SPACE . $_->first_name,
      tel       => $_->tel,
      mail      => $_->mail,
      zip       => $_->zip,
      pref      => $_->pref,
      city      => $_->city,
      below1    => $_->below1,
      below2    => $_->below2,
    }
  } @addresses ];
  # 名前リスト
  my $multiple_name_list = [ map { _index_list($_) } @addresses ];
  # 名前リストの見出し作成
  sub _index_list {
    my $address = shift;
    my $caption = $EMPTY_STR;
    
    state $index_old = $EMPTY_STR;
    
    my $index_new = substr ($address->last_name, 0, 1);
    
    if ($index_new ne $index_old) { $caption = $index_new; }
  
    $index_old = $index_new;
  
    return +{
      id        => $address->id,
      caption   => $caption,
      full_name => $address->last_name . $SPACE . $address->first_name,
    };
  }

  $self->stash( 
    multiple_name_list      => $multiple_name_list,
    multiple_address_detail => $multiple_address_detail,
  );

  return $self->render(template => 'display/all');
}

1;

