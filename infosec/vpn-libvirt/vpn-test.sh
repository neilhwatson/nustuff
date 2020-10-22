#!/bin/bash -x

ping -c 3 192.168.122.1
ping -c 3 10.0.0.1
dig +short +timeout=1 @10.0.0.1
dig +short +timeout=1
cat /etc/resolv.conf

