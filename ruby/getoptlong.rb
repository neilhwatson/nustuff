#!/usr/bin/env ruby

# Fancy CLI arg parser
require 'optparse'
# Like Data::Dumper
require 'pp'

# Create a class named Parser
def _get_cli_args

   # Default args
   args = {
      name: 'lisa'
   }

   # Parse ARGV
	OptionParser.new do |opts|
		opts.banner = "Usage: #{$0} [options]"

      # Upper case NAME means arg to -n is required.
		opts.on("-n NAME", "--name NAME", "Name to say hello to") do |n|
			args[:name] = n
		end

      opts.on( :REQUIRED, "-r", "--required", "Required style option" ) do |r|
         args[:required] = r
      end

		opts.on("-?", "-h", "--help", "Prints this help") do
			puts opts
			exit
		end

   end.parse!

   return args
end

options = _get_cli_args

# Dump args
pp options

puts "My name is #{options[:name]}"
