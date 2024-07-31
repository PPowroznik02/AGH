import logging

import itertools

from ..utils.logger_manager import logger_helper

logger = logger_helper(__name__)


class Station:
    __max_id = itertools.count()

    def __init__(self, location, ambulance, driver, employee):
        self.id = next(self.__max_id)
        self.location = location
        self.ambulance = ambulance
        self.driver = driver
        self.employee = employee

        logger.log(logging.INFO, "Created station instance")

    def is_available(self):
        if self.location == self.ambulance.location:
            return ("Ambulance is in station")
        else:
            return ("Ambulance is not in station")
