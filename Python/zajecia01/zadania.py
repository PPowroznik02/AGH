#Wczytaj jako słownik plik z rozszerzeniem JSON (przydatny może okazać się pakiet json). Zapisz do
#zmiennej połączone wszystkie teksty z pliku. Zmodyfikuj następująco ten tekst:
import json

with open('teksty.json', 'r') as file:
    content = json.load(file)
#print("\n", content)

text = ""
for val in content["teksty"]:
    for key, v in val.items():
        #print(v)
        text += v


print("\n", text)


#- Zamień wszystkie duże litery na małe,
text = text.upper()
print(text)
#- Podziel go na wyrazy - będzie to najprawdopodobniej lista,
list = text.split(" ")
print(list)
#- Usuń znaki interpunkcyjne – w tekście występują jedynie kropki i przecinki,
for n, word in enumerate(list):
    list[n] = list[n].replace(".", "")
    list[n] = list[n].replace(",", "")

print(list)
#- Zmodyfikuj tak każdy wyraz, żeby w każdym ostatni znak był w formacie dużej litery np. wyraz KozA,
for n, word in enumerate(list):
    word = word.lower()
    list[n] = word[:-1] + word[-1].upper()


print(list)
#- Z listy usuń wyrazy, które nie posiadają w sobie znaku a lub A - można wykorzystać składnię list składanych,
for word in list[:]:
    if "a" not in word and "A" not in word:
        list.remove(word)

print(list)
#- Stwórz zmienną, które będzie przechowywać wszystkie unikatowe wyrazy - można wykorzystać zbiory,
uniq = set(list)

print(uniq)

#- Stwórz zmienną, która będzie przetrzymywać ilość wystąpień dla każdego ze słów występujących w tekście - można wykorzystać słowniki
counted_words = {}
for el in uniq:
    counted_words[el] = list.count(el)

print(counted_words)