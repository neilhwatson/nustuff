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
    nmcli device wifi connect SSID --ask # for password prompt

## Connect to a hidden network

    nmcli device wifi connect SSID password password hidden yes
    nmcli device wifi connect SSID hidden yes --ask

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

## Network bridge

```
nmcli con add ifname br0 type bridge con-name br0
nmcli con add type bridge-slave ifname <interface> master br0
nmcli con up br0
```

[See more](https://www.cyberciti.biz/faq/ubuntu-20-04-add-network-bridge-br0-with-nmcli-command/)
