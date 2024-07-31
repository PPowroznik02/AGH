import unittest
import sys
import io

import pytest

from source.fleet.ambulance import *
from source.fleet.station import *
from source.personnel.driver import Driver
from source.personnel.employee import Employee

class MyTestCase(unittest.TestCase):

    def test_fleet(self):
        ambulance1 = Ambulance("Type A", "available", (50.095340, 18.920282), ["Defibrillator", "Oxygen tank"])
        ambulance2 = Ambulance("Type B", "on mission", (50.095340, 19.920282), ["Stretcher", "First Aid Kit"])

        employee1 = Employee("John", "Doe", 12000.0)

        driver1 = Driver("Mike", "Johnson", 10000.0, "DL12345", ["BLS"])
        driver2 = Driver("Anna", "Brown", 11500.0, "DL12346", ["ALS", "PHTLS"])

        station1 = Station((50.095340, 18.920282), ambulance1, driver1, employee1)
        station2 = Station((54.026322, 13.903264), ambulance2, driver2, employee1)

        assert station1 is not None, f"Station1 is None"
        assert station2 is not None, f"Station2 is None"

        assert isinstance(station1, Station), f"Station1 is not a Station"
        assert isinstance(station2, Station), f"Station2 is not a Station"

        assert station1 is not station2, f"Station1 {station1} is Station2 {station2}"

        assert station1.is_available() == 'Ambulance is in station', f"Station1 is not available {station1}"
        assert station2.is_available() == 'Ambulance is not in station', f"Station2 is available {station2}"


if __name__ == '__main__':
    unittest.main()
