import unittest, sys

sys.path.insert(0, '.')
from app import convert

class TestUM(unittest.TestCase):

    def setUp(self):
         pass

    def test_convert(self):
         self.assertEqual( convert( 'foo' ), 'foo', 'conver failed' )

if __name__ == '__main__':
    unittest.main()
