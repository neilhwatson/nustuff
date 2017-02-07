#!/usr/bin/env ruby

=begin

=head1 SYNOPSIS

This demonstrates a modulino, a script that runs like a module, allowing for
separate testing scripts.

   [--help|-?]
   Print options and exit.

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
=end

require 'optparse'

# Parse cli args, validate them and return arg hash
def get_cli_args
   version = '1.0'

   # Default args
   arg = {
      mytest: '999'
   }

   # Parse ARGV
	OptionParser.new do |opts|
		opts.banner = "Usage: #{$0} [options]"

		opts.on("-?", "-h", "--help", "Prints this help") do
			puts opts
			exit
		end

      opts.on("--version", "Show version") do
         puts version
         exit
      end

      # Upper case NAME means arg to -n is required.
      opts.on("-m", "--mytest NAME",
              # Force option to be a number 
              Numeric,
              "Mytest with a numeric argument.") do |m|
			arg[:MYTEST] = m
		end

   end.parse!

   validate_args( arg )
   return arg
end

# Validate cli args
def validate_args(arg)

   if not arg[:MYTEST]
      raise "--mytest <number> required."
   end

end

# A simple function for a testing example
def convert(val)
   return val
end

#
# Main matter unless this module was called from another program.
#

def run

   arg = get_cli_args

   puts 'run stuff'

end

if __FILE__ == $0
   run();
end

