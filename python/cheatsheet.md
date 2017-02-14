### function named parameters

    def print_name(first, last):
        print first + ' ' + last
        return

    print_name(last='watson', first='neil')

#### With default values

    def print_name(last, first='bob'): # <<< default args must be last
        print first + ' ' + last
        return

    print_name(last = 'watson')

### Slurp whole file

    fh = open( myfile )
    f = fh.read()
    fh.close()

### Slurp whole file into an array

    fh = open( myfile )
    f = fh.readlines()
    fh.close()

### Read file line by line

    fh = open( myfile )

    for line in fh.readlines():
        line = line.rstrip() # <<< strip all trailing whitespace
        print 'line ' + line

    fh.close()

### Read from stdin into one string

    import sys
    content = sys.stdin.read()
    print content

### Read from stdin line by line

    import sys
    for line in sys.stdin:
    
###  Slurp from stdout of a command

    import subprocess
    output=subprocess.check_output([ 'ls', '-l' ])
    print output
    
### Search and replace, keep original and assign change to new variable.

    import re
    new_string = re.sub( 'teh', 'the', org_string )

### Match and store match in a single line

    import re
    match = re.search( '>(this)<', str )
    if match
        print match.group(1)

### Style test your code

    pep3 mine.py

### Run test suite

    pytest test_file.py
    pytest t/*.py

### Check return status of external commad

    import subprocess
    status = subprocess.call("/bin/false")
    print "status is" , status

### import a custom module

The magic is in the empty init file.

    ./app.py
    ./lib/mod.py

    touch ./lib/__init__.py

#### app.py

    from lib import mod

#### Alternate method

    import sys
    sys.path.insert(0, './lib')
    from mod import <class>

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
