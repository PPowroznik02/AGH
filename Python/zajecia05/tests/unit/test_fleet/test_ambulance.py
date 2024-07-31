import unittest

from source.fleet.ambulance import *

class MyTestCase(unittest.TestCase):

    def test_ambulance(self):
        ambulance1 = Ambulance("Type A", "available", (50.095340, 18.920282), ["Defibrillator", "Oxygen tank"])
        ambulance2 = Ambulance("Type B", "on mission", (50.095340, 19.920282), ["Stretcher", "First Aid Kit"])
        ambulance3 = Ambulance("Type C", "available", (50.035340, 19.920282), ["Defibrillator", "Oxygen tank"])

        assert ambulance1 is not None, f"Ambulance {ambulance1} not found."
        assert ambulance2 is not None, f"Ambulance {ambulance2} not found."
        assert ambulance3 is not None, f"Ambulance {ambulance3} not found."

        assert isinstance(ambulance1, Ambulance)
        assert isinstance(ambulance2, Ambulance)
        assert isinstance(ambulance3, Ambulance)

        assert ambulance1 is not ambulance2, f"Ambulance {ambulance1} is Ambulance {ambulance2}."
        assert ambulance2 is not ambulance3, f"Ambulance {ambulance2} is Ambulance {ambulance3}."
        assert ambulance1 is not ambulance3, f"Ambulance {ambulance1} is Ambulance {ambulance3}."

if __name__ == '__main__':
    unittest.main()
