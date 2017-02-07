#!/usr/bin/env ruby

=begin
This example shows how to make and use a class. It mirrors my perl example
'moo.pl'
=end

class MyPerson

   attr_reader :given_name, :surname, :title, :salary
   attr_accessor :title, :salary

   def initialize(given_name, surname, title, salary=0)
      @given_name = given_name
      @surname    = surname
      @title      = title
      @salary     = salary

      if not @salary.is_a? Integer
         raise "Error salary must be an integer."
      end
   end


  # Return salary in pretty $000.00 format
   def salary_pretty
      return '$' + @salary.to_s + '.00'
   end

end

person = MyPerson.new(given_name='neil', surname='watson', title='sysadmin')

puts "Name is #{person.given_name} #{person.surname}"

#person.name = "Not_allowed" # Name should be readonly because not accessor

person.title = 'Manager'
puts "Title is now #{person.title}"

person.salary = 10000
puts "salary is #{person.salary}"
puts "Formatted salary is #{person.salary_pretty}"
