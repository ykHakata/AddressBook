use Mojo::Base -strict;
use Test::More;
use Test::Mojo;
use Data::Dumper;

# testing モードでのみの実行を許可
my $t = Test::Mojo->new('AddressBook');
die 'not testing mode!' if 'testing' ne $t->app->mode;

=encoding utf8

=head2 method

    startup

=cut

subtest 'startup' => sub {

    subtest 'plugin' => sub {
        my $conf = $t->app->config;
        ok( exists $conf->{url_public}, 'config check' );

        # perldoc
        $t->get_ok('/perldoc')->status_is(200);
    };

    subtest 'router' => sub {

        # 302リダイレクトレスポンスの許可
        $t->ua->max_redirects(1);
        my $urls = _url_all();

        for my $url ( @{ $urls->{urls_get} } ) {
            $t->get_ok($url)->status_is(200);
        }

        for my $url ( @{ $urls->{urls_post} } ) {
            $t->post_ok($url)->status_is(200);
        }

        for my $url ( @{ $urls->{urls_put} } ) {
            $t->put_ok($url)->status_is(200);
        }

        for my $url ( @{ $urls->{urls_delete} } ) {
            $t->delete_ok($url)->status_is(200);
        }

        $t->ua->max_redirects(0);
    };
};

sub _url_all {

    my $urls = +{
        urls_get => [
            qw{/ /login
                /share /share/search /share/create /share/3 /share/3/edit
                /personal /personal/search /personal/create /personal/3 /personal/3/edit}
        ],
        urls_post   => [qw{/login /logout /personal /share}],
        urls_put    => [qw{/personal/3 /share/3}],
        urls_delete => [qw{/personal/3 /share/3}],
    };
    return $urls;
}

done_testing();

__END__
