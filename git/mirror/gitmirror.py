#!/usr/bin/env python

"""
Mirror repos between github and bitbucket for safety.

Uses a bare checkout and a mirror push. Assumes you have git access via SSH
key and that the key passphrase is held in an agent.

EXAMPLES

Mirror Github neilhwatson/nustuff to Bitbucket neilhwatson/nustuff

gitmirror.py --git2bit neilhwatson/nustuff neilhwatson/nustuff

Mirror Bitbucket neilhwatson/nustuff to Github neilhwatson/nustuff

gitmirror.py --bit2git neilhwatson/nustuff neilhwatson/nustuff


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
import distutils.core
import os
import subprocess
import re

#
# Subs
#
def get_cli_args():
    """Process cli args"""

    parser = argparse.ArgumentParser(
        description="Mirror git repos between Github and Bitbucket."
        , epilog="Use pydoc ./%(prog)s for more detail.")

    parser.add_argument(
        '--version'
        , action='version'
        , version='%(prog)s 1.0')

# Mutually exclusive args, but one or the other is required.
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument(
        '--git2bit', '-g2b'
        , action='store_true'  # Means arg.add is True or False.
        , help='Mirror from Github to Bitbucket.')

    group.add_argument(
        '--bit2git', '-b2g'
        , action='store_true'
        , help='Mirror from Bitbucket to Github.')

    parser.add_argument(
            'src'
            , help='Repo path to mirror source.')

    parser.add_argument(
            'dest'
            , help='Repo path to mirror destination.')

    arg = parser.parse_args()

    validate_args(arg)

    return arg


def validate_args(arg):
    """Validate command line arguments."""

    for next_arg in [ arg.src, arg.dest ]:
        if not re.search('(?x) \A [\w\-/\.]+ \Z', str(next_arg)):
            raise TypeError("Invalid repo syntax.")

    return

def runcmd(cmd, workdir):

    proc = subprocess.Popen(cmd, cwd=workdir, stderr=subprocess.STDOUT, shell=True)

    exit_code = int( proc.wait() )
    if exit_code != 0:
        raise Exception( proc.stderr )

    return

#
# Main matter unless this module was called from another program.
#
def run():
    """Start the program when run from CLI"""

    biturl='git@bitbucket.org:'
    giturl='git@github.com:'

    arg = get_cli_args()

    # Determine src and dest URLs
    if arg.git2bit:
        arg.src =giturl+arg.src +'.git'
        arg.dest=biturl+arg.dest+'.git'
    if arg.bit2git:
        arg.src =biturl+arg.src +'.git'
        arg.dest=giturl+arg.dest+'.git'

    # Prep work dir
    workdir="/tmp/gitmirror"+str(os.getpid())
    distutils.dir_util.mkpath(workdir)

    clone= 'git clone --bare '   +arg.src
    runcmd(clone,workdir)

    # Get cloned dir
    clonedir = workdir + '/' + re.search('(?x) ( [^\/]+ \.git)\Z', arg.src).group(1)

    mirror='git push --mirror ' +arg.dest
    runcmd(mirror,clonedir)

    # Clean up
    distutils.dir_util.remove_tree(workdir)

    return


if __name__ == '__main__':
    run()
