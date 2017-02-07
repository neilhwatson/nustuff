### function named parameters

    def print_name(first, last)
        print "#{first} #{last}"
    end

    print_name(first='Neil', last='Watson')
#### With default values

    def print_name(first='Bob', last)
        print "#{first} #{last}"
    end

    print_name(last='Watson')

### Slurp whole file

    file=File.read( $0 )
    puts file

### Slurp whole file into an array

    a=[]
    File.foreach( $0 ) do |line|
        line.chomp!
        a.push line
    end

### Read file line by line

    a=[]
    File.foreach( $0 ) do |line|
        line.chomp!
        # Do stuff here
    end

### Read from stdin into one string

    text=$stdin.read

### Read from stdin line by line

    $stdin.each do |line|
        line.chomp!
        puts line
    end

###  Slurp from stdout of a command

    qx{ /usr/bin/cmd }

### Search and replace, keep original and assign change to new variable.

    new_var = original.sub( /teh/, 'the' )

### Search and replace, in-place

    original.sub!( /teh/, 'the' )

### Match and store match in a single line

    match = original.match( /kept/ )[0]

### Style test your code

There is a package called rubycritic.

### Run test suite

See ruby modulino in this repo.

### Check return status of external commad

    if system("/bin/true")
        puts 'pass'
    else
        puts 'fail'
    end

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

POD vs Rdoc and very similar, but Rdoc will not render to the terminal pager.

## Error handling

### Perl
    die "some error"

### Ruby
    raise "some error"

### License

The MIT License (MIT)

Copyright (c) 2017 Neil H Watson

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
