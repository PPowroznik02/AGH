import itertools
import json
class Kino:
    instances = []
    __max_id = itertools.count()

    def __init__(self):
        self.miejsca = {}
        Kino.instances.append(self)


    def add_chair(self, id):
        self.miejsca[id] = {"status": "nonBooked", "person": ""}

    def reserve_given_seat(self, id, person):
        try:
            if id not in self.miejsca:
                raise KeyError("Couldn't find seat of given ID")
            else:
                for key in self.miejsca:
                    if self.miejsca[key]["person"] != "":
                        if self.miejsca[key]["person"] == person:
                            raise RuntimeError("Person already booked a seat")
                if self.miejsca[id]["status"] == "nonBooked":
                    self.miejsca[id]["status"] = "booked"
                    self.miejsca[id]["person"] = person
                else:
                    raise RuntimeError("Seat is already booked")


        except KeyError as e:
            print(f"Caught an exception: {e}")

        except RuntimeError as e:
            print(f"Caught an exception: {e}")

        except:
             print("Caught an unkwown exception")

    def make_reservation(self, person):
        try:
            for key in self.miejsca:
                if self.miejsca[key]["person"] != "":
                    if self.miejsca[key]["person"] == person:
                        raise RuntimeError("Person already booked a seat")
            for key in self.miejsca:
                if self.miejsca[key]["status"] == "nonBooked":
                    self.miejsca[key]["status"] = "booked"
                    self.miejsca[key]["person"] = person
                    return
            else:
                raise RuntimeError("Couldn't find non-booked seat")
        except RuntimeError as e:
            print(f"Caught an exception: {e}")

        except:
            print("Caught an unkwown exception")


    def cancle_reservation(self, id, person):
        try:
            if self.miejsca[id]["status"] == "booked":
                if self.miejsca[id]["person"] == person:
                    self.miejsca[id]["status"] = "nonBooked"
                    self.miejsca[id]["person"] = ""
                else:
                    raise RuntimeError("Seat was't booked by this person")
            else:
                raise RuntimeError("Seat was't booked")

        except RuntimeError as e:
            print(f"Caught an exception: {e}")

        except:
            print("Caught an unkwown exception")

    def __str__(self):
        return (f"Miejsca: {self.miejsca}")

class Person:
    __max_id = itertools.count()
    instances = []

    def __init__(self, name, surname):
        self.id = next(self.__max_id)
        self.name = name
        self.surname = surname
        Person.instances.append(self)


    def __str__(self):
        return (f"Imie: {self.name}, Nazwisko: {self.surname}")

if __name__ == "__main__":
    ids = ["A1", "A2", "A3", "A4", "A5", "B1", "B2", "B3", "B4", "B5"]
    booked_ids = ["A2", "A3", "A5", "B2", "B4", ]

    person1 = Person("Jan", "Maj")
    person2 = Person("Jakub", "Nowicki")
    person3 = Person("Paulina", "Zak")
    person4 = Person("Iga", "Cygan")

    kino1 = Kino()

    #dodanie nowych miejsc
    for id in ids:
        kino1.add_chair(id)

    #dodanie rezerwacji
    kino1.reserve_given_seat("B4", person1)
    kino1.reserve_given_seat("A2", person2)
    kino1.make_reservation(person3)
    kino1.make_reservation(person4)

    #Wyjatek osoba juz zarezerwowala miejsce
    kino1.make_reservation(person4)
    kino1.reserve_given_seat("A2", person2)


    #usuniecie rezerwacji
    kino1.cancle_reservation("B4", person1)

    #Wyjatek miejsce jest juz zarezerwowane
    kino1.reserve_given_seat("A2", person1)

    #Wyjatek nie ta osoba zarezerwowala to mijsce
    kino1.cancle_reservation("A2", person1)

    print(kino1)