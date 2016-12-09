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
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR # IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Limit path for good security practice
OLDPATH=$PATH
export PATH=/bin:/usr/bin

# Name me!
PROGRAM=dbar_clock.sh

usage(){
    cat 1>&2 <<EOF
USAGE: $PROGRAM [--battery] [--utc]

Return battery and date to DWM's dbar and send notify messages when battery
is low.

--battery report battery status
--utc report utc time in addition to normal time.
--test print to stdout for testing

EOF
}

man() {
    cat <<EOF | $mcmd
# Get from man.skel
EOF
    exit
}

version(){
    printf "$PROGRAM version $VERSION"
}

error(){
# Errors are sent to stderr

    # This syslog action need only be used on hosts that have a running syslog
    #logger -s -t $PROGRAM "$@, $STATUS $ERROR"
    printf "Error: $@\n" 1>&2
    usage
    exit 1
}

# Defaults
BATTERY=0
UTC=0
TEST=0

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

        --battery | --batter | --batte | --batt | --bat | --ba | --b |\
           -battery | -batter | -batte | -batt | -bat | -ba | -b )
        BATTERY=1
        ;;

        --utc | --ut | --u | -utc | -ut | -u )
        UTC=1
        ;;

        --test | --tes | --te | --t | -test | -tes | -te | -t)
        TEST=1
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

battery() {

   battery_string=$(acpi -b|tr "\n" ' ' | sed 's/%/%%/' )
   battery_charge=$(echo $battery_string | perl -pe 's/.*?(\d{1,3})%.*/$1/')

   if [ "0$battery_charge" -lt 21 ] && [ "0$battery_charge" -gt 11 ]
   then
      notify-send -u normal Battery
   elif [ "0$battery_charge" -lt 11 ]
   then
      notify-send -u critical Battery
   fi

   printf "$battery_string"
   return
}

date_string() {

   if [ $UTC -eq 1 ]
   then
      date_string="$(date '+%A %d %B %R') [$(date --utc +%H:%M)]"
   else
      date_string="$(date '+%A %d %B %R')"
   fi

   printf "$date_string"
   return
}

# Main matter begins.

while true
do
   sleep=60

   if [ $BATTERY -eq 1 ]
   then
      dbar_msg=$( battery )
      dbar_msg="$dbar_msg $( date_string )"
   else
      dbar_msg=$( date_string )
   fi

   if [ $TEST -eq 1 ]
   then
      sleep=5
      printf "$dbar_msg"
   else
      xsetroot -name "$dbar_msg"
   fi

   sleep $sleep
done

exit 0
