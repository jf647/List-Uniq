#
# $Id$
#

use strict;
use warnings;

BEGIN {
    use Test::More;
    our $tests = 5;
    eval "use Test::NoWarnings";
    $tests++ unless( $@ );
    plan tests => $tests;
}

use_ok('List::Uniq', ':all');

# make sure that a presorted list works properly
my @in       = sort qw|foo bar baz quux gzonk bar quux|;
my @expected = qw|bar baz foo gzonk quux|;
my @ret      = uniq( { sorted => 1 }, @in );
is_deeply \@ret, \@expected, 'pre-sorted lists work';

# make sure that if we pass an unsorted list but tell the function that it
# is sorted, it won't work
@in        = qw|foo bar baz quux gzonk bar quux|;
my @sorted = sort @in;
@ret       = uniq( { sorted => 1 }, @in );
is_deeply \@ret, \@in, 'pre-sorted lists that are not sorted break correctly';
ok ! is_deeply \@ret, \@sorted, 'return does not match (which is correct)';

#
# EOF
