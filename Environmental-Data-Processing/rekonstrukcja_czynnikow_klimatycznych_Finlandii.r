#Zaladowanie potrzebnych bibliotek
library(ncdf4)
library(chron)
library(lattice)
library(RColorBrewer)
library(zoo)
library(animation)
library(dplR)
library(treeclim)
library(lubridate)
### Wstepne przygotowanie danych ###
finl010_chron <- read.crn("finl010r.crn")
head(finl010_chron)
ncin <- nc_open("cru_ts4.07.1901.2022.tmp.dat.nc")
#Grid eye center: Lat 62.75, Lon 25.25 E
lon <- ncvar_get(ncin, "lon")
lat <- ncvar_get(ncin, "lat")
time <- ncvar_get(ncin, "time")
dim(time)
lon_i <- which(lon == 25.25)
lat_i <- which(lat == 62.75)
lon_i
lat_i
#pobranie danych dla odpowiedniego oczka siatki
tmp_finl010 <-
  ncvar_get(ncin,
            "tmp",
            start = c(lon_i, lat_i, 1),
            count = c(1, 1, 1464))

plot(tmp_finl010, t = "l")
#Stworzenie zmiennej z datami
time <- ncvar_get(ncin, "time")
tunits <- ncatt_get(ncin, "time", "units")
tustr <- strsplit(tunits$value, " ")
tdstr <- strsplit(unlist(tustr)[3], "-")
tmonth <- as.integer(unlist(tdstr)[2])
tday <- as.integer(unlist(tdstr)[3])
tyear <- as.integer(unlist(tdstr)[1])
time_ch <- chron(time, origin = c(tmonth, tday, tyear))
time_m_y <- as.yearmon(time_ch)
Sys.setlocale("LC_TIME", "C")
time_m_y <- as.yearmon(time_ch)
time_m_y
#stworzenie wektorow z latami i miesiacami
year <- year(time_m_y)
month <- rep(seq(1, 12), length(unique(year)))
#stworzenie ramki danych z danych temperaturowych
clim_tmp_finl010 <- data.frame(year, month, tmp_finl010)
clim_tmp_finl010
#Wykres korelacji stacjonarnej
finl010_static <-
  dcc(finl010_chron,
      clim_tmp_finl010,
      selection = 1:9,
      method = "correlation")
plot(finl010_static) #Korelacja tmp z danymi dendro
#Miesiace o istotnych wartosciach korelacji: 7, 8
#Wyciagniecie danych temperaturaowych dla miesiecy o istotnych wartosciach korelacji
tmp7_finl010 <- tmp_finl010[seq(7, 1464, 12)]
tmp8_finl010 <- tmp_finl010[seq(8, 1464, 12)]

## Wstepne przeksztalcenia danych ##
years <- seq(1901, 1978, 1)
#przeksztalcenie lat w wektor numeryczny
years_chron <- as.numeric(row.names(finl010_chron))
#zdefiniowanie poczatku i konca okresu wspolnego
start_chron <- which(years_chron == 1901)
end_chron <- length(finl010_chron[, 1])
#wybranie danych dendro
comm_chron <- finl010_chron[start_chron:end_chron, 1]
comm_chron
#przyciecie danych temperaturowych dla wszystkich miesiecy
comm_tmp7 <- tmp7_finl010[1:(max(years_chron) - 1900)]
comm_tmp8 <- tmp8_finl010[1:(max(years_chron) - 1900)]
#stworzenie ramki danych z chronologia i temperaturami lipca i sierpnia
data <- data.frame(comm_chron, comm_tmp7, comm_tmp8)
#sprawdzenie korelacji 7 i 8 miesiaca
cor.test(data$comm_chron, data$comm_tmp7)
cor.test(data$comm_chron, data$comm_tmp8)
#miesiace istotne 7, 8
#najwyzsza wartosc korelacji dla 7 miesiaca
mod_f_lipiec <- lm(comm_tmp7 ~ comm_chron, data)
plot(data$comm_chron, data$comm_tmp7)
abline(mod_f_lipiec, data)

#proba rekonsturkcji, kalibracja/weryfikacja
#podzielenie okresu na przedzialy (1901-1939 oraz 1940-1978).
#kalibracja na okresie 1940-1978
data1 <- data[40:78, ]
mod_1 <- lm(comm_tmp7 ~ comm_chron, data1)
summary(mod_1)
#Model jest istotny statystycznie
#sprawdzenie korelacji w przedziale 1940-1978
cor.test(data1$comm_tmp7, data1$comm_chron)
#weryfikacja na okresie 1901-1939
data2 <- data[1:39, ]
data2
#sprawdzenie jak model sie sprawdza dla danych se starszego okresu
cor.test(data2$comm_tmp7, predict(mod_1, data2))
#korelacja jest istotna, mozna zastosowac model
#predstawienie danych rzeczywistych i tych wymodelowanych
plot(years[40:78], data1$comm_tmp7, t = "l")
lines(years[40:78], predict(mod_1, data1), t = "l", col = "Red")
#tak samo dla okresu starszego
plot(years[1:39], data2$comm_tmp7, t = "l")
lines(years[1:39], predict(mod_1, data2), t = "l", col = "Red")
#polaczenie wykresow w celu lepszego zobrazowania danych
plot(years[1:78], data$comm_tmp7, t = "l")
lines(years[1:78], predict(mod_1, data), t = "l", col = "Red")
#sprawdzenie danych o utworzonym wczesniej modelu dla okresu wspolnego
summary(mod_f_lipiec)

#przedstawienie temperatur odtworzonych przy uzyciu modelu wraz z ich rzeczywistymi wartosciami
plot(years[1:78], data$comm_tmp7, t = "l")
lines(years[1:78],
      predict(mod_f_lipiec, data),
      t = "l",
      col = "Blue")
#wykorzystanie modelu do odtworzenia temperatury lipca dla okresu gdzie tych dznych brakuje
data3 <- data.frame (comm_chron = finl010_chron[, 1])
finl010_tmp7_reconst <- predict(mod_f_lipiec, data3)
finl010_tmp7_reconst
#przedstawienie odtworzonych temperatur na wykresie
plot(years_chron, finl010_tmp7_reconst, t = "l")