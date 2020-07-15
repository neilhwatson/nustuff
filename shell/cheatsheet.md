## Copy files en masse via ssh

    tar czf - /path | ssh host 'tar -C "/" -xzf -'

## for loop in one line

    for i in $(seq 1 4); do echo $i; done
 
## testing a script

    testing(){
        
        pass=0
        fail=0
        expected_pass=2

        $0 -bad option 2>/dev/null
        ret=$?
        if [ 0$ret -eq 0 ]
        then
          echo NOT OK bad option returned zero [$ret]
          fail=$(( fail+1 ))
        elif [ 0$ret -gt 0 ]
        then
          echo OK bad option returned none zero [$ret]
          pass=$(( pass+1 ))
        else
          echo NOT OK bad option returned neither zero nor none zero [$ret]
          fail=$(( fail+1 ))
        fi

        # Results
        if [ $pass -eq $expected_pass ]
        then
          echo PASS passed: $pass, expected: $expected_pass
        elif [ $pass -lt $expected_pass ]
        then
          echo FAIL passed: $pass, expected: $expected_pass
        elif [ $fail -gt 0 ]
        then
          echo FAIL failed: $fail
        fi
    }

## Testing if a var is a number

    case $num in
       (*[!0-9]*|'') error "--num [$num] is not a number"
    esac

## Test if a program exists in the path 

    command -v <program> 2>&1 >/dev/null || error "<program> not installed"

## Redirection

    my_command 2>&1 > command-stdout-stderr.txt

    my_command 2>&1 > /dev/null

## Schedule a command

    echo 'mycommand -w args'|at now + 5 minutes

## Search and replace

    perl -pi -e 's///g' <file>

    find /path -name "*files*" -exec perl -pi -e 's///g' {} \;

## Find duplicate files

    md5sum *|awk -e '{print $1}'|sort|uniq -d

## Weather report

    curl wttr.in

    curl wttr.in/yyz

    curl wttr.in/~markham+ontario+canada

## AWK instead of grep

AWK works like grep -E.

    awk '/PATH/' .profile
    awk '/string/ {print $2}
    awk '! /PATH/' .profile # works like grep -v

Credit: http://blog.jpalardy.com/posts/skip-grep-use-awk/

## Trap a signal and take action on it

    trap 'cleanup; exit' SIGINT SIGQUIT

## Variable references in bash

    foo=bar
    next=foo
    echo foo: $foo
    echo print foo by referencing next: ${!next}
    
## HTTP server in one line

    { echo -e 'HTTP/1.1 503 OK\nService Temporarily Unavailable\n\n'; } | netcat -l -p 8000

## Make a meme

```shell
    convert inputmemeimage.png -font impact -fill white -pointsize 84 \
        -stroke black -strokewidth 3 -gravity north -annotate +0+20 \
        'TOP MEME TEXT' -gravity south -annotate +0+20 'BOTTOM MEME TEXT' \
        outputmemeimage.png 
```
