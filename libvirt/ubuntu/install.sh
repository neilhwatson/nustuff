#!/bin/bash

virt-install -n ubuntu-test --description "ubuntu tester" -r 4096 --vcpus 2 \
   -l http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/ \
   --os-type=linux --os-variant=ubuntu20.04 \
   --file=/var/lib/libvirt/images/ubuntu.img \
   --network default \
   --file-size=9 \
   --autostart \
   --nographics \
   --extra-args "console=tty0 console=ttyS0,115200n8 \
   console-setup/ask_detect=false \
   keyboard-configuration/xkb-keymap=us \
   locale=en_CA \
   netcfg/get_hostname=ubuntu-test \
   netcfg/get_domain=watson-wilson.ca \
   netcfg/disable_dhcp=true \
   netcfg/get_ipaddress=192.168.122.99/24 \
   netcfg/get_gateway=192.168.122.1 \
   netcfg/get_nameservers=10.0.0.1 \
   auto url=https://raw.githubusercontent.com/neilhwatson/nustuff/master/libvirt/ubuntu/preseed.txt"
