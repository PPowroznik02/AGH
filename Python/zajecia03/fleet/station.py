import itertools
class Station:
    __max_id = itertools.count()

    def __init__(self, location, ambulance, driver, employee):
        self.id = next(self.__max_id)
        self.location = location
        self.ambulance = ambulance
        self.driver = driver
        self.employee = employee


    def is_available(self):
        if self.location == self.ambulance.location:
            print("Ambulance is in station")
        else:
            print("Ambulance is not in station")

