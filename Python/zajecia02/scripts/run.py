import sys
import os
parent_path = os.path.dirname(sys.path[0])
sys.path.append(parent_path)

import pakiet
from liczniki_stanu import liczniki


#20.
print("20:")
licznik1 = liczniki.licznik1()
print("licznik1: ", licznik1())
print("licznik1: ", licznik1())
print("licznik1: ", licznik1())

liczniki.licznik2()
liczniki.licznik2()
liczniki.licznik2()

licznik3 = liczniki.licznik3()
print("licznik3: ", licznik3())
print("licznik3: ", licznik3())
print("licznik3: ", licznik3())


print("licznik4: ", liczniki.licznik4())
print("licznik4: ", liczniki.licznik4())
print("licznik4: ", liczniki.licznik4())
