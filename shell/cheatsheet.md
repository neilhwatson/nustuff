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


