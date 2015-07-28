#!/usr/bin/perl

use strict;
use warnings;
use feature qw/say/;
use Getopt::Long;
use Pod::Usage;
use Test::More;
use English qw/ -no_match_vars/;
use Data::Dumper;
use Carp;
my $VERSION = 1;

#
# Subs
#
sub _get_cli_args {

   # Set default CLI args here. Getopts will override.
   my $cli_arg_ref = {
      myarg => 'default', # Sample can be removed
   };

   # Define ways to valid your arguments using anonymous subs or regexes.
   # These are samples that you can remove.
   my $valid_arg_ref = {
      myarg => {
         constraint => sub {
            my ( $val ) = @_; return ( $val =~ m/\A \w+ \z/xms )
         },
         error      => 'Myarg must be a single word with no odd symbols.'
      },
      arg2 => {
         constraint => qr/\A [01] \z/xms,
         error      => 'Arg2 can only be 0 or 1.'
      }
   };

   # Read, process, and validate cli args
   GetOptions(
      $cli_arg_ref,

      # These two samples can be removed
      'myarg=s',
      'arg2=i',

      'version'  => sub { say $VERSION; exit                            },
      'test'     => sub { _run_tests(); exit                            },
      'man'      => sub { pod2usage( -verbose => 2, -exitval => 0 )     },

      'dumpargs' => sub {
         say '$cli_arg_ref = '. Dumper( $cli_arg_ref ); exit
      },
      'help|?'   => sub {
         pod2usage( -sections => ['OPTIONS'],  -exitval => 0, -verbose => 99)
      },
      'usage'    => sub {
         pod2usage( -sections => ['SYNOPSIS'], -exitval => 0, -verbose => 99)
      },
      'examples' => sub {
         pod2usage( -sections => 'EXAMPLES',   -exitval => 0, -verbose => 99)
      },
   );

   # Futher, more complex cli arg validation
   _validate_cli_args({
         cli_inputs   => $cli_arg_ref,
         valid_inputs => $valid_arg_ref
   });

   return $cli_arg_ref;
}

sub _validate_cli_args {
   my ( $arg )     = @_;
   my $cli         = $arg->{cli_inputs};
   my $valid_input = $arg->{valid_inputs};
   my $errors      = q{};

   # Process cli args and test against the given contraint
   for my $arg ( keys %{ $cli }) {
      if ( defined $valid_input->{$arg} ) {
         my $constraint = $valid_input->{$arg}->{constraint};
         my $error      = $valid_input->{$arg}->{error};
         my $ref        = ref $constraint;

         # Test when constraint is a code reference.
         if ( $ref eq 'CODE' ) {
            $errors
            .= "\n" . $error unless ( ${constraint}->( $cli->{$arg} ) );
         }

         # Test when contraint is a regular expression.
         elsif ( $ref eq 'Regexp' ) {
            $errors .= "\n" . $error unless ( $cli->{$arg} =~ $constraint );
         }
      }
   }

   # Report any invalid cli args 
   pod2usage( -msg => 'Error '.$errors, -exitval => 2 ) if length $errors > 0;

   return 1;
}

#
# Testing
#
sub _run_tests {

   # Define test subs and sub arguments.
   my %test = (
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
      },

      # These two samples can be removed
      t04 => {
         name => \&_test_cli_myarg_failure,
         arg  => q{wrong arg},
      },
      t05 => {
         name => \&_test_cli_arg2_failure,
         arg  => 2,
      },
   );
   my $number_of_tests = keys %test;

   # Run tests in order
   for my $next_test ( sort keys %test ) {
      $test{$next_test}->{name}->( $test{$next_test}->{arg} );
   }

   done_testing( $number_of_tests );

   return;
}

# Test that program returns general help
sub _test_doc_help {

   # Get command output
   my $returned_text = qx{ $PROGRAM_NAME -? };

   # Test command oupput
   like( $returned_text, qr{ Options: .+ test }xims
      , "[$PROGRAM_NAME] -h, for help" );

   return;
}

# Test that program returns usage
sub _test_doc_usage {
   
   # Get command output
   my $returned_text = qx/ $PROGRAM_NAME -u /;

   # Test command oupput
   like( $returned_text, qr{ Usage .+ usage }ixms
      , "[$PROGRAM_NAME] -u, for usage." );

   return;
}

# Test that examples documentation is returned
sub _test_doc_examples {

   # Get command output
   my $returned_text = qx/ $PROGRAM_NAME -e /;

   # Test command oupput
   like( $returned_text, qr{ Examples: .+ }ixms
      , "[$PROGRAM_NAME] -e, for examples." );

   return;
}

# These to sample test subs can be remove.
# Test error when cli arg myarg is wrong
sub _test_cli_myarg_failure {
   my $arg = shift;

   # Get command output
   my $returned_text = qx{ $PROGRAM_NAME -myarg '$arg' 2>&1 };

   # Test command oupput
   like( $returned_text, qr{ Error \s+ myarg \s+ must \s+ be }xmis,
      'Error message myarg is invalid');
}

# Test error when cli arg myarg is wrong
sub _test_cli_arg2_failure{
   my $arg = shift;

   # Get command output
   my $returned_text = qx{ $PROGRAM_NAME -arg2 $arg 2>&1 };

   # Test command oupput
   like( $returned_text, qr{ Error \s+ arg2 \s+ can \s+ only \s+ be }xmis,
      'Error message arg2 is invalid');
}

#
# Main matter
#
my $cli_arg_ref = _get_cli_args();

__END__

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
