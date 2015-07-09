#!/usr/bin/perl

use strict;
use warnings;
use feature qw/say/;
use Getopt::Long qw/GetOptionsFromArray/;
use Pod::Usage;
use Test::More;
use Data::Dumper; # TODO safe to remove after testing.

my $VERSION = "0.01";

=head1 NAME

nhw - A generic Perl script template

=head1 SYNOPSIS

nhw [-v|--version], [-h|-?|--help], [-t|--test], [-d|--dumpargs]

=head2 OPTIONS

=over 4

=item
[-t|--test]
Run test suite for developing this application

=back

=head1 EXAMPLES

=head1 AUTHOR

Neil H. Watson, http://watson-wilson.ca, C<< <neil@watson-wilson.ca> >>

=head1 LICENSE and COPYRIGHT

The MIT License (MIT)

Copyright (c) 2014 Neil H Watson

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

=cut

#
# Subs
#
sub _get_cli_args
{
   my @args = @_;

   # Set default CLI args here. Getopts will override.
   my %arg = (
      myarg => 'default value',
   );

   GetOptionsFromArray
   (
      \@args,
      \%arg,
      'help|?',
      'version',
      'examples',
      'test',
      'dumpargs',
      'myarg=s',
   )
   or do
   {
      usage( 'USAGE' );
      exit 1;
   };
   return \%arg;
}

sub usage
{
   my $msg = shift;
   my $section;
   if ( $msg =~ m/\AEXAMPLES\Z/ )
   {
      $section = $msg;
   }
   else
   {
      $section = "SYNOPSIS";
   }
   pod2usage(
      -verbose  => 99,
      -sections => "$section",
      -msg      => $msg
   );
   return;
}

#
# Testing
#
sub _run_tests
{
   my %tests = (
      # Name test 't\d\d' to ensure order
      t01 =>
      {
         name => \&_test_doc_help,
         arg  => '',
      },
      t02 =>
      {
         name => \&_test_doc_examples,
         arg  => '',
      }
   );

   my $number_of_tests = keys %tests;

   # Run tests in order
   for my $test ( sort keys %tests )
   {
      $tests{$test}->{name}->( $tests{$test}->{arg} );
   }
   done_testing( $number_of_tests );
   return;
}

sub _test_doc_help
{
   my $help = qx/ $0 -? /;
   ok( $help =~ qr/Usage:.*?Options:/ms,  "[$0] -h, for usage" );
   return;
}

sub _test_doc_examples
{
   my $examples = qx/ $0 -e /;
   ok( $examples =~ qr/EXAMPLES/, "[$0] -e, for usage examples." );
   return;
}

#
# Main matter
#
my $arg = _get_cli_args( @ARGV );

# TODO arg validation here
say '$arg = '. Dumper( $arg ) if ( $arg->{dumpargs} );

# Perhaps a dispatch table?
_run_tests()        if ( $arg->{test} );
usage( 'HELP' )     if ( $arg->{help} );
usage( 'EXAMPLES' ) if ( $arg->{examples} );
say $VERSION        if ( $arg->{version} );
