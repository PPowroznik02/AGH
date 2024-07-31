# V1 - slajd 8: python -m personnel.driver
import logging

import itertools
from .employee import Employee
from ..utils.logger_manager import logger_helper

logger = logger_helper(__name__)


class Driver(Employee):
    __max_id = itertools.count()

    def __init__(self, first_name, last_name, salary, license_number, qualifications):
        # alternatywa: super().__init__(self, ...)
        Employee.__init__(self, first_name, last_name, salary)
        self.license_number = license_number
        self.qualifications = qualifications

        logger.log(logging.INFO, "Created driver instance")

    def display_info(self):
        return f"Driver ID: {self.employee_id}, Name: {self.first_name} {self.last_name}, Salary: {self.salary}, License Number: {self.license_number}, Qualifications: {', '.join(self.qualifications)}"


if __name__ == "__main__":
    driver1 = Driver("Jane", "Smith", 1, 12000.00, "LIC1001", ["BLS"])
    print(driver1.display_info())
