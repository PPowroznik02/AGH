import pandas
import pytest

from source.fleet import *
from source.personnel import *
from source.operations import *
from utils.parse_cli_args import *
from source.utils import *

def run_application():
    # zdefiniowanie naszych zasobów
    ambulance1 = Ambulance("Type A", "available", (50.095340, 18.920282), ["Defibrillator", "Oxygen tank"])
    ambulance2 = Ambulance("Type B", "on mission", (50.095340, 19.920282), ["Stretcher", "First Aid Kit"])
    ambulance3 = Ambulance("Type C", "available", (50.035340, 19.920282), ["Defibrillator", "Oxygen tank"])

    employee1 = Employee("John", "Doe", 12000.0)
    employee2 = Employee("Jane", "Smith", 8000.0)

    driver1 = Driver("Mike", "Johnson", 10000.0, "DL12345", ["BLS"])
    driver2 = Driver("Anna", "Brown", 11500.0, "DL12346", ["ALS", "PHTLS"])

    # sprawdzenie czy to czasem nie są te same karetki
    if ambulance1 == ambulance2:
        raise ValueError("To są te same karetki!")
    # sprawdzenie ile mamy karetek
    print(Ambulance.get_instances_count())

    # stworzenie kolejki
    queue = IncidentQueue()

    # zaraportowanie 2 zgłoszeń
    incident1 = Incident("Power outage in sector 4", "Important", "11:03", "Artur King, 42 yo", (50.653, 20.325))
    incident2 = Incident("Fire alarm in building 21", "Non-important", "15:21", "Alice Sparrow, 27 yo",
                         (40.3452, 21.2435))
    incident3 = Incident("Fire alarm in building 21", "Important", "02:20", "Beth Wasp, 27 yo", (60.3452, 11.2435))
    incident4 = Incident("Fire alarm in building 21", "Important", "12:20", "Beth Wasp, 27 yo", (60.3452, 11.2435))
    queue += incident1
    queue += incident2
    queue += incident3
    queue += incident4

    # wypisz wszystkie zgłoszenia
    print("Aktualne zgłoszenia:")
    print(queue)

    # daj kierowcy podwyżkę za super zasługi
    print(f"Przed podwyżką: {driver1.display_info()}")
    driver1.update_salary(5000.12)
    print(f"Po podwyżce: {driver1.display_info()}")

    # ZAD3
    print("------------------------------------------------------------------")
    station1 = Station((50.095340, 18.920282), ambulance1, driver1, employee1)
    station2 = Station((54.026322, 13.903264), ambulance2, driver2, employee1)
    station1.is_available()
    station2.is_available()

    # ZAD4
    print("------------------------------------------------------------------")
    # incident1.add_ambulance(Ambulance.get_non_busy_ambulance(Ambulance))
    incident1.add_ambulance(Ambulance)
    print(incident1)

    # incident2.add_ambulance(Ambulance.get_non_busy_ambulance(Ambulance))
    incident2.add_ambulance(Ambulance)
    print(incident2)

    # Prejecie ambulansu gdy zdarzenie ma wyzszy piorytet
    incident3.add_ambulance(Ambulance)
    print(incident3)
    print(incident2)

    # Prejecie ambulansu gdy zdarzenie ma za dlugi czas oczekiwania
    incident4.add_ambulance(Ambulance)
    print(incident4)
    print(incident3)


if __name__ == "__main__":
    run_application()

    args = parse_args();

    print(args)

    if (args.ambulance and args.station and args.incident and args.driver and args.employee) is not None:
        print("There is enough resources")
    else:
        print("There is not enough resources")
