# NetworkManger CLI cheatsheet

Embrace NetworkManager with the cli interface. Contributions welcome.

*TIP* tab completion works.

## GUI connection editor

    nm-connection-editor

## List configured connections

    nmcli c
    nmcli connection show

## List available wifi

    nmcli d w
    nmcli d wifi
    nmcli device wifi
    nmcli device wifi list

## Connect to a wifi network

    nmcli device wifi connect SSID password password

## Connect to a hidden network

    nmcli device wifi connect SSID password password hidden yes

## Bring up connection, including wifi

    nmcli con up <connection name>

## If a password is required add the ask switch.

    nmcli --ask con up id <connection name>

## Bring down connection

    nmcli con down id <connection name>

## Connect to a wifi on the wlan1 wifi interface

    nmcli device wifi connect SSID password password ifname wlan1 profile_name

## Disconnect an interface

    nmcli device disconnect ifname eth0

## Reconnect an interface marked as disconnected

    nmcli connection up uuid UUID

## See a list of network devices and their state

    nmcli device

## Turn off wifi

    nmcli radio wifi off
