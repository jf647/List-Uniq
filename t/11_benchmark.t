#
# $Id$
#

use strict;
use warnings;

use IO::File;

BEGIN {
    use Test::More;
    eval "use Test::Benchmark 0.003";
    plan skip_all => "Test::Benchmark 0.003 required for benchmarking" if $@;
    our $tests = 2;
    eval "use Test::NoWarnings";
    $tests++ unless( $@ );
    plan tests => $tests;
}
BEGIN {
    chdir 't' if -d 't';
}


use_ok('List::Uniq', ':all');

# read in our worklist
my @words;
my $fh = IO::File->new('11_wordlist');
while( <$fh> ) {
    chomp;
    push @words, $_;
}
$fh->close;

# sort the wordlist to be safe
@words = sort @words;

# make sure that the presorted technique is really faster
my $t = Test::Builder->new;
$t->diag('benchmark testing for 10 CPU seconds');
is_faster -10, \&presorted, \&noassume,
    'presorted technique is faster';

# the two worker subs
sub presorted
{
    my @words = @_;
    my @ret = uniq( { sorted => 1 }, @words );
}

sub noassume
{
    my @words = @_;
    my @ret = uniq(@words);
}

#
# EOF
