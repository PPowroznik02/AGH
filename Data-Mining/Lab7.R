library(ggplot2)
library(mlbench)
library(pdp)
library(fastDummies)
library(corrplot)
library(MASS)
library(caret)
library(e1071)
library(rpart)
library(class)
library(nnet)
library(rpart.plot)

data(pima)
# Wykluczenie wierszy z brakującymi wartościami
pima <- na.omit(pima)
 
# Sprawdzenie struktury danych
str(pima)
summary(pima)
 
# Ustawienie ziarna losowości
set.seed(123)
 
# Podział danych na zbiór testowy do predykcji (3% obserwacji)
index_pred <- createDataPartition(pima$diabetes, p = 0.03, list = FALSE)
pima_pred <- pima[index_pred, ]
pima_rest <- pima[-index_pred, ]
 
# Podział danych na zbiór uczący (75% pozostałych danych) i zbiór walidacyjny (25% pozostałych danych)
index_train <- createDataPartition(pima_rest$diabetes, p = 0.75, list = FALSE)
pima_train <- pima_rest[index_train, ]
pima_val <- pima_rest[-index_train, ]
 
# Sprawdzenie wielkości podzbiorów
cat("Train set size:", nrow(pima_train), "\n")
cat("Validation set size:", nrow(pima_val), "\n")
cat("Prediction set size:", nrow(pima_pred), "\n")
 
# Model 1: Naiwny Klasyfikator Bayesa z wyliczanymi prawdopodobieństwami apriori
nb_pima1 <- naive_bayes(diabetes ~ mass + pregnant + age + glucose, data = pima_train)
summary(nb_pima1)
 
# Przewidywanie na zbiorze walidacyjnym
nb_pima1_pred <- predict(nb_pima1, pima_val[,-9], type = "class")
nb_pima1_pred_prob <- predict(nb_pima1, pima_val, type = "prob")
 
# Wyświetlenie rozkładu warunkowego
get_cond_dist(nb_pima1)
 
# Ocena modelu na zbiorze walidacyjnym
t_nb_pima1 <- table(pima_val$diabetes, nb_pima1_pred)
acc_nb_pima1 <- mean(pima_val$diabetes == nb_pima1_pred)
cat("Validation accuracy for model 1:", acc_nb_pima1, "\n")
print(t_nb_pima1)
 
# Model 2: Naiwny Klasyfikator Bayesa z ustalonymi prawdopodobieństwami apriori
nb_pima2 <- naive_bayes(diabetes ~ mass + pregnant + age + glucose, data = pima_train, prior = c(0.65, 0.35))
summary(nb_pima2)
 
# Przewidywanie na zbiorze walidacyjnym
nb_pima2_pred <- predict(nb_pima2, pima_val[,-9], type = "class")
nb_pima2_pred_prob <- predict(nb_pima2, pima_val, type = "prob")
 
# Wyświetlenie rozkładu warunkowego
get_cond_dist(nb_pima2)
 
# Ocena modelu na zbiorze walidacyjnym
t_nb_pima2 <- table(pima_val$diabetes, nb_pima2_pred)
acc_nb_pima2 <- mean(pima_val$diabetes == nb_pima2_pred)
cat("Validation accuracy for model 2:", acc_nb_pima2, "\n")
print(t_nb_pima2)
 
# Porównanie obu modeli na zbiorze testowym do predykcji
# Przewidywanie na zbiorze testowym do predykcji dla modelu 1
nb_pima1_test_pred <- predict(nb_pima1, pima_pred[,-9], type = "class")
conf_matrix_test_pima1 <- confusionMatrix(nb_pima1_test_pred, pima_pred$diabetes)
accuracy_test_pima1 <- conf_matrix_test_pima1$overall['Accuracy']
cat("Test accuracy for model 1:", accuracy_test_pima1, "\n")
 
# Przewidywanie na zbiorze testowym do predykcji dla modelu 2
nb_pima2_test_pred <- predict(nb_pima2, pima_pred[,-9], type = "class")
conf_matrix_test_pima2 <- confusionMatrix(nb_pima2_test_pred, pima_pred$diabetes)
accuracy_test_pima2 <- conf_matrix_test_pima2$overall['Accuracy']
cat("Test accuracy for model 2:", accuracy_test_pima2, "\n")
 
# Wyświetlenie macierzy pomyłek dla obu modeli na zbiorze testowym do predykcji
print(conf_matrix_test_pima1)
print(conf_matrix_test_pima2)



### Drzewo
data("pima")
 
 
pima <- na.omit(pima)
pima$diabetes <- as.numeric(pima$diabetes) - 1
 
str(pima)
 
set.seed(123)
 
