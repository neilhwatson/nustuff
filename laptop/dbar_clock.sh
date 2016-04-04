#!/bin/sh

while true
do
   battery_string=$(acpi -b|tr "\n" ' ')
   battery_charge=$(echo $battery_string | perl -pe 's/.*?(\d{1,2})%.*/$1/')

   if [ "0$battery_charge" -lt 21 ] && [ "0$battery_charge" -gt 11 ]
   then
      notify-send -u normal Battery
   elif [ "0$battery_charge" -lt 11 ]
   then
      notify-send -u critical Battery
   fi

   xsetroot -name "$battery_string $(date '+%A %d %B %R')"
   sleep 60
done

