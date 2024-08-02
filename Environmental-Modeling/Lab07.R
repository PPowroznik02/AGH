#pora na statystyki przestrzenne
library(spatstat)
library(rgdal)
library(sf)

#mapa
library(maptools)
library(automap)
library(raster)

data<-read.csv("Wyniki_em_2019.csv",header=TRUE,encoding="UTF-8")

#szerokoœci (latitude)
#usuniêcie "\" z koñca stringa (ostatni znak)
pom0<-substr(data$Szerokoœæ.geograficzna,1,nchar(data$Szerokoœæ.geograficzna)-1)

#podzia³ na stopnie minuty sekundy (kto tak wpisuje wsp. geograficzne)
pom1<-strsplit(pom0, "°" )
pom2<-strsplit(unlist(pom1), "' " )

#wszystko po kolei
lats<-as.numeric(unlist(pom2))

#pierwsze wartoœci stopnie, drugie minuty itp.
d<-lats[seq(1, length(lats), 3)]
m<-lats[seq(2, length(lats), 3)]
s<-lats[seq(3, length(lats), 3)]

#do decimal
lat<-d+m/60+s/3600

#TO SAMO DLA D£UGOŒCI :)
pom10<-substr(data$D³ugoœæ.geograficzna,1,nchar(data$D³ugoœæ.geograficzna)-1)

pom11<-strsplit(pom10, "°" )
pom12<-strsplit(unlist(pom11), "' " )

lons<-as.numeric(unlist(pom12))

#stopnie, min, sek dla d³ugoœci
d<-lons[seq(1, length(lons), 3)]
m<-lons[seq(2, length(lons), 3)]
s<-lons[seq(3, length(lons), 3)]

#do decimal
lon<-d+m/60+s/3600

#od razu wartoœci pola
value<-as.numeric(data$Wynik.pomiaru..V.m.)
####value[value<0.3]<-0.3

# budujemy ramki danych dla Polski
dataP<-data.frame(longitude=lon,latitude=lat)
dataP$value<-value


#wyczytanie danych z pliku shape
dzielnice<-st_read("dzielnice_Krakowa.shp")
wojewodztwa<-st_read("Wojewodztwa.shp")
# malopolskie<-wojewodztwa["JPT_NAZWA_"=="ma³opolskie"]
# malopolskie<-wojewodztwa[10,]


#transformacja do WGS
dzielniceWGS<-st_transform(dzielnice,crs = 4326)
wojewodztwaWGS<-st_transform(wojewodztwa,crs = 4326)


#nie chcemy podzia³y na dzielnice wiêc je wszystkie ³¹czymy ze sob¹ 
#krakowWGS<-st_union(st_geometry(dzielniceWGS))
woj<-wojewodztwaWGS[1,'geometry']
krakowWGS<-st_union(st_geometry(woj))

#trzeba przejœæ ze sfery (lat lon) na p³ask¹ mapê w ukladzie utm (ma³opolska jest w 34N)
krakowUTM<-st_transform(krakowWGS,CRS("+proj=utm +zone=34N +datum=WGS84"))
# malopolskieUTM<-st_transform(malopolskieWGS,CRS("+proj=utm +zone=34N +datum=WGS84"))


# to samo z naszymi danymi o czujnikach
data_spat<-data.frame(lon=dataP$longitude,lat=dataP$latitude,value=dataP$value)
coordinates(data_spat) <- ~lon+lat
proj4string(data_spat) <- CRS("+proj=longlat +datum=WGS84")
data_spat
#^ to jest obiekt w uk³adzie sferycznym który mo¿na ju¿ automatycznie konwertowaæ

#konwersja
data_UTM <- spTransform(data_spat, CRS("+proj=utm +zone=34N +datum=WGS84"))

# stworzenie obiektu ppp 2D
dataP_ppp<-ppp(x=data_UTM$lon,y=data_UTM$lat,window=as.owin(krakowUTM))
# dataP_malopolskie<-ppp(x=data_UTM$lon,y=data_UTM$lat,window=as.owin(malopolskieUTM))

#stworzenie ppp z marks czyli z danymi w punktach (tu wartoœæ pola)
dataP_ppp_v<-ppp(x=data_UTM$lon,y=data_UTM$lat,marks=data_UTM$value,window=as.owin(krakowUTM))
# dataP_malopolskie_v<-ppp(x=data_UTM$lon,y=data_UTM$lat,marks=data_UTM$value,window=as.owin(malopolskieUTM))


