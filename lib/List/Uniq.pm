#
# $Id$
#

=head1 NAME

List::Uniq - extract the unique elements of a list

=head1 SYNOPSIS

  use List::Uniq ':all';

  @uniq = uniq(@list);
  @uniq = uniq_sorted(@sorted);

  $list = [ qw|foo bar baz foo| ];
  $uniq = uniq($list);

=head1 DESCRIPTION

List::Uniq extracts the unique elements of a list.  This is a commonly
re-written (or at least re-looked-up) idiom in Perl programs.

=cut

package List::Uniq;
use base 'Exporter';

use strict;
use warnings;

our $VERSION = '0.10';

# set up exports
our @EXPORT;
our @EXPORT_OK;
our %EXPORT_TAGS;
$EXPORT_TAGS{all} = [ qw|uniq uniq_sorted| ];
Exporter::export_ok_tags('all');

=head1 FUNCTIONS

=head2 uniq( { OPTIONS }, ele1, ele2, ..., eleN )

uniq() takes a list (or reference to a list) of elements and returns the
unique elements of the list.  The return value is a list of the unique
elements if called in list context or a reference to a list of unique
elements if called in scalar context.

Each element may be a scalar value or a reference to a list.  List
references will be flattened before the unique filter is applied.

If the first element is a hash reference it is taken to be a set of options
that alter the way in which the unique filter is applied.  The keys of the
option set are:

=over 4

=item * sorted

If set to a true value, the elements of the list are presumed to be
pre-sorted.  This allows the use of a technique that uses less memory but
only eliminates adjacent duplicates (as with the B<uniq> command).

=item * sort

If set to a true value, the unique elements of the list will be returned
sorted.  Perl's default sort will be used unless the B<compare> option is
also passed.  If the B<sorted> option is set, any value of this option is
ignored, as the technique used in that case does not shuffle the elements.

=item * compare

A code reference that will be used to sort the elements of the list if the
B<sort> option is set.  Passing a non-coderef will cause B<uniq> to throw an
exception.

=back

sub uniq
{

    # check for options
    my $options;
    if( ref $_[0] eq 'HASH' ) {
        $options = shift @_;
    }

    # flatten list references
    my @elements;
    
    # dispatch to the proper technique based upon options
    
    # sort before returning if so desired
    if( $opts{sort} ) {
        if( $opts{compare} ) {
            unless( 'CODE' eq ref $opts{compare} ) {
                require Carp;
                Carp::croak "compare option is not a coderef";
            }
            @elements = sort $opts{compare} @elements;
        }
        else {
            @elements = sort @elements;
        }
    }
    
    # return a list or list reference based on calling context
    return wantarray ? @elements : \@elements;

}

=head2 uniq_sorted()

This is a convenience function that acts the same as:

  uniq( { sorted => 1 }, @list );

=cut

sub uniq_sorted { uniq( { sorted => 1 }, @_ ) }

# keep require happy
1;


__END__


=head1 EXAMPLES

=head1 EXPORTS

Nothing by default.

Optionally the B<uniq> and B<uniq_sorted> functions.

Everything with the B<:all> tag.

=head1 SEE ALSO

If you want to unique a list as you insert into it, see L<Array::Unique> by
Gabor Szabo.

This module was written out of a need to unique an array that was
auto-vivified and thus not easily tied to Array::Unique.

=head1 AUTHOR

James FitzGibbon, Primus Telecommunications Canada Inc.
<jfitzgibbon@primustel.ca>

=head1 CREDITS

The idioms used to unique lists are taken from recipe 4.7 in the I<Perl
Cookbook, 2e.>, published by O'Reilly and Associates and from the Perl FAQ
section 5.4.

I pretty much just glued it together in a way that I find easy to use. 
Hopefully you do too.

=head1 COPYRIGHT

Copyright (c) 2004 Primus Telecommunications Canada Inc.
All Rights Reserved.

This library is free software; you may use it under the same
terms as perl itself.

=cut

#
# EOF
