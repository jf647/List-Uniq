#
# $Id$
#

use strict;
use warnings;

BEGIN {
    use Test::More;
    our $tests = 2;
    eval "use Test::NoWarnings";
    $tests++ unless( $@ );
    plan tests => $tests;
}

use_ok('List::Uniq', ':all');

# make sure that the uniq_sorted wrapper works
my @in = qw|foo bar baz gzonk quux bar quux|;
my $ret1 = uniq( { sorted => 1 }, @in );
my $ret2 = uniq_sorted( @in );
is_deeply $ret1, $ret2, 'uniq_sorted wrapper works';

#
# EOF
