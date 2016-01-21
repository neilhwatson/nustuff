#!/usr/bin/ruby -w

=begin

== SYNOPSIS

I expect that this will turn in a cheatsheet at some point

=end

## Dispatching anonymous code blocks

# Storing a code block like Perl's anonymous subroutines
codes = {
   one: -> { 
      puts "This is code block one"
      puts "And this is code block one's line two"
   },
   two: -> {
      puts "This is code block two"
      puts "And this is code block two's line two"
   },
}

# Iterate through hash and run the stored code.
codes.each do |name, code|
   code.()
end

