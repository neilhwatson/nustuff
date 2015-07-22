#!/usr/bin/perl

use strict;
use warnings;
use feature qw/say/;
use Getopt::Long qw/GetOptionsFromArray/;
use Pod::Usage;
use Test::More;
use English;
use Data::Dumper; # TODO safe to remove after testing.

my $VERSION = 1;

#
# Subs
#
sub _get_cli_args {

   # Set default CLI args here. Getopts will override.
   my $cli_arg_ref = {
      myarg => 'default',
   };

   # To validate inputs
   my $valid_arg_ref = {
      myarg => {
         constraint => sub {
            my ( $val ) = @_; return ( $val =~ m/\A\w+\Z/ )
         },
         error      => 'myarg is invalid'
      },
      arg2 => {
         constraint => qr/\A[0|1]\Z/,
         error      => 'arg2 is invalid'
      }
   };

   GetOptions(
      $cli_arg_ref,
      'myarg=s',
      'arg2=i',

      'version'  => sub { say $VERSION; exit                            },
      'test'     => sub { _run_tests()                                  },
      'man'      => sub { pod2usage( -verbose => 2, -exitval => 0 )     },

      'dumpargs' => sub {
         say '$cli_arg_ref = '. Dumper( $cli_arg_ref ); exit
      },
      'help|?'   => sub {
         pod2usage( -sections => ['OPTIONS'], -exitval => 0, -verbose => 99)
      },
      'usage'    => sub {
         pod2usage( -sections => ['SYNOPSIS'], -exitval => 0, -verbose => 99)
      },
      'examples' => sub {
         pod2usage( -sections => 'EXAMPLES', -exitval => 0 , -verbose => 99)
      },
   );

   usage({ msg => "No args given", exit => 1 }) unless $cli_arg_ref;

   _validate_cli_args({
         cli_inputs   => $cli_arg_ref,
         valid_inputs => $valid_arg_ref
   });

   return $cli_arg_ref;
}

sub _validate_cli_args {
   my ( $arg ) = @_;

   my $cli         = $arg->{cli_inputs};
   my $valid_input = $arg->{valid_inputs};
   my $errors      = q{};

   for my $arg ( keys %{ $cli }) {
      if ( defined $valid_input->{$arg} ) {
         my $constraint = $valid_input->{$arg}->{constraint};
         my $error      = $valid_input->{$arg}->{error};
         my $ref        = ref $constraint;

         if ( $ref eq 'CODE' ) {
            $errors
               .= "\n" . $error unless ( ${constraint}->( $cli->{$arg} ) );
         }
         elsif ( $ref eq 'Regexp' ) {
            $errors .= "\n" . $error unless ( $cli->{$arg} =~ $constraint );
         }
      }
   }
   pod2usage( -msg => $errors, -exitval => 2 ) if length $errors > 0;
   return 1;
}

#
# Testing
#
sub _run_tests {
   my %tests = (
      # Name test 't\d\d' to ensure order
      t01 => {
         name => \&_test_doc_help,
         arg  => q{},
      },
      t02 => {
         name => \&_test_doc_usage,
         arg  => q{},
      },
      t03 => {
         name => \&_test_doc_examples,
         arg  => q{},
      }
   );

   my $number_of_tests = keys %tests;

   # Run tests in order
   for my $test ( sort keys %tests ) {
      $tests{$test}->{name}->( $tests{$test}->{arg} );
   }
   done_testing( $number_of_tests );
   return;
}

sub _test_doc_help {
   my $returned_text = qx/ $PROGRAM_NAME -? /;
   like( $returned_text, qr/Options:.+test/ims
      , "[$PROGRAM_NAME] -h, for help" );
   return;
}

sub _test_doc_usage {
   my $returned_text = qx/ $PROGRAM_NAME -u /;
   like( $returned_text, qr/Usage.+usage/ims
      , "[$PROGRAM_NAME] -u, for usage." );
   return;
}

sub _test_doc_examples {
   my $returned_text = qx/ $PROGRAM_NAME -e /;
   like( $returned_text, qr/Examples:.+/ims
      , "[$PROGRAM_NAME] -e, for examples." );
   return;
}

#
# Main matter
#
my $cli_arg_ref = _get_cli_args();

#
# POD
#
=head1 NAME

nhw - A generic Perl script template

=head1 SYNOPSIS

nhw [-v|--version], [-h|-?|--help], [-u|--usage ], [-t|--test], [-d|--dumpargs]

=head1 OPTIONS

=over 4

=item
[-t|--test]
Run test suite for developing this application.

=item
[-d|--dumpargs]
Dump cli args to stdout for development testing.

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
