#wczytanie potrzebnych bibliotek
library(jsonlite)
library(httr)
library(sp)
library(sf)
library(maptools)
library(tmaptools)
library(automap)
library(spatstat)

#klucz do api airly
klucz = "xxxxxxxx"
#sciezka do zapisu danych
fileName = "list_inst22.Rdata"
#pobranie danych o czujnikach w odległości 15km od ratusza
r <-
  GET(
    "https://airapi.airly.eu/v2/installations/nearest?lat=50.0617022&lng=19.9373569&maxDistanceKM=15&maxResults=-1",
    add_headers(apikey = klucz, Accept = "application/json")
  )
#zamiana na liste
jsonRespText <- content(r, as = "text")
test15 <- fromJSON(jsonRespText)
#stworzenie ramki z danymi o lokalizacji, wysokości i id czjników
longitude <- test15$location$longitude
latitude <- test15$location$latitude
data15 <- data.frame(longitude, latitude)
data15$elevation <- test15$elev
data15$id <- test15$id
head(data15)
#stworzenie obiektu przestrzennego
data_spat <-
  data.frame(
    lon = data15$longitude,
    lat = data15$latitude,
    elev = data15$elev,
    id = data15$id
  )
coordinates(data_spat) <-
  ~ lon + lat #określamy, które elementy to koordynaty

proj4string(data_spat) <-
  CRS("+proj=longlat +datum=WGS84") #określenie układu wsp.
data_spat #obiekt w układzie sferycznym, który można automatycznie konwertować
#konwersja do UTM
data_UTM <-
  spTransform(data_spat, CRS("+proj=utm +zone=34 +datum=WGS84"))
#utworzenie konturu Krakowa
#utworzenie krakowUTM
dzielnice <-
  st_read("dzielnice_Krakowa.shp") #układ odniesienia(CRS) to ETRS89 (Poland CS92)
#konwersja do WGS84
dzielniceWGS84 <-
  st_transform(dzielnice, crs = 4326) #"4326" to kod dla WGS84
#zostawienie tylko konturu miasta
krakowWGS84 <- st_union(dzielniceWGS84)
#przeksztalcenie na UTM
krakowUTM <-
  st_transform(krakowWGS84, CRS("+proj=utm +zone=34 +datum=WGS84"))
#utworzenie obiektu ppp, tylko z czujnikami w Krakowie
XY <- coordinates(data_UTM)
data15_ppp_id <-
  ppp(
    x = XY[, 1],
    y = XY[, 2],
    marks = data.frame(elev = data_UTM$elev, id = data_UTM$id),
    window = as.owin(krakowUTM)
  )
data15_ppp_id$marks$id #tylko te id które są w Krakowie
#####pobieranie danych z AIRLY dla wybranych czujników (tych z data15_ppp_id)#####
#utworzenie obiektu z liczba czujnikow
n_id <- length(data15_ppp_id$marks$id)
n_id
#utworzenie obiektu z id czujników
id <- data15_ppp_id$marks$id
id
#pusta listę do odczytow z czujnikow
list_inst2 <- vector(mode = "list", length = n_id)
#pobranie danych z czujników AIRLY
for (i in seq(1, n_id)) {
  str <-
    paste(
      "https://airapi.airly.eu/v2/measurements/installation?installationId=",
      id[i],
      sep = ""
    )
  
  #pobranie danych z adresu
  r <-
    GET(url = str, add_headers(apikey = klucz, Accept = "application/json"))
  #przejscie z formatu r na json i z json na tekst
  jsonRespText <- content(r, as = "text")
  inst <- fromJSON(jsonRespText)
  list_inst2[[i]] <- inst #zapisanie odczytu
}

#zapis pełnej listy do pliku
save(list_inst2, file = fileName)
#load("list_inst2.Rdata")
#informacje o pierwszym czujniku
list_inst2[[1]]
########## Przygotowanie danych PM2.5 ##########
#pusty wektor dla danych "current"
current_PM25 <- rep(NA, n_id)
#wyciagnicie wartości "current" PM2.5 za pomocą pętli
for (i in seq(1, n_id)) {
  logic <-
    list_inst2[[i]]$current$values$name == "PM25" #zmienna do wyszukania pól "PM25"
  if (sum(logic) == 1)
    #test, czy istnieje jedno i tylko jedno takie pole
    current_PM25[i] <- list_inst2[[i]]$current$values[logic, 2]
}
#przeksztalcenie obiektu data15_ppp_id do obiektu spdf (aby móc narysować mapę)
data15_spdf_PM25 <- as.SpatialPointsDataFrame.ppp(data15_ppp_id)
coordinates(data15_spdf_PM25)
#dodanie kolumny current_PM25

data15_spdf_PM25$current_PM25 <- current_PM25
#dev.off() #Jesli potrzeba
plot(data15_spdf_PM25)
#Pozbycie sie wartosci NA
miss_PM25 <- is.na(data15_spdf_PM25$current_PM25)
########## Przygotowanie danych Tmp ##########
#stworzenie pustego wektora dla danych "current"
current_tmp <- rep(NA, n_id)
#wyciagniecie wartości "current" PM2.5
for (i in seq(1, n_id)) {
  logic <-
    list_inst2[[i]]$current$values$name == "TEMPERATURE" #do wyszukania pól o nazwie "PM25"
  if (sum(logic) == 1)
    #testujemy, czy istnieje jedno i tylko jedno takie pole
    current_tmp[i] <- list_inst2[[i]]$current$values[logic, 2]
}
#zobaczmy utworzony wektor
current_tmp
#przeksztalcenie obiektu data15_ppp_id do obiektu spdf (aby móc narysować mapę)
data15_spdf_tmp <- as.SpatialPointsDataFrame.ppp(data15_ppp_id)
coordinates(data15_spdf_tmp)
#dodanie kolumny current_PM25
data15_spdf_tmp$current_tmp <- current_tmp
#dev.off() #Jesli potrzeba
plot(data15_spdf_tmp)
#Pozbycie sie wartosci NA
miss_tmp <- is.na(data15_spdf_tmp$current_tmp)

