import itertools
from math import sin, cos, sqrt, atan2, radians
import datetime


class Incident:
    __max_id = itertools.count()
    instances = []

    def __init__(self, description, event_priority, report_time, reporter_info, localization):
        self.id = next(self.__max_id)
        self.description = description
        # ZAD2
        self.event_priority = event_priority
        self.report_time = report_time
        self.reporter_info = reporter_info
        self.localization = localization
        Incident.instances.append(self)


    def __repr__(self):
        return f"Incident(id={self.id!r}, description={self.description!r})"

    def __str__(self):
        return ', '.join(f"{attr}={value}" for attr, value in self.__dict__.items())

    #ZAD4
    def add_ambulance(self, Ambulance):
        ambulances = Ambulance.get_non_busy_ambulance(Ambulance)  # Zanalezienie wolnych karetek


        def calc_dist(lat1, lon1, lat2, lon2):
            R = 6373.0

            lat1 = radians(lat1)
            lon1 = radians(lon1)
            lat2 = radians(lat2)
            lon2 = radians(lon2)

            dlon = lon2 - lon1
            dlat = lat2 - lat1

            a = sin(dlat / 2) ** 2 + cos(lat1) * cos(lat2) * sin(dlon / 2) ** 2
            c = 2 * atan2(sqrt(a), sqrt(1 - a))

            distance = R * c
            return distance


        if len(ambulances) == 0:
            current_time = datetime.datetime.now()
            current_time = current_time.strftime("%H:%M")
            #current_time = "01:50"  # Odkomentowac to testu w main.py
            incident_time = self.report_time

            #W przypadku naglego incydentu znalezienie karetki o inskim piorytecie
            if self.event_priority == "Important":
                for incident in Incident.instances:
                    if incident.event_priority != "Important" and incident.ambulance != "no available ambulance":
                        self.ambulance = incident.ambulance
                        incident.ambulance = "no available ambulance"
                        return


            if abs((int)(current_time[0:2]) - (int)(incident_time[0:2])) >= 2:
                for incident in Incident.instances:
                    if abs((int)(current_time[0:2]) - (int)(incident.report_time[0:2])) < 2:
                        self.ambulance = incident.ambulance
                        incident.ambulance = "no available ambulance"
                        return
            self.ambulance = "no available ambulance"
        else:
            #Zanalezienie najblizszej karetki wsrod dostepnych
            best = ambulances[0]
            best_dist = 999999999999

            for a in ambulances:
                dist = calc_dist(a.location[0], a.location[1], self.localization[0], self.localization[1])
                if dist < best_dist:
                    best_dist = dist
                    best = a

            self.ambulance = best
            best.change_status()
            best.add_incident(self)