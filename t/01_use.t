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

use_ok('List::Uniq');
is($List::Uniq::VERSION, '0.10', 'check module version');

#
# EOF
