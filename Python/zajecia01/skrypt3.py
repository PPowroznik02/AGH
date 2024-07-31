#Dziwactwa
#1. Przypisanie tworzy referencje, a nie kopie
L = [1,2,3,4]
M = [1,2,3,L,4]
print(f"Wartość zmiennej M przed zmianą L: {M}")
L[1] = "woooow"
print(f"Wartość zmiennej M po zmianie L: {M}")


#2. Powtórzenie dodaje jeden poziom zagłębienia
print("\n")
L = [4,5,6]
X = L * 4
Y = [L] * 4
print(f"X: {X}, Y: {Y}")
L[1] = "wow"
print(f"X: {X}, Y: {Y}")
L = [4,5,6]
Y = [list(L)] * 4
L[1] = "wow"
print(f"Y: {Y}")
Y[0][1] = "wow"
print(f"Y: {Y}")

#Praca z plikami
with open('example.txt', 'r') as file:
 content = file.read()

 print("\n", content)