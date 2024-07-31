import unittest

from source.personnel.employee import *

class MyTestCase(unittest.TestCase):
    def test_employee(self):
        employee1 = Employee("John", "Doe", 12000.0)
        employee2 = Employee("Jane", "Smith", 8000.0)

        assert employee1 is not employee2, f"employee1 {employee1} should not be employee2 {employee2}"

        assert isinstance(employee1, Employee), f"employee1 {employee1} should be an instance of Employee"
        assert isinstance(employee2, Employee), f"employee1 {employee2} should be an instance of Employee"


if __name__ == '__main__':
    unittest.main()