index_pred <- createDataPartition(pima$diabetes, p = 0.03, list = FALSE)
pima_pred <- pima[index_pred, ]
pima_rest <- pima[-index_pred, ]
 
index_train <- createDataPartition(pima_rest$diabetes, p = 0.75, list = FALSE)
pima_train <- pima_rest[index_train, ]
pima_val <- pima_rest[-index_train, ]
 
ir_cl1 <- rpart(diabetes ~ ., data = pima_train, method = 'class')
 
 
print(ir_cl1)
summary(ir_cl1)
 
rpart.plot(ir_cl1, box.col = c("red", "green"))
 
str(pima_pred)
 
ir_cl1_pred <- predict(ir_cl1, newdata = pima_pred, type = 'class')
 
 
print(ir_cl1_pred)
confusionMatrix(ir_cl1_pred,pima_pred$diabetes)
 
plotcp(ir_cl1)
printcp(ir_cl1)
 
 
opt <- which.min(ir_cl1$cptable[,'xerror'])
cp <- ir_cl1$cptable[opt, 'CP']
pruned_ir <- prune(ir_cl1,cp)
rpart.plot(pruned_ir, box.col=c("red", "green"))
 
a <- predict(pruned_ir)
r2<-cor(pima_train$diabetes,a)^2
 
pruned_ir_pred <- predict(pruned_ir, newdata = pima_val, type = 'class')
 
 
cm <- confusionMatrix(pruned_ir_pred, as.factor(pima_val$diabetes))
print(cm)
 
 
accuracy <- cm$overall['Accuracy']
print(paste("Accuracy: ", accuracy))



### KNN ###
 
# Funkcja do standaryzacji z wykorzystaniem z-score
stand <- function(x) { (x - mean(x)) / sd(x) }
 
# standaryzacja
pima_std <- as.data.frame(lapply(pima[, c(1, 2, 3, 4)], stand))
 
# Dodanie kolumny z etykietami klas
pima_std_sp <- data.frame(pima_std, diabetes = pima$diabetes)
 
 
set.seed(123)
 
sets <- sample(1:nrow(pima), 0.75 * nrow(pima))
 
# Tworzenie zbiorów treningowego i testowego
train_p <- pima_std_sp[sets, ]
test_p <- pima_std_sp[-sets, ]
 
# Wyodrębnienie klas dla zbiorów treningowego i testowego
train_p_class <- pima$diabetes[sets]
test_p_class <- pima$diabetes[-sets]
 
# Model  k = 3
model_p3 <- knn(train = train_p[, 1:4], test = test_p[, 1:4], cl = train_p_class, k = 3)
 
levels <- union(levels(factor(test_p_class)), levels(factor(model_p3)))
model_p3 <- factor(model_p3, levels = levels)
test_p_class <- factor(test_p_class, levels = levels)
 
cm_p3 <- confusionMatrix(model_p3, test_p_class)
print(cm_p3)
 
 
# Model  k = 5
model_p5 <- knn(train = train_p[, 1:4], test = test_p[, 1:4], cl = train_p_class, k = 5)
 
levels <- union(levels(factor(test_p_class)), levels(factor(model_p5)))
model_p5 <- factor(model_p5, levels = levels)
test_p_class <- factor(test_p_class, levels = levels)
 
cm_p5 <- confusionMatrix(model_p5, test_p_class)
print(cm_p5)
 
acc_p5 <- mean(test_p_class == model_p5)
cat("Accuracy for k = 5:", acc_p5, "\n")
 
 
# Model k = 7
model_p7 <- knn(train = train_p[, 1:4], test = test_p[, 1:4], cl = train_p_class, k = 7)
levels <- union(levels(factor(test_p_class)), levels(factor(model_p7)))
model_p7 <- factor(model_p7, levels = levels)
test_p_class <- factor(test_p_class, levels = levels)
 
cm_p7 <- confusionMatrix(model_p7, test_p_class)
print(cm_p7)
 
acc_p7 <- mean(test_p_class == model_p7)
cat("Accuracy for k = 7:", acc_p7, "\n")
 
 
knn_prob <- knn(train = train_p[, 1:4], test = test_p[, 1:4], cl = train_p_class, k = 7, prob = TRUE)
knn_prob <- attr(knn_prob, "prob")
pos_class <- levels(test_p_class)[2] # Adjust this depending on your positive class
probs <- ifelse(knn_prob == pos_class, knn_prob, 1 - knn_prob)
 
# Calculate ROC and AUC
roc_obj <- roc(test_p_class == pos_class, probs)
auc_value <- auc(roc_obj)
 
# Plot ROC curve
plot(roc_obj, main = paste("ROC Curve for k = 7 (AUC =", round(auc_value, 2), ")"))