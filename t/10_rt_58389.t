#
# $Id: 05_basic.t 4065 2004-11-01 15:38:09Z james $
#

use strict;
use warnings;

use Test::More tests => 2;

use_ok('List::Uniq', ':all');

# https://rt.cpan.org/Ticket/Display.html?id=58389
# reported by Kevin Ryde
# array refs following empty array refs are not flattened
is_deeply scalar uniq('foo', 'bar', [], ['foo'], 'quux'),
    [ qw|foo bar quux| ], 'array refs following empty array refs';

#
# EOF
