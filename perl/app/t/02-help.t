#!/usr/bin/env perl

=pod

=head1 SYNOPSIS

This tests app's arge.

=cut

use strict;
use warnings;

# Place app's subs in the app:: namespace.
require app;

use Test::More tests => 5;

my $PROGRAM_NAME = 'app.pm';

#
# Run tests
#
cli_help();
cli_version();
cli_usage();
cli_examples();
cli_man();

#
# Tests
#
sub cli_help {
   my $returned_text = qx{ ./$PROGRAM_NAME -? };

   # Test command oupput
   like( $returned_text, qr{ OPTIONS .+ version }xims
      , "[$PROGRAM_NAME] -?, for OPTIONS" );

   return;
}

sub cli_version {
   my $returned_text = qx{ ./$PROGRAM_NAME --version };

   # Test command oupput
   like( $returned_text, qr{ \A \d+ \.? \d* \Z }xims
      , "[$PROGRAM_NAME] --version, for version" );

   return;
}

sub cli_usage{
   my $returned_text = qx{ ./$PROGRAM_NAME --usage };

   # Test command oupput
   like( $returned_text, qr{ Usage: .+ }xims
      , "[$PROGRAM_NAME] --usage for SYNOPSIS" );

   return;
}

sub cli_examples{
   my $returned_text = qx{ ./$PROGRAM_NAME --examples };

   # Test command oupput
   like( $returned_text, qr{ Examples: .+ }xims
      , "[$PROGRAM_NAME] --usage for EXAMPLES " );

   return;
}

sub cli_man{
   my $returned_text = qx{ ./$PROGRAM_NAME --man };

   # Test command oupput
   like( $returned_text, qr{ SYNOPSIS .+ AUTHOR .+ LICENSE }xims
      , "[$PROGRAM_NAME] --man for POD" );

   return;
}
