#!/usr/bin/env perl

=pod

=head1 SYNOPSIS

This desmonstrates a modulino, a script that runs like a module, allowing for
separate testing scripts.

=cut

package app;

use strict;
use warnings;
use feature qw{ say };
use Getopt::Long;
use Data::Dumper;

sub convert{
   my $val = shift;

   return $val;
}

sub run{
   say "I'm running";
}

GetOptions(
);

# Main matter unless this module was called from another program.
run() unless caller;

1;
