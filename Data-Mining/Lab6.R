data("diamonds")
set.seed(123)
krysztaly<-diamonds[1:27000,]
str(krysztaly)
 
 
sets <- sample(1:nrow(krysztaly), 0.97 * nrow(krysztaly))
train_krysztaly<-krysztaly[sets,]
test_krysztaly<-krysztaly[-sets,]
 
#plot(train_krysztaly)

#### Regresja Wieloraka #### 
model_bez_interakcji1 <- lm(price ~ ., data = train_krysztaly)#0.89
model_bez_interakcji2 <- lm(price ~ carat+cut+color, data = train_krysztaly)#0,79
model_bez_interakcji3 <- lm(price ~ carat+cut+color+clarity, data = train_krysztaly) #0,89
model_bez_interakcji4 <- lm(price ~ carat+cut, data = train_krysztaly) #0,76
model_bez_interakcji5 <- lm(price ~ carat+cut+x+y+z, data = train_krysztaly) #0,76
 
#summary
summary(model_bez_interakcji1)
summary(model_bez_interakcji2)
summary(model_bez_interakcji3)
summary(model_bez_interakcji4)
summary(model_bez_interakcji5)
 
train_krysztaly_cut<-train_krysztaly[1:201,]
model_3_cut<-model_bez_interakcji3$fitted.values[1:201]
 
plot(train_krysztaly_cut$price, type="l", col="red")
lines(model_3_cut, type="l", col="blue")
 

#### KNN model ####
train_krysztaly_scaled <- as.data.frame(scale(train_krysztaly))
test_krysztaly_scaled <- as.data.frame(scale(test_krysztaly))
nn_bos1 <- neuralnet(price ~ carat + x + y + z,
                     data = train_krysztaly, 
                     hidden = c(5,3),
                     linear.output = TRUE)
 
# Prognozowanie na danych testowych
pr_nn_bos1 <- compute(nn_bos1, test_krysztaly[,1:10])
pr <- unlist(pr_nn_bos1$net.result)
 
# Obliczanie współczynnika determinacji (R^2) na danych testowych
R2 <- cor(test_krysztaly$price, pr)^2
print(R2)


#### Random Forest ####
 
rf_bos1 <- randomForest(price~., data=train_krysztaly, ntree=10, importance=TRUE,nodesize= 25)
# wykres bledu oob do innych drzew
plot(rf_bos1)
 
#wyświetlenie informacji o drzewie
print(rf_bos1)
 
#numer drzewa o najniższym błędzie średniokwadratowym
which.min(rf_bos1$mse)
## [1] 10
 
#uzyskanie informacji o wybranym drzewie
tree10<-getTree(rf_bos1, 10, labelVar=TRUE)
 
#przewidywanie na zbiór testowy na podstawie uśrednionego drzewa
rf_bos1_mod<-rf_bos1$predicted
 
#oceniamy jak każdy inny model regresyjny
 
# Obliczenie współczynnika determinacji na zbiorze testowym
r_squared <- cor(predictions, actual_values)^2
print(paste("Współczynnik determinacji (R-squared):", r_squared))
 
 
varImpPlot(rf_bos1, main = "Wykres ważności zmiennych")
 
plot(actual_values, predictions, main = "Wykres przewidywanych vs. rzeczywistych wartości", xlab = "Rzeczywiste wartości", ylab = "Przewidywane wartości")
 
plot(actual_values, predictions, 
     main = "Wykres przewidywanych vs. rzeczywistych wartości", 
     xlab = "Rzeczywiste wartości", 
     ylab = "Przewidywane wartości",
     col = c("blue", "red"),  # Kolory punktów
     pch = 16)  # Kształt punktów
legend("topleft", legend=c("Rzeczywiste wartości", "Przewidywane wartości"), 
       col=c("blue", "red"), pch=16)


#### drzewo decyzyjne typu C&RT ####
 
#model
set.seed(10)
rt_krysztaly <- rpart(price~., data = train_krysztaly,
                control = rpart.control(cp = 0.00001))
printcp(rt_krysztaly)
 
#wykres drzewa przed przycinaniem
plot(rt_krysztaly)
text(rt_krysztaly, cex = 0.9, xpd = TRUE)
 
#przycinanie drzewa i jego wizualizacja
plotcp(rt_krysztaly)
 
#cp: 0.002
rt_krysztaly_pr<-prune(rt_krysztaly, cp = 0.002)
plot(rt_krysztaly_pr)
text(rt_krysztaly_pr, cex = 0.9, xpd = TRUE)
 
rpart.plot(rt_krysztaly_pr)
 
#wygenerowany model i reszty
rt_krysztaly_pr_mod <-predict(rt_krysztaly_pr)
R2_1<-cor(train_krysztaly$price, rt_krysztaly_pr_mod)^2
rt_krysztaly_pr_res_1<-train_krysztaly$price-rt_krysztaly_pr_mod
R2_1
#przewidywanie na zbiór testowy
rt_krysztaly_pr_pred<- predict(rt_krysztaly_pr, test_krysztaly[,-7])
 
mape_2 <- MAPE(rt_krysztaly_pr_pred, test_krysztaly$price)
mape_2