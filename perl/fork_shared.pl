#!/usr/bin/perl

use strict;
use warnings;
use Cache::FastMmap;
use Test::More tests => 3;

my $shared = Cache::FastMmap->new;

my $child_pid = fork;

# Parent;
if ( $child_pid ) {
   $shared->set( 'parent', 1 );
}
# child
elsif ( $child_pid == 0 ) {
   $shared->set( 'child', 1 );
   exit 0;
}

# Fork another child. First child's data must be returned to parent before
# this. We must fork sequentially. This is blocking.
my $child2_pid =fork;
if ( $child2_pid == 0 ) {
   $shared->set( 'child2', $shared->get( 'child' ) );
   exit 0;
}

waitpid( $child_pid, 0 );
waitpid( $child2_pid, 0 );

ok( $shared->get('parent') == 1, "Parent variable" );
ok( $shared->get('child' ) == 1, "Child variable" );
ok( $shared->get('child2') == 1, "Child2 variable" );

=pod

=head1 SYNOPSIS

Demonstrates sharing data between child and parent.

=cut
