#!/usr/bin/perl

package My::Person;

use strict;
use warnings;
use Class::InsideOut qw[public readonly private register id];

# Declare the attributes.
# Basic accessors and mutators are created automatically.
readonly  given_name   => my %given_name;
readonly  surname      => my %surname;
public    title        => my %title;

# This calls a custom mutator sub
public    salary       => my %salary, { set_hook => \&_set_salary };

# object constructor
sub new {
   my ( $self, $arg ) = @_;
   $self = register( $self );

   $given_name{ id $self } = $arg->{given_name};
   $surname   { id $self } = $arg->{surname};
   $title     { id $self } = $arg->{title};
   $salary    { id $self } = $arg->{salary};

	return $self;
}

# Custom mutator sub
sub _set_salary {
   # Set $_ and that is was the accessor will return.
   $_ = '$'.$_.'.00';
   return;
}

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

# These are not allowed
# $person->surname( 'Crane' );
# $person->salary = 20000;

say 'Title is ', $person->title;
$person->title( 'manager' );
say 'Title is now ', $person->title;

$person->salary( 10000 );
say 'Salary is '. $person->salary;
