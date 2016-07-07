#!/usr/bin/env perl

=pod

=head1 SYNOPSIS

This is a test script can tests parts of the app.pm modulino. You can run
it stand alone or using prove.

In this test we test only the convert subroutine.

=cut

use strict;
use warnings;

# Place app's subs in the app:: namespace.
require app;

use Test::More tests => 1;

# Test results of app sub
my $input = 'myvalue';
my $expected_output = qr{ \A myvalue \Z }msx;
like( app::convert( $input ), $expected_output, "Test convert subroutine" );
