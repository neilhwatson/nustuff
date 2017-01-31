#!/usr/bin/env python

"""
This example shows how to make and use a class. It mirrors my perl example
'moo.pl'

BEWARE that read-only attributes are not possible or discouraged in python.
"""


class MyPerson(object):
    """Make empoyee person class with names, and title required."""

    def __init__(self, given_name, surname, title, salary=0):
        self.given_name = given_name
        self.surname    = surname
        self.title      = title
        self.salary     = salary

        if not isinstance(salary, (int, long)):
            raise TypeError("Error salary must be an integer")

    def salary_pretty(self):
        """Return salary in pretty $000.00 format"""
        return '$' + str(self.salary) + '.00'


person = MyPerson(given_name='neil', surname='watson', title='sysadmin')

print 'Name is ' + person.given_name + ' ' + person.surname

# Python has no simple methods for making attributes read-only :(

print 'Title is ' + person.title
person.title = 'Manager'
print 'Title is now ' + person.title

person.salary = 10000
print 'salary is', person.salary
print'Formatted salary is ' + person.salary_pretty()