#porówanie plotow
plot (dataP_ppp)
plot (dataP_ppp_v)

# plot (dataP_malopolskie)
# plot (dataP_malopolskie_v)

#znowu konwersja :)
dataP_spdf<-as.SpatialPointsDataFrame.ppp(dataP_ppp_v)
# malopolskie_spdf<-as.SpatialPointsDataFrame.ppp(dataP_malopolskie_v)

spplot(dataP_spdf)
coordinates(dataP_spdf)

# spplot(malopolskie_spdf)
# coordinates(malopolskie_spdf)

# Ordinary Kriging
elev_auto <- autoKrige(marks ~ 1, input_data = dataP_spdf,model = "Mat")
# elev_malopolskie <- autoKrige(marks ~ 1, input_data = malopolskie_spdf,model = "Mat")
plot(elev_auto)
# plot(elev_malopolskie)

#plot tylko dla estymacji parametru 
plot(elev_auto$krige_output[1])
points(dataP_ppp_v,pch="*",col="White")
plot(Window(dataP_ppp_v),add=TRUE)
plot(krakowUTM,add=TRUE,border="Black")

# plot(elev_malopolskie$krige_output[1])
# points(dataP_malopolskie_v,pch="*",col="White")
# plot(Window(dataP_malopolskie_v),add=TRUE)
# plot(malopolskieUTM,add=TRUE,border="Black")


#okreœlenie siatki punktów w których bêdzie dokonywana aproksymacja dowoln¹
#metod¹, z jakim dystansem i ile punktów w dwóch kierunkach
coord<-as.data.frame(st_coordinates(krakowUTM))
left_down<-c( min(coord$X), min(coord$Y))

# coord_malopolskie<-as.data.frame(st_coordinates(malopolskieUTM))
# ld_malopolskie<-c( min(coord_malopolskie$X), min(coord_malopolskie$Y))

#rozmiar oczka siatki w metrach
size<-c(100,100)

#wyliczenie ile puntów potrzeba w najwiêkszym wymiarze
right_up<-c( max(coord$X), max(coord$Y))
points<- (right_up-left_down)/size
num_points<-ceiling(points)

# ru_malopolskie<-c( max(coord_malopolskie$X), max(coord_malopolskie$Y))
# points_malopolskie<- (ru_malopolskie-ld_malopolskie)/size
# np_malopolskie<-ceiling(points_malopolskie)

bound<- GridTopology(left_down, size,num_points)####format sp - dla Krakowa dzia³a!
# bound_malopolskie<- GridTopology(ld_malopolskie, size,np_malopolskie)

eps<-10
num_points<-num_points+eps
# np_malopolskie<-np_malopolskie+eps

grid <- GridTopology(left_down, size,num_points)
# grid_malopolskie <- GridTopology(ld_malopolskie, size,np_malopolskie)

# kowersja do odpowiedniego formatu w odpowiednim uk³adzie
gridpoints <- SpatialPoints(grid, proj4string = CRS("+proj=utm +zone=34N +datum=WGS84"))
# gp_malopolskie <- SpatialPoints(grid_malopolskie, proj4string = CRS("+proj=utm +zone=34N +datum=WGS84"))
# plot(gp_malopolskie)

#przyciêcie do prostok¹t w którym mieœci siê Krakow
#to ju¿ jest w zasadzie zrobione wczeœniej w GridTopology
#ale zosta³o zepsute (+ eps) po to ¿eby pokazaæ efekt
cropped_gridpoints <- crop(gridpoints,bound )
plot(cropped_gridpoints,add=TRUE,col="Red")

# cgp_malopolskie <- crop(gp_malopolskie,bound_malopolskie )
# plot(cgp_malopolskie,add=TRUE,col="Red")

# konwersja do SpatialPixels
spgrid <- SpatialPixels(cropped_gridpoints)
coordnames(spgrid) <- c("x", "y")

# spgrid_malopolskie <- SpatialPixels(cgp_malopolskie)
# coordnames(spgrid_malopolskie) <- c("x", "y")

#Zobaczmy jak to wygl¹da teraz
elev_auto <- autoKrige(marks ~ 1, input_data = dataP_spdf,new_data=spgrid,model = "Mat")
plot(elev_auto$krige_output[1])
points(dataP_ppp_v,pch="*",col="White")
plot(krakowUTM,add=TRUE,border="White")

