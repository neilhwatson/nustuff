#!/usr/bin/perl

=pod

=head1 SYNOPSIS

Test the contents of a URL using Mojo::UserAgent.

=cut

use strict;
use warnings;
use Mojo::UserAgent;
use Test::More tests => 2;

# URL from command line arg
my $url = $ARGV[0];

# Make user agent object and get URL
my $ua = Mojo::UserAgent->new;
my $contents = $ua->get( $url );

# Test get and returned contents
ok( $contents->success, "Test for successful Get" );
like( $contents->res->body, qr/infomart demo by Neil Watson/ism, "Test contents" );

done_testing;
