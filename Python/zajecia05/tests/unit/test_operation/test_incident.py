import unittest

from source.operations.incident import *
from source.operations.incident_queue import *

class MyTestCase(unittest.TestCase):
    def test_incident(self):
        queue = IncidentQueue()

        incident1 = Incident("Power outage in sector 4", "Important", "11:03", "Artur King, 42 yo", (50.653, 20.325))
        incident2 = Incident("Fire alarm in building 21", "Non-important", "15:21", "Alice Sparrow, 27 yo",
                             (40.3452, 21.2435))
        incident3 = Incident("Fire alarm in building 21", "Important", "02:20", "Beth Wasp, 27 yo", (60.3452, 11.2435))
        incident4 = Incident("Fire alarm in building 21", "Important", "12:20", "Beth Wasp, 27 yo", (60.3452, 11.2435))

        assert isinstance(incident1, Incident), "incident1 should be an Incident object"
        assert isinstance(incident2, Incident), "incident2 should be an Incident object"
        assert isinstance(incident3, Incident), "incident3 should be an Incident object"
        assert isinstance(incident4, Incident), "incident4 should be an Incident object"

        assert incident1 is not incident2 or incident3 or incident4, "incident1 should be unique"
        assert incident2 is not incident1 or incident3 or incident4, "incident2 should be unique"
        assert incident3 is not incident1 or incident2 or incident4, "incident3 should be unique"
        assert incident4 is not incident1 or incident2 or incident3, "incident4 should be unique"

        queue += incident1
        queue += incident2
        queue += incident3
        queue += incident4

        assert isinstance(queue, IncidentQueue), "queue should be an instance of IncidentQueue"

        assert queue.__contains__(incident1), "Incident1 not in queue"
        assert queue.__contains__(incident2), "Incident1 not in queue"
        assert queue.__contains__(incident3), "Incident1 not in queue"
        assert queue.__contains__(incident4), "Incident1 not in queue"

        assert queue.__len__() == 4, "Queue len is not 4"


if __name__ == '__main__':
    unittest.main()
