#!/usr/bin/env perl

# Class using moose, moo, or mo

package My::Person;

use strict;
use warnings;
use Moo;

# To validate an integer
sub isa_int {
   my $num = shift;
   return 1 if $num =~ m/ \A \d+ \Z /mxs;
   return;
}

has 'given_name' => ( is => 'ro', required => 1 );
has 'surname'    => ( is => 'ro', required => 1 );
has 'title'      => ( is => 'rw', required => 1 );
has 'salary'     => ( is => 'rw', isa =>
   # Moo does not use isa so we use this sub.
   sub {
      my $salary = shift;
      die "Salary must be a number" unless isa_int $salary
   }
);

# return formatted salary $1000.00
sub salary_pretty {
   my $self = shift;
   return '$'.$self->salary.'.00';
}

1;

###########################################
package main;

use strict;
use warnings;
use feature 'say';

my $person = My::Person->new({
      given_name => 'neil',
      surname    => 'watson',
      title      => 'sysadmin'
});

say 'Name is ', $person->given_name;

# These are Not allowed
# $person->surname( 'Crane' );
# $person->salary = 20000;

say 'Title is ', $person->title;
$person->title( 'manager' );
say 'Title is now ', $person->title;

$person->salary( 10000 );
say 'Salary is '. $person->salary;
say 'Formatted Salary is '. $person->salary_pretty;
