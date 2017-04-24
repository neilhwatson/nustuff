#!/usr/bin/env python

"""
Reads YAML from STDIN and outputs data in JSON.

EXAMPLE

yaml2json.py < file.yaml
"""

import json
import sys
import yaml

json.dump(yaml.load(sys.stdin), sys.stdout, indent=4)

