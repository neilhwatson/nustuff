from app import convert
import unittest
import sys

sys.path.insert(0, '.')


class TestUM(unittest.TestCase):

    def setUp(self):
        pass

    def test_convert(self):
        self.assertEqual(convert('foo'), 'foo', 'conver failed')


if __name__ == '__main__':
    unittest.main()
