import unittest

from source.personnel.driver import *

class MyTestCase(unittest.TestCase):
    def test_driver(self):
        driver1 = Driver("Mike", "Johnson", 10000.0, "DL12345", ["BLS"])
        driver2 = Driver("Anna", "Brown", 11500.0, "DL12346", ["ALS", "PHTLS"])

        assert driver1 is not driver2, f"driver1 {driver1} should not be driver2 {driver2}"

        assert isinstance(driver1, Driver), f"driver1 should be an instance of Driver"
        assert isinstance(driver2, Driver), f"driver2 should be an instance of Driver"

if __name__ == '__main__':
    unittest.main()
