# Changing foot pedal mapping.

1. Build https://github.com/rgerganov/footswitch
1. See for raw keys https://www.freebsddiary.org/APC/usb_hid_usages.php
1. sudo ./footswitch -m win -k F12
1. xbindkeys shows this as `Mod4 + Super_L + F12`
1. If using awesomewm  `awful.key({ modkey }, "F12", function() awful.spawn("xterm") end),`
1. Toggle in use mic on/off with `pactl set-source-mute @DEFAULT_SOURCE@ toggle`
1. Test with `pactl set-source-mute @DEFAULT_SOURCE@` Will show as `Mute: yes/no`
