#Zadanie 1. Wektor
#a) Utwórz zmienną, która będzie przechowywać liczbę osób, które uczęszczają na zajęcia w podanym dniu tygodnia.
#Nazwij zmienną lista_obecnosci i nadaj nazwy poszczególnym wartościom. Wartości zmiennej: 25, 30, 16, 20, 10, 21, 12.
lista_obecnosci <- c(25, 30, 16, 20, 10, 21, 12)

#b) Wyświetl, ile osób uczestniczyło w zajęciach w poniedziałek i piątek.
lista_obecnosci[1]
lista_obecnosci[5]

#c) Wyświetl dni z największą i najmniejszą liczbą uczestników.
which.min(lista_obecnosci)
which.max(lista_obecnosci)

#d) Oblicz, ile średnio osób uczestniczyło w zajęciach.
mean(lista_obecnosci)

#e) Policz w ile dni frekwencja była wyższa lub równa 20 osób.
sum(lista_obecnosci >= 20)

#f) Utwórz zmienną, która przechowuje liczbę osób, która powinna brać udział w zajęciach.
#Nazwij ją: liczebnosc_grup i przypisz jej wartości: 25, 30, 18, 20, 15, 21, 15.
liczebnosc_grup <- c(25, 30, 18, 20, 15, 21, 15)

#g) Sprawdź w jakie dni na zajęciach uczestniczyło 100% osób.
lista_obecnosci == liczebnosc_grup

#h) Sprawdź w jakie dni na zajęciach uczestniczyło mniej niż 50% osób
lista_obecnosci <= 0.5*liczebnosc_grup


#Zadanie 2. Macierz
#a) Napisz kod, który da następujący wynik:
#                         US        non-US
#A New Hope               460.998   314.4
#The Empire Strikes Back  290.475   247.9
#Return of the Jedi 3     09.306    165.8
filmy <- matrix(c(460.998, 314.4, 290.475, 247.9, 09.306, 165.8), nrow=3, ncol=2)
colnames(filmy) <- c("US", "non-US")
rownames(filmy) <- c("A New Hope", "The Empire Strikes Back", "Return of the Jedi 3")

#b) Wybierz z macierzy ostatni wiersz danych.
filmy[3,]

#c) Wybierz z macierzy wartość 314.4.
filmy[1,2]


#Zadanie 3. Dataframe
#• Napisz kod, który da następujący wynik:
#  name type diameter rotation rings
#1 Mercury Terrestrial planet 0.382 58.64 FALSE
#2 Venus Terrestrial planet 0.949 -243.02 FALSE
#3 Earth Terrestrial planet 1.000 1.00 FALSE
#4 Mars Terrestrial planet 0.532 1.03 FALSE
#5 Jupiter Gas giant 11.209 0.41 TRUE
#6 Saturn Gas giant 9.449 0.43 TRUE
#7 Uranus Gas giant 4.007 -0.72 TRUE
#8 Neptune Gas giant 3.883 0.67 TRUE
planety <- data.frame(
  name = c("Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"),
  type = c("Terrestrial planet", "Terrestrial planet", "Terrestrial planet", "Terrestrial planet", "Gas giant", "Gas giant", "Gas giant", "Gas giant"),
  diameter = c(0.382, 0.949, 1.000, 0.532, 11.209, 9.449, 4.007, 3.883),
  rotation = c(58.64, -243.02, 1.00, 1.03, 0.41, 0.43, -0.72, 0.67),
  rings = c(FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE))

#• Wybierz średnice dla Marsa (diameter),
planety$diameter[4]

#• Wybierz całość danych dla Uranus,
planety %>% slice(7)

#• Sprawdź strukturę utworzonej data frame
str(planety)

#• Wyświetl informacje o pierścieniach (rings),
planety$rings

#• Utwórz zmienną planets_rings w której będą tylko te planety które mają pierścienie,
planets_rings <- subset(planety, rings == TRUE)

#• Utwórz podzbiór zawierający planety o średnicy mniejszej niż 1,
small_planets <- subset(planety, diameter < 1)

#Zadanie 4. Wektory czynnikowe
#• Utwórz 2 wektory czynnikowe (factors), w tym jeden typu ordered.
directions <- factor(c("North", "North", "West", "East", "West", "North"), levels = c("North", "East", "South", "West"))
directions_ordered <- factor(c("North", "North", "West", "East", "West", "North"), levels = c("North", "East", "South", "West"), ordered = TRUE)

