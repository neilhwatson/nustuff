#!/usr/bin/env python

"""
Synopsis here.

EXAMPLES

AUTHOR

Neil H. Watson, http://watson-wilson.ca, neil@watson-wilson.ca

LICENSE and COPYRIGHT

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
"""

import argparse, re

#
# Subs
#

def convert(val):
    """A simple function for a testing example"""
    return val

def get_cli_args():
    """Process cli args"""

    parser = argparse.ArgumentParser(
	    description="Brief description, one line only"
	    ,epilog="Use pydoc ./%(prog)s for more detail.")

    parser.add_argument(
	    '--version'
	    , action='version'
	    , version='%(prog)s 1.0')

    parser.add_argument( '--mytest' )

    # Get the rest of the args tha are not specific
    parser.add_argument('args', nargs=argparse.REMAINDER)

    arg = parser.parse_args()

    validate_args( arg )

    return arg

def validate_args(arg):
    """Validate command line arguments."""

    if not re.match( '(?x) \A [a-z]+ \Z', arg.mytest):
	raise TypeError( "Arg mytest invalid expects [a-z]+ only." )

    return

#
# Main matter unless this module was called from another program.
#

def run():
    """Start the program when run from CLI"""

    arg = get_cli_args()

    return


if __name__ == '__main__':
    run()

