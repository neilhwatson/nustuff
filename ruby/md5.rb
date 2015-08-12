#!/usr/bin/ruby

require 'digest/md5'

filename = '/etc/passwd'

sum = Digest::MD5.hexdigest( File.read( filename ))

puts sum
