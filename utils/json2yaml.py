#!/usr/bin/env python

"""
Reads JSON from STDIN and outputs data in YAML.

EXAMPLE

yaml2json.py < file.yaml
"""

import pprint
import json
import sys
import yaml

yaml.safe_dump(json.load(sys.stdin), sys.stdout, allow_unicode=True)


