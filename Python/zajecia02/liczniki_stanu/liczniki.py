#20.
def licznik1():
    count = 0
    def wewn():
        nonlocal count
        count += 1
        return count
    return wewn


counter = 0
def licznik2():
    global counter
    counter += 1
    print("licznik2: ", counter)

class licznik3:
    def __init__(self):
        self.count = 0

    def __call__(self):
        self.count += 1
        return self.count


def licznik4():
    if hasattr(licznik4, 'count'):
        licznik4.count += 1
    else:
        licznik4.count = 1
    return licznik4.count


__all__ = ["licznik1", "licznik2", "licznik3", "licznik4"]