#!/usr/bin/env python

"""
Read IPv4 and IPv6 from aws metadata of instance and set the given A and AAAA
record in the given domain in Route53.

EXAMPLES

Update or create A and AAAA record www in domain example.com

AUTHOR

Neil H. Watson, http://watson-wilson.ca, neil@watson-wilson.ca

LICENSE and COPYRIGHT

The MIT License (MIT)

Copyright (c) 2017 Neil H Watson

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
"""

import argparse
import boto3
import re
import requests
import commonregex

aws_meta = 'http://169.254.169.254/'

#
# Subs
#
def convert(val):
    """A simple function for a testing example"""
    return val


def get_cli_args():
    """Process cli args"""

    parser = argparse.ArgumentParser(
        description=("Upsert53 updates or creates a new record in the given"
                    ,"Route53 domain.")
        , epilog="Use pydoc ./%(prog)s for more detail.")

    parser.add_argument(
        '--version'
        , action='version'
        , version='%(prog)s 1.0')

    parser.add_argument('--domain', '-d'
            , required=True
            , help='Domain')

    parser.add_argument('--record', '-r'
            , required=True
            , help='Record')

    # Get the rest of the args tha are not specific
    parser.add_argument('args', nargs=argparse.REMAINDER)

    arg = parser.parse_args()

    validate_args(arg)

    return arg


def validate_args(arg):
    """Validate command line arguments."""

    parser = commonregex.CommonRegex()

    if not re.search('(?ix) \A [a-z0-9-\.]+ \Z', str(arg.domain)):
        raise TypeError("Invalid domain name.")

    if not re.search('(?ix) \A [a-z0-9-]+ \Z', str(arg.record)):
        raise TypeError("Invalid record.")

    return

def get_ipv6():

    mac_addr = requests.get(
        aws_meta, "/latest/meta-data/network/interfaces/macs/")

    ipv6 = requests.get(
        aws_meta, "/latest/meta-data/network/interfaces/macs/"
        , mac_addr, "/ipv6s" )

    return ipv6

#
# Main matter unless this module was called from another program.
#
def run():
    """Start the program when run from CLI"""

    arg = get_cli_args()

    ipv4 = requests.get(
        "http://169.254.169.254/latest/meta-data/public-ipv4").text

    ipv6 = get_ipv6

    #conn53 = boto3.connect_to_region("universal")
    conn53 = boto3.client('route53')

    upd53 = conn53.get_zone_hosted(arg.domain)
    upd53.get_records()

    upd53.get_a(arg.record)
    upd53.update_a(arg.record, ipv4)

    upd53.get_aaaa(arg.record)
    upd53.update_aaaa(arg.record, ipv6)

    print "DNSLOG: " + arg.record + " updated to " + ipv4
    print "DNSLOG: " + arg.record + " updated to " + ipv6

    return


if __name__ == '__main__':
    run()