plot(elev_auto$krige_output[3])


# elev_malopolskie <- autoKrige(marks ~ 1, input_data = malopolskie_spdf,new_data=spgrid_malopolskie,model = "Mat")
# plot(elev_malopolskie$krige_output[1])
# points(dataP_malopolskie_v,pch="*",col="White")
# plot(malopolskieUTM,add=TRUE,border="White")
# 
# plot(elev_malopolskie$krige_output[3])

# Ale czy t¹ mapê mo¿na zrobiæ jeszcze ³¹dniej?
#spróbujmy zrobiæ to samo ale wykorzystuj¹c inny obiekt
#(spatial polygons) do dok³adnego przyciêcia siatki
#bound jest w formacie sf. R potrafi u¿yæ go do przyciêcia siatki ale tylko w prostok¹t
#jesli chcemy przyci¹æ ³adnie do granic potrzeba innego formatu (kto by pomyœla³)
#kordynaty musz¹ byæ odfiltrowane bo w pliku bound s¹ b³êdy w postaci 2 krótkich
#poligonów
library(sp)
cor<-st_coordinates(krakowUTM)####potrzeba tu podaæ coœ w formacie sf/sfc/.. - krakowUTM na ten moment dzia³a
# cor_malopolskie<-st_coordinates(malopolskieUTM)
#wybieramy tylko pierwszy poligon bo reszta to œmieci
cor_f<-cor[cor[,3]==1,]
p = Polygon(cbind(cor_f[,1],cor_f[,2]))
ps = Polygons(list(p),1)
sps = SpatialPolygons(list(ps))
plot(gridpoints,col="Red")
plot(sps, add=TRUE)
plot(sps)

# cor_malopolskie_f<-cor_malopolskie[cor_malopolskie[,3]==1,]
# p_malopolskie = Polygon(cbind(cor_malopolskie_f[,1],cor_malopolskie_f[,2]))
# ps_malopolskie = Polygons(list(p_malopolskie),1)
# sps_malopolskie = SpatialPolygons(list(ps_malopolskie))
# plot(gp_malopolskie,col="Red")
# plot(sps_malopolskie, add=TRUE)
# plot(sps_malopolskie)

#teraz jeszcze raz przycinamy i przekszta³camy tak jak poprzednio
#ale tym razem plikiem sps
#(dla pewnoœci mo¿na by³o dodaæ jeszcze uk³ad wspó³rzêdnych)
#cropped_gridpoints <- crop(gridpoints,sps)
cropped_gridpoints <- intersect(gridpoints,sps)
plot(cropped_gridpoints,col="Red")
plot(Window(dataP_malopolskie_v),add=TRUE)

# cgp_malopolskie <- intersect(gp_malopolskie,sps_malopolskie)
# plot(cgp_malopolskie,col="Red")
# plot(Window(dataP_malopolskie_v),add=TRUE)#################################

# konwersja do SpatialPixels
spgrid <- SpatialPixels(cropped_gridpoints)
coordnames(spgrid) <- c("x", "y")
plot(spgrid)
plot(Window(dataP_ppp_v),add=TRUE)


#Narysujmy to jeszcze raz
elev_auto <- autoKrige(marks ~ 1, input_data = dataP_spdf,new_data=spgrid,model = "Mat")
plot(elev_auto$krige_output[1])
points(dataP_ppp_v,pch="*",col="White")


#zobaczmy b³¹d dopasowania
plot(elev_auto$krige_output[3])
points(dataP_ppp_v,pch="*",col="White")


#czêsto chcemy wyrosowaæ zmienne ci¹g³e jako faktory np. male, œrednie, du¿e itp.
#elev_auto$krige_output$var1.pred to s¹ wartoœci ska³dowej z
elev_auto$krige_output[1]
#dla prostoty wprawdzamy zmienn¹ pomocnicz¹ zamiast pêtli stosujemy ifelse
#produkuj¹c 3 stany (musza byc conajmnie 3)
a<-elev_auto$krige_output$var1.pred
b<-rep("NA",length(a))
b<-ifelse(a<=0.3,1,b)
b<-ifelse(a>0.3 & a<=0.4,2,b)
b<-ifelse(a>0.4,3,b)
elev_auto$krige_output$var1.factor<-as.factor(b)
plot(elev_auto$krige_output[4])