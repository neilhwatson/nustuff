#!/usr/bin/perl

=pod

=head1 SYNOPSIS

A little something to get ready for CFEngine 3.7 and EFL. This prototype
demonstrates how to convert Perl data to JSON or YAML. Using the same modules
you can also read JSON and YML data into Perl data.

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

use strict;
use warnings;
use Data::Dumper;
use feature 'say';
use Test::More;
use YAML;
use Config::YAML;
use JSON;

my @data = (
   {
      class => "any",
      command => "/usr/bin/foo",
      useshell => "no",
      module => "no",
      ifelapsed => "0",
      promisee => "Neil Watson"
   },
   {
      class => "linux",
      command => "/usr/bin/bar",
      useshell => "yes",
      module => "yes",
      ifelapsed => "1",
      promisee => "Neil H Watson"
   }
);

my $j = JSON->new->pretty;
my $json = $j->encode( \@data );
say "JSON format \n". $json;

my $yml = Dump \@data;
say "YAML format \n". $yml;

say "Convert YAML back to Perl data and iterate over it.";
my $y = Load $yml;
for my $i ( @{ $y } ) {
   say "\n--- # Next document\n";

   for my $a ( qw/ class command useshell module ifelapsed promisee / ) {
      say "$a => $i->{$a}";
   }
}
1;
