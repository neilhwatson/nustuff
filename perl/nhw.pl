#!/usr/bin/perl

use strict;
use warnings;
use feature qw/say/;
use Pod::Usage;

use Data::Dumper; # TODO safe to remove after testing.

my $VERSION = 0.01;

=head1 NAME

nhw - A generic Perl script template

=head1 SYNOPSIS

nhw [-v|--version], [-h|-?|--help], [-t|--test]

=head2 OPTIONS

=over 4

=item
[-t|--test]
Run test suite for developing this application

=back

=head1 EXAMPLES

=head1 AUTHOR

Neil H. Watson, http://watson-wilson.ca, C<< <neil@watson-wilson.ca> >>

=head1 COPYRIGHT

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
   use Getopt::Long qw/GetOptionsFromArray/;
   my @args = @_;
   my %arg;
   GetOptionsFromArray
   (
      \@args,
      \%arg,
      'help|?',
      'version',
      'examples',
      'test',
   )
   or eval
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
   pod2usage(-verbose=>99,
      -sections=>"$section",
      -msg => $msg
   );
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
   eval q( use Test::More tests => $number_of_tests );

   # Run tests in order
   foreach my $test ( sort keys %tests )
   {
      $tests{$test}->{name}->( $tests{$test}->{arg} );
   }
}

sub _test_doc_help
{
   my $help = qx/ $0 -? /;
   like( $help, qr/Usage:.*?Options:/ms,  "[$0] -h, for usage" );
}

sub _test_doc_examples
{
   my $examples = qx/ $0 -e /;
   like( $examples, qr/EXAMPLES/, "[$0] -e, for usage examples." );
}

#
# Main matter
#
my $argref = _get_cli_args( @ARGV );

# TODO arg validation here

# Perhaps a dispatch table?
_run_tests          if ( $argref->{test} );
usage( 'HELP' )     if ( $argref->{help} );
usage( 'EXAMPLES' ) if ( $argref->{examples} );
say $VERSION        if ( $argref->{version} );

