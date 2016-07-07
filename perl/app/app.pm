#!/usr/bin/env perl

package app;

use strict;
use warnings;
use feature qw{ say };
use Pod::Usage;
use Getopt::Long qw{ GetOptionsFromArray };
use Data::Dumper;
use Params::Validate qw{ :all };

my $VERSION = 1;
my ( $CLI_ARG_REF );

#
# Subs
#
# This sub is used only as a testing example
sub convert{
   my $val = shift;

   return $val;
}

sub _get_standard_args {

   # These are standard args that any program should have.
   
   my $std_cli_arg_ref = {
      'version'  => sub { say $VERSION; exit                        },
      'man'      => sub { pod2usage( -verbose => 2, -exitval => 0 ) },

      'help|?'   => sub {
         pod2usage( -sections => ['OPTIONS'],  -exitval => 0, -verbose => 99)
      },
      'usage'    => sub {
         pod2usage( -sections => ['SYNOPSIS'], -exitval => 0, -verbose => 99)
      },
      'examples' => sub {
         pod2usage( -sections => 'EXAMPLES',   -exitval => 0, -verbose => 99)
      },
   };

   return $std_cli_arg_ref;
}

# Read and return args 
sub _get_cli_args {
   my @opts = @_;

   my %cli_arg;
   my $std_arg_ref = _get_standard_args;

   GetOptionsFromArray(
      \@opts,
      \%cli_arg,
      %{ $std_arg_ref },

      # This is an arg for demonstration purposes
      'mytest=s'

      # Custom args for your program here

   ) or die "error [$!]";

   return \%cli_arg;
}

sub _validate_cli_args {
   
   validate(
      @_, {

         # This test is for demonstration purposes
         # Validate the cli arg '--mytest <some_string>'
         mytest => {
            optional => 1,      # Optional arg 
            type     => SCALAR, # Must be a scalar 

            # Must contain only lower case letters
            regex    => qr{ \A [a-z]+ \Z }msx,
         },
      }
   );
   return;
}

sub run{

   # Process cli args
   $CLI_ARG_REF = _get_cli_args( @ARGV );

   # Validate cli args
   _validate_cli_args( $CLI_ARG_REF );
}

#
# Main matter unless this module was called from another program.
#
run() unless caller;

=pod

=head1 SYNOPSIS

This desmonstrates a modulino, a script that runs like a module, allowing for
separate testing scripts.

=head1 OPTIONS

Will take short form, e.g. -h for --help, options too.

=over 4

=item
[-v|--version]
Print version and exit.

=item
[--help|-?]
Print options and exit.

=item
[--usage]
Print SYNOPSIS and exit.

=item
[--examples]
Print examples and exit.

=item
[--man]
Print POD and exit.

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

1;
