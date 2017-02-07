#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'app')
require 'test/unit'

class IntialTest < Test::Unit::TestCase
   def test_convert
      assert_equal 'foobar', convert(val='foobar')
   end
end

