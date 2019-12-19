#!/bin/sh

# The MIT License (MIT)
# 
# Copyright (c) 2014 Neil H Watson
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Limit path for good security practice
OLDPATH=$PATH
export PATH=/bin:/usr/bin

# For bash shells:
set -euo pipefail
IFS=$'\n\t'

# Name me!
PROGRAM=
VERSION=

# Output man page to this default unless specified later.
mcmd=cat

function usage(){
    cat 1>&2 <<EOF

EOF
}

function man() {
    cat <<EOF | $mcmd
# Get from man.skel
EOF
    exit
}

function version(){
    printf "$PROGRAM version $VERSION"
}

function wait_for_dns(){
   fqhn=$1

   for i in {1..20}
   do
      a_record=$(dig +short $fqhn)
      if [[ $a_record != '' ]]
      then
         printf "\n"
         return 0
      fi
      printf '.'
      sleep 60
   done
   return 1
}

function log() {
    line=$1
    printf "%s %s\n" "$(date +'%b %d %H:%M:%S')" "$line"
}

function error(){
# Errors are sent to stderr

    # This syslog action need only be used on hosts that have a running syslog
    #logger -s -t $PROGRAM "$@, $STATUS $ERROR"
    printf "Error: $@\n" 1>&2
    usage
    exit 1
}

# get opts
while test $# -gt 0
do
    case $1 in

        # For each option
        #-o)
        #shift
        #option="$1"
        #;;
        # Add custom options ABOVE the defaults below.

        --man | --ma | --m |\
        -man | -ma | -m )
        man=1
        # Read man command
        mcmd="eval nroff -c -man | col | less"
        ;;

        --mman | --mma | --mm |\
        -mman | -mma | -mm )
        mman=1
        ;;

        --version | --versio | --versi | --vers | --ver | --ve | --v |\
        -version | -versio | -versi | -vers | -ver | -ve | -v)
        version
        exit 0
        ;;

        --help | --hel | --he | --h | --\? |\
        -help | -hel | -he | -h | -\?)
        usage
        exit 0
        ;;

        -*)
        error "Unrecognized option: $1"
        ;;

        *)
        break
        ;;
    esac
    shift
done

# Left over arguments
rcmd="$@"

# Validate arguments 
if [ "0$man" -eq 1 ] && [ "0$mman" -eq 1 ]
then
    error "-m and --m are mutually exclusive"
elif [ "0$man" -eq 1 ] || [ "0$mman" -eq 1 ]
then
    man
fi

##########################
# Code library that may be recycled
# get lines from stdin
while read line 
do
    case $line in

        \#*)
# Skip lines that begin with a comment '#'
        ;;
        
        *)
# remove lines with trailing comments
        line=$(printf "$line" | sed -e s/#.*$//g)
        LINES="$LINES $line"
        ;;

    esac
done

# End of code library.
##########################


# Main matter begins.

exit 0
