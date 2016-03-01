#!/usr/bin/env perl

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

# Main matter
run() unless caller;

1;
