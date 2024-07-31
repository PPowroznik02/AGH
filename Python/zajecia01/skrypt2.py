import math
import random
import json

#Działania matematyczne
wartosc = 100

dodawnie = wartosc + 123.15
print(dodawnie)

potega = math.pow(dodawnie, 12)
print(potega)

tekst = str(potega)
print(type(tekst))

wartosc_pi = math.pi
print(wartosc_pi)

losowa = random.randint(1,5)
print(losowa)

#Łańcuchy znaków
tekst = f"Wartosc: {tekst}"
print(tekst)

print(len(tekst))
print(tekst[1:4])

print(dir(tekst))

tekst = tekst.upper()
print(tekst)

tekst = tekst[0:1] + tekst[1].lower() + tekst[2:len(tekst)]
print(tekst)

#listy
lista = list(tekst.strip())
print(type(lista), lista)

lista = lista[0:8]
print(lista)

#print(dir(lista))

lista = lista.__add__([[1,2,3,4,5]])
lista.remove(':')
print(lista)

lista2 = [1,2,3, "banan", 100]

lista3 = []
for i in lista2:
    if i != "banan":
        lista3.append(int(math.pow(i,2)))
print(lista3)

lista4 = [*range(2,16,2)]
print(lista4)

#Słowniki
ja = {}
ja["imie"] = "Piotr"
ja["nazwisko"] = "Powroznik"
ja["wiek"] = 22
ja["rodzice"] = {"imie": ["Joanna", "Mieczyslaw"], "wiek": [55, 65]}

print(ja)
#print(json.dumps(ja, indent=5))

print(ja["rodzice"])
print(ja["rodzice"]["imie"][0])
print(ja.keys())

if "rodzenstwo" in ja:
    print(True)
else:
    print(False)

#krotki
krotka1 = (1,2,"3",4,2,5)
print("Dlugosc: ", len(krotka1))
print("Wartosc: ", krotka1[0])
print(krotka1.count(2))
#krotka1[1] = 2 #immutable
#print(krotka1)

#Zbiory
X = set("kalarepa")
Y = set("lepy")

print(Y & X)

#Instrukcje
#1.
imiona = ["Michal", "Andrzej", "Matylda", "Weronika"]

for id, i in enumerate(imiona):
    print("Imie: ", i, "Index: ", id)

#2.a.
liczby = [11, -23, 12, -5, 8, -99, 10]
for l in liczby:
    if (l >= 0) and (l % 2 == 0):
        print("Liczba: ", l, "Liczba jest dodatnia i parzysta")

#2.b.
liczba = input("Wprowadz liczbe: ")

if liczba != "0":
    print("Liczba jest różna od zera")
else:
    print("Liczba jest równa zero")

#2.c.
owoce = ['jabłko', 'banan', 'pomarańcza']

owoc = input("Wprowadz owoc: ")

if owoc in owoce:
    print("Owoc jest dostepny")

#3.

sum = 0
while(sum <= 100):
    n = input("Podaj liczbę: ")
    sum += int(n)

print(sum)

#