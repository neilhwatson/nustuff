#!/usr/bin/env python

import unittest
import sys

from os import path

sys.path.append( path.dirname( path.dirname( path.abspath(__file__) ) ) )
from app import convert


class TestUM(unittest.TestCase):

    def setUp(self):
        pass

    def test_convert(self):
        self.assertEqual(convert('foo'), 'foo', 'conver failed')


if __name__ == '__main__':
    unittest.main()
