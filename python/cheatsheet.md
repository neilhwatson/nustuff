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
    match = re.search( '>(this)<', str ).group(1)
    print match

### Style test your code

    pep3 mine.py

### Run test suite

    pytest test_file.py
    pytest t/*.py

### Check return status of external commad

    import subprocess
    status = subprocess.call("/bin/false")
    print "status is" , status