#• Sprawdź typ danych.
class(directions)
class(directions_ordered)

#• Policz liczebność obserwacji należących do określonej klasy.
summary(directions)


#Zadanie 5. Funkcja
#Napisz funkcję, która będzie wystawiać oceny na podstawie arkusza i Regulaminu Studiów AGH.
#Ocena może być wyliczona jeśli Student ma minimum 50% obecności. Jeśli nie spełnia tego warunku,
#zamiast oceny powinno wyświetlać się „brak zaliczenia”. Waga dla kolokwium to 0.9, dla każdej z
#pozostałych aktywności 0.05. W przypadku nie zaliczenia kolokwium ocena końcowa 2.0.

#liczba_obecności ocena_kolokwium ocena kartkowka ocena_aktywnosc
#max 15 100 100 100

fun <- function(){
  
}


#Zadanie 6. Pakiet dplyr
library(dplyr)
library(gapminder)
#• Wykonaj filtrowanie danych gapminder dla Chin z roku 2002.
gapminder %>% filter(year == 2002, country == "China")

#• Wykonaj filtrowanie danych gapminder dla roku 1957 i wykonaj sortowanie wyników według zmiennej pop.
gapminder %>% filter(year == 1957) %>% arrange(desc(pop))

#• Dla danych z roku 2007, utwórz nową zmienną w obrębie gapminder 
  #- lifeExpMonths=lifeExp*12
  #- posortuj wyniki według nowo utworzonej zmiennej od najwyższych do najniższych wartości.
gapminder %>% filter(year == 2007) %>% rowwise() %>% mutate(lifeExpMonths = lifeExp*12) %>% arrange(desc(lifeExpMonths))

#• Dla danych z roku 1957 oblicz medianę z lifeExp i umieść w zmiennej medianLifeExp oraz
#maksimum z gdpPercap i umieść w zmiennej maxGdpPercap.
medianLifeExp <- gapminder %>% filter(year == 1957) %>% pull(lifeExp) %>% mean
maxGdpPercap <- gapminder %>% filter(year == 1957) %>% pull(gdpPercap) %>% max

#• Dla pogrupowanych danych według kontynentu i roku, oblicz medianę z lifeExp i umieść w
#zmiennej medianLifeExp oraz wartość średnią z gdpPercap i umieść w zmiennej meanGdpPercap.
medianLifeExp <- gapminder %>% group_by(continent, year) %>% pull(lifeExp) %>% median
meanGdpPercap <- gapminder %>% group_by(continent, year) %>% pull(lifeExp) %>% mean

#Zadanie 7. Import i export danych
#• Zaimportuj pliki za pomocą funkcji i przypisz do odpowiadających im nazw zmiennych,
Series_G <- read.csv("Series_G.csv", sep="\t", header = FALSE)
Real_estate <- read.csv("Real_estate.csv")

#• Sprawdź poprawność danych,
Series_G
Real_estate

#• Wyeksportuj zmienne do pliku *.csv
write.csv(Series_G,"Series_G2.csv", row.names=FALSE)
write.csv(Real_estate,"Real_estate2.csv", row.names=FALSE)

#• Powtórz z wykorzystaniem RStudio okna importu

#Zadanie 8.
#Dla zaimportowanych danych z zadania 7 wykonaj odpowiednie wykresy wykorzystując pakiet graphics
#i ggplot2. Wykresy do wykonania:
library(ggplot2)
#- histogram,
hist(Real_estate$Y.house.price.of.unit.area)
hist(Series_G$V1)

#- wykres rozrzutu,
ggplot(data=Real_estate, aes(X2.house.age, Y.house.price.of.unit.area) ) + 
  geom_point()

#- wykres ramka-wąsy z uwzględnieniem zmiennej jakościowej,
ggplot(data=Real_estate, aes(X2.house.age, Y.house.price.of.unit.area) ) + 
  geom_boxplot() 

boxplot(Real_estate, notch = TRUE, log="y")
#- wykres liniowy.
ggplot(data=Real_estate, aes(X2.house.age, Y.house.price.of.unit.area) ) + 
  geom_line() + 
  geom_point()
  

#Zadanie 9.
#Utwórz raport RMarkdown z zadań 2, 3, 5, 8. Wygeneruj go do wybranego typu dokumentu.
#W dokumencie powinny być widoczne fragmenty kodu, wyniki, wizualizacje oraz Państwa komentarze.

