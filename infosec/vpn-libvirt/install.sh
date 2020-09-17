#!/bin/bash

virt-install -n vpn --description "Work VPN" -r 4096 --vcpus 2 \
   -l http://ftp.ca.debian.org/debian/dists/stable/main/installer-amd64/ \
   --os-type=linux --os-variant=debian10 \
   --file=/var/lib/libvirt/images/vpn.img \
   --file-size=5 \
   --autostart \
   --nographics \
   --extra-args "console=tty0 console=ttyS0,115200n8 \
   console-keymaps-at/keymap=us \
   locale=en_CA \
   keyboard-configuration/xkb-keymap=us \
   netcfg/get_hostname=vpn \
   netcfg/get_domain=watson-wilson.ca \
   netcfg/disable_dhcp=true \
   netcfg/get_ipaddress=192.168.122.99/24 \
   netcfg/get_gateway=192.168.122.1 \
   netcfg/get_nameservers=10.0.0.1 \
   auto url=https://raw.githubusercontent.com/neilhwatson/nustuff/master/infosec/vpn-libvirt/preseed.txt"
