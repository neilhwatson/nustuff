# A Perl hacker's rosetta to Ruby

## Quotes

### Perl
    qx{ /usr/bin/cmd }
    qw{ one two }

### Ruby
    %x{ /usr/bin/cmd }
    %w{ one two }

## String manipulation

### Perl
    mystring = "str" . "str1"
    mystring = join( ", ", @my_array )

### Ruby
    mystring = "str" + "str1"
    mystring = myarray.join( ", " )

## Debugging

### Perl
    use Data::Dumper;
    Dumper( \@my_array );

### Ruby
    require 'pp'
    pp my_array

## Modules

### Perl
    use MyMod

### Ruby
    require 'my_mod'

## Documentation

TODO POD vs Rdoc ?

## Error handling

### Perl
    die "some error"

### Ruby
    raise "some error"
