library(ggplot2)
library(cluster)
#install.packages("clValid")
library(clValid)
data("diamonds")
library(dplyr)
library(tidyr)
library(stringr)
library(corrplot)


sample_index <- sample(nrow(diamonds), 5200)
train_set <- diamonds[sample_index[1:5000], ]
test_set <- diamonds[sample_index[5001:5200], ]


summary(diamonds)


dist_mat_m <- dist(train_set, method = 'manhattan')

head(dist_mat_m)

m1_e_ir<-hclust(dist_mat_m, method = 'average')


plot(m1_e_ir)
abline(h = 5000, col = 'red')



cut_m1_e_ir <- cutree(m1_e_ir, k = 4)


dunn(dist_mat_m, cut_m1_e_ir)


library(dplyr)
results_clus_ir<-mutate(train_set, m1_e_ir=cut_m1_e_ir)
table(results_clus_ir$m1_e_ir)


#wizualizacja 
plot(results_clus_ir$price, results_clus_ir$carat, col = as.factor(results_clus_ir$m1_e_ir))
plot(results_clus_ir$price, results_clus_ir$cut, col = as.factor(results_clus_ir$m1_e_ir))
plot(results_clus_ir$price, results_clus_ir$color, col = as.factor(results_clus_ir$m1_e_ir))
plot(results_clus_ir$price, results_clus_ir$clarity, col = as.factor(results_clus_ir$m1_e_ir))
plot(results_clus_ir$price, results_clus_ir$depth, col = as.factor(results_clus_ir$m1_e_ir))
plot(results_clus_ir$price, results_clus_ir$table, col = as.factor(results_clus_ir$m1_e_ir))
plot(results_clus_ir$price, results_clus_ir$x, col = as.factor(results_clus_ir$m1_e_ir))
plot(results_clus_ir$price, results_clus_ir$y, col = as.factor(results_clus_ir$m1_e_ir))
plot(results_clus_ir$price, results_clus_ir$z, col = as.factor(results_clus_ir$m1_e_ir))



























#### Cale dane ####

model_regresji_wielorakiej <- lm(price ~ carat + cut + color + depth + depth + table + x + y + z, data = train_set)
summary(model_regresji_wielorakiej)


plot(train_set$price, type = "l", col = "red")
lines(model_regresji_wielorakiej$fitted.values, type = "l", col = "blue")


pred_m <- predict(model_regresji_wielorakiej, newdata=test_set)
plot(test_set$price, type = "l", col = "red")
lines(pred_m, type = "l", col = "blue")


mse_lm <- mean((test_set$price - pred_m)^2)
rmse_lm <- sqrt(mse_lm)