########## Przygotowanie siatki ##########
#wczywanie zrysu krakowa
bound <- st_as_sf(krakowUTM)
plot(bound)
#pobranie współrzędnych punktów konturu w formie macierzy
coord <- as.data.frame(st_coordinates(krakowUTM))
#stworzenie siatki - prostokąt okalajacy kontur Krakowa
#współrzędne naroży
left_down <- c(min(coord$X), min(coord$Y))
right_up <- c(max(coord$X), max(coord$Y))
#ustalenie rozmiaru oczka siatki (100x100 metrów)
size <- c(100, 100)
##przeliczenie ile oczek siatki przypada na długość i szerokość naszego prostokąta
points <- (right_up - left_down) / size
num_points <- ceiling(points) #zaokrąglenie w górę
#stworzenie siatki
grid <- GridTopology(left_down, size, num_points)
#kowersja siatki do WGS84
gridpoints <-
  SpatialPoints(grid, proj4string = CRS("+proj=utm +zone=34 +datum=WGS84"))
plot(gridpoints)
#przyciecie siatki konturem
g <-
  st_as_sf(gridpoints)#konwersja do formatu na którym działa crop_shape
cg <- crop_shape(g, bound, polygon = TRUE)
spgrid <-
  SpatialPixels(as_Spatial(cg))#konwersja z powrotem do st i następnie do SpatialPixels
plot(spgrid)
########## PM2.5 kringing i narysownie map ##########
#Gauss
PM25_auto <-
  autoKrige(
    current_PM25 ~ 1,
    input_data = data15_spdf_PM25[!miss_PM25, ],
    new_data = spgrid,
    model = "Gau"
  )
plot(PM25_auto$krige_output[1], main = "PM 2.5 (Gauss)")
points(data15_ppp_id[!miss_PM25, ], pch = "*", col = "White")
plot(PM25_auto)
#Matérn
PM25_auto <-
  autoKrige(
    current_PM25 ~ 1,
    input_data = data15_spdf_PM25[!miss_PM25, ],
    new_data = spgrid,
    model = "Mat"
  )
plot(PM25_auto$krige_output[1], main = "PM 2.5 (Matérn)")


points(data15_ppp_id[!miss_PM25, ], pch = "*", col = "White")
plot(PM25_auto)
#Exponential
PM25_auto <-
  autoKrige(
    current_PM25 ~ 1,
    input_data = data15_spdf_PM25[!miss_PM25, ],
    new_data = spgrid,
    model = "Exp"
  )
plot(PM25_auto$krige_output[1], main = "PM 2.5 (Exponential)")
points(data15_ppp_id[!miss_PM25, ], pch = "*", col = "White")
plot(PM25_auto)
#Ste
PM25_auto <-
  autoKrige(
    current_PM25 ~ 1,
    input_data = data15_spdf_PM25[!miss_PM25, ],
    new_data = spgrid,
    model = "Ste"
  )
plot(PM25_auto$krige_output[1], main = "PM 2.5 (Ste)")
points(data15_ppp_id[!miss_PM25, ], pch = "*", col = "White")
plot(PM25_auto)
########## Temperatura kringing i narysownie map ##########
#Gauss
tmp_auto <-
  autoKrige(
    current_tmp ~ 1,
    input_data = data15_spdf_tmp[!miss_tmp, ],
    new_data = spgrid,
    model = "Gau"
  )
plot(tmp_auto$krige_output[1], main = "Temperature (Gauss)")
points(data15_ppp_id[!miss_tmp, ], pch = "*", col = "White")
plot(tmp_auto)
#Matern
tmp_auto <-
  autoKrige(
    current_tmp ~ 1,
    input_data = data15_spdf_tmp[!miss_tmp, ],
    new_data = spgrid,
    model = "Mat"
  )
plot(tmp_auto$krige_output[1], main = "Temperature (Matérn)")
points(data15_ppp_id[!miss_tmp, ], pch = "*", col = "White")
plot(tmp_auto)
#Exponenta
tmp_auto <-
  autoKrige(
    current_tmp ~ 1,
    input_data = data15_spdf_tmp[!miss_tmp, ],
    new_data = spgrid,
    model = "Exp"
  )
plot(tmp_auto$krige_output[1], main = "Temperature (Exponential)")
points(data15_ppp_id[!miss_tmp, ], pch = "*", col = "White")
plot(tmp_auto)
#Ste
tmp_auto <-
  autoKrige(
    current_tmp ~ 1,
    input_data = data15_spdf_tmp[!miss_tmp, ],
    new_data = spgrid,
    model = "Ste"
  )
plot(tmp_auto$krige_output[1], main = "Temperature (Ste)")
points(data15_ppp_id[!miss_tmp, ], pch = "*", col = "White")
plot(tmp_auto)