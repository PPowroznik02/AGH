library(liver)
library(corrplot)
library(ggplot2)
Real_estate <- read.csv("Real_estate.csv")

str(Real_estate)

summary(Real_estate)

plot(Real_estate$Y.house.price.of.unit.area)

hist(Real_estate$Y.house.price.of.unit.area)
hist(Real_estate$X1.transaction.date)

boxplot(Real_estate$Y.house.price.of.unit.area)
boxplot(Real_estate$X2.house.age~Real_estate$X4.number.of.convenience.stores)


library(corrplot )
cor_matrixp <- round(cor(Real_estate[1:8]),2)
cor_matrixs<-round(cor(Real_estate[1:8], method="spearman"),2)

corrplot(cor_matrixp)
corrplot(cor_matrixs)

barplot(Real_estate$X1.transaction.date)

Real_estate2 <- Real_estate
Real_estate2$X1.transaction.date[Real_estate2$X1.transaction.date < 2013] <- 2012
Real_estate2$X1.transaction.date[Real_estate2$X1.transaction.date >= 2013] <- 2013

hist(Real_estate2$X1.transaction.date)

ggplot(data = Real_estate) +
  geom_bar(mapping = aes(x = X1.transaction.date))


plot(Real_estate$X3.distance.to.the.nearest.MRT.station~Real_estate$Y.house.price.of.unit.area)


ggplot(data = Real_estate) +
  geom_bar(mapping = aes(x = X4.number.of.convenience.stores))


ZAD2

data("AirPassengers")
str(AirPassengers)
summary(AirPassengers)

plot(AirPassengers)

month <- rep(c(1:12), times=12)
boxplot(AirPassengers~month)

acf(AirPassengers) #autokorelacja
pacf(AirPassengers) #autokorelacja czastkowa

#LAB3
library(forecast)
ggseasonplot(AirPassengers, col=rainbow(12), year.labels=TRUE)

monthplot(AirPassengers)

#ZAD1 szereg czasowy do df, przeksztalcic miesiace na dumiess
passenger<- data.frame(year = as.integer(time(AirPassengers)), passengers = as.vector(AirPassengers))
passenger$month<-rep(1:12,times=12)

#1 sposob
library(fastDummies)
dummy_cols(passenger$month)
dummy_cols(passenger, select_columns = c("month", "passengers"))

#2 sposob
mutate(jan=ifelse(month==8,1,0),feb=ifelse(month==2,1,0),mar=ifelse(month==1,1,0),
       apr=ifelse(month==4,1,0), may=ifelse(month==5,1,0), jun=ifelse(month==6,1,0))

#3 sposob
passenger$hot<-ifelse(passenger$month==7|passenger$month==8, 1,0)


#Zad3
#wyknac analize
#przygotowac notatki w powerpoint, rMarkdown

library(palmerpenguins)
data("penguins")

plot(penguins$species)

penguins <- na.omit(penguins)

str(penguins)

plot(penguins$species)
boxplot(penguins)

cor_matrixp2 <- round(cor(penguins[3:6]),2)
corrplot(cor_matrixp2)

plot(penguins$species)
plot(penguins$sex, penguins$body_mass_g)
plot(penguins$sex, penguins$bill_length_mm)
plot(penguins$sex, penguins$bill_depth_mm)


hist(penguins$bill_depth_mm)

