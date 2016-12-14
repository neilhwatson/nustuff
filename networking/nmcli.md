### NetworkManger CLI cheatsheet

Embrace NetworkManager with the cli interface. Contributions welcome.

#### List configured connections

    nmcli c

#### List available wifi

    nmcli d wifi

#### Bring up connection

    nmcli con up id <connection name>

If a password is required add the ask switch.

    nmcli --ask con up id <connection name>

#### Bring down connection

    nmcli con down id <connection name>

