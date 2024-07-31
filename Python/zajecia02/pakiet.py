import json
import this



#Przypisania

#6.
dane = (2024, 'Python', 3.8)
rok, jezyk, wersja = dane
print(rok, jezyk, wersja)

#7.
oceny = [4,3,5,2,5,4]
pierwsza, *srodek, ostatnia = oceny
print(srodek)

#8.
info = ("Jan", "Kowalski", 30, "Polska", "programista")
imie, nazwisko, _, _, zawod = info
print(imie, nazwisko, zawod)

#9.
dane = (2024, ["Python", 3.8, ("Stabilna", "Wersja")])
rok = dane[0]
jezyk = dane[1][0]
opis = dane[1][2][0] + " " + dane[1][2][1]
print(f"9: Rok: {rok}, Jezyk: {jezyk}, Opis: {opis}")

#Przypisania z wieloma celami i współdzielone referencje
#10.
a = b = [1,2,3]
b[0] = 'zmieniono'
print("10: ", a, b)

#11.
c = a[:]
c[0] = "nowa wartosc"
print("11: ", a,b,c)

#12.
x = y = 10
y += 1
print("12: ", x, y)
#Int nie sa mutowalne

#Przypisania rozszerzone i współdzielone referencje
#13.
print("13:")
K = [1, 2]
L = K
print(L, K)
K = K + [3, 4]
print(L, K)
M = [1, 2]
N = M
print(N, M)
M += [3, 4]
print(N,M)

#14.
imiona = ["Anna", "Jan", "Ewa"]
oceny = [5,4,3]
print("14: ")

for i, j in zip(imiona, oceny):
    print(i, j)

#15.
liczby = [1,2,3,4,5]

def kwadrat(x):
    return x ** 2

kwadrarty = map(kwadrat, liczby)
print("15: ", list(kwadrarty))

#16.
def zmien_wartosc(arg):
    if isinstance(arg, int):
        arg = 654822
    elif isinstance(arg, list):
        arg[0] = 'kalafior'

a1 = 123
b1 = [1,2,3,4]
print("16_przed:", a1, b1)
zmien_wartosc(a1)
zmien_wartosc(b1)
print("16_po:", a1, b1)
#Integer jest nie mutowalny, po wywolaniu funkcji a1 bedzie mialo taka sama wartosc jak na poczatku
#Lista jest mutowalna, po wywolaniu funkcji pierwszy element w liscie zostanie zamieniony



#17.
print("17: ")
def zamowienie_produktu(nazwa_produktu, *, cena=1, ilosc):
    wartosc = cena * ilosc
    tekst = f"Zmówiono {nazwa_produktu} w ilosci: {ilosc} o lacznej wartosci zmowienia rownej:{wartosc}"
    return([tekst, wartosc])

produkty = []
produkty.append(zamowienie_produktu("piegi",cena=2,ilosc=50))
produkty.append(zamowienie_produktu("lód",cena=4,ilosc=12))
produkty.append(zamowienie_produktu("kompot",cena=7,ilosc=5))
produkty.append(zamowienie_produktu("liście",ilosc=57))

suma = 0
for p in produkty:
    print(p[0])
    suma += p[1]

print("Suma zamowienia: ", suma)


#18.
import json
print("18: ")
def stworz_raport(*args, **kwargs):
    dict = {}
    for key, val in kwargs.items():
        tmp = key.split("_")
        if(int(tmp[1]) in args):
            if int(tmp[1]) not in dict:
                dict[int(tmp[1])] = {"cena": "", "nazwa": ""}
            if tmp[0] == "cena":
                dict[int(tmp[1])]["cena"] = val
            elif tmp[0] == "nazwa":
                dict[int(tmp[1])]["nazwa"] = val
    #print (json.dumps(dict, indent=2))

    for key, val in dict.items():
        print(f'Zamowiono produkt: {dict[key]["nazwa"]}, cena produktu wynosi: {dict[key]["cena"]}')



stworz_raport(101, 102, nazwa_101="Kubek termiczny", cena_101="45.99 zl", nazwa_102="Dlugopis", cena_102="4.99 zl")
#podane wywolanie funkcji powodowalo zwrocenie komunikatu o bledzie: invalid decimal literal
#zmienilem parametry z "101_nazwa" na "nazwa_101"


#19.
print("19:")
def stworz_funkcje_potegujaca(wykladnik):
    print("aaa")
    def potega(podstawa):
        return (podstawa ** wykladnik)
    return potega

potega_2 = stworz_funkcje_potegujaca(2) 
print(potega_2(4))


#21.
print("21: ")
def silnia(n: int) -> int:
    if n < 0:
        return 0
    if n == 0 or n == 1:
        return 1
    else:
        return n * silnia(n - 1)

print("Wynik: ", silnia(5))
print("Adnotacje: ", silnia.__annotations__)

#22.
print("22: ")
ksiazki = [
    {'tytul': "Lot nad kukulczym gniazdem", 'autor': "Ken Kesey", 'rok_wydania': 1975},
    {'tytul': "1984", 'autor': "George Orwell", 'rok_wydania': 1949},
    {'tytul': "Smetarz dla zwierzakow", 'autor': "Stephen King", 'rok_wydania': 1983},
    {'tytul': "Tuf Wedrowiec", 'autor': "George R.R. Martin", 'rok_wydania': 1986},
    {'tytul': "Mur", 'autor': "Jean-Paul Sartre", 'rok_wydania': 1939},
    {'tytul': "Artemis", 'autor': "Andy Weir", 'rok_wydania': 2017},
    {'tytul': "Extensa", 'autor': "Jacek Dukaj", 'rok_wydania': 2002},
]

sort_by_year = lambda ksiazki: sorted(ksiazki, key=lambda d: d['rok_wydania'])
filter_by_year = lambda ksiazki: filter()

ksiazki = sort_by_year(ksiazki)
nowe_ksiazki = list(filter(lambda k: k["rok_wydania"] > 2000, ksiazki))
tytuly_ksiazki = list(map(lambda k: k["tytul"],ksiazki))
#print(json.dumps(ksiazki, indent=2))
print(ksiazki)
print(nowe_ksiazki)
print(tytuly_ksiazki)

#23.
def generator():
    yield "Poniedzialek"
    yield "Wtorek"
    yield "Sroda"
    yield "Czwartek"
    yield "Piatek"
    yield "Sobota"
    yield "Niedziela"

for i, value in enumerate(generator()):
    print(value, end=", ")

print()
for i, value in enumerate(generator()):
    if i >= 3:
        break
    print(value, end=", ")

__all__ = ["kwadrat", "zmien_wartosc", "zamowienie_produktu", "stworz_raport", "stworz_funkcje_potegujaca", "silnia", "generator"]
