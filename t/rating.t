use strict;
use warnings;

use lib 't/lib';
use Test::More tests => 4;
use Test::Fatal;
use TestFunctions;

my $mcpan = mcpan();

isa_ok( $mcpan, 'MetaCPAN::API' );
can_ok( $mcpan, 'rating'        );
my $errmsg = qr/^Either provide 'id' or 'search'/;

# missing input
like(
    exception { $mcpan->rating },
    $errmsg,
    'Missing any information',
);

# incorrect input
like(
    exception { $mcpan->rating( ding => 'dong' ) },
    $errmsg,
    'Incorrect input',
);

#my $result = $mcpan->rating('UC6tqabqR-y3xxZk0tgVXQ');
#ok( $result, 'Got result' );
#
#$result = $mcpan->rating( id => 'UC6tqabqR-y3xxZk0tgVXQ' );
#ok( $result, 'Got result' );
#
#my $result = $mcpan->rating(
#    search => {
#        filter => "distribution:Moose",
#        fields => [ "date", "rating" ],
#    },
#);
#ok( $result, 'Got result' );
