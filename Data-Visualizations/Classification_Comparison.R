library(ggplot2)
library(ggpubr)


data1 = read.csv("data1.csv")
ionosphere = read.csv("ionosphere.csv")
diabetes = read.csv("diabete.csv")


plot1 = ggplot(data1, aes(fill=Podzial, y=Czas, x=Algorytm)) + 
  geom_bar(position="dodge", stat="identity") + coord_flip()

plot2 = ggplot(data1, aes(fill=Podzial, y=Kappa, x=Algorytm)) + 
  geom_bar(position="dodge", stat="identity") + coord_flip()

plot3 = ggplot(data1, aes(fill=Podzial, y=Precyzja, x=Algorytm)) + 
  geom_bar(position="dodge", stat="identity") + coord_flip()

plot4 = ggplot(data1, aes(fill=Podzial, y=Skutecznosc, x=Algorytm)) + 
  geom_bar(position="dodge", stat="identity") + coord_flip()

figure <- ggarrange(plot1, plot2, plot3, plot4)

annotate_figure(figure, top = text_grob("Iris", color = "black", face = "bold", size = 14))

##diabetes
plot1 = ggplot(diabetes, aes(fill=Podzial, y=Czas, x=Algorytm)) + 
  geom_bar(position="dodge", stat="identity") + coord_flip()

plot2 = ggplot(diabetes, aes(fill=Podzial, y=Kappa, x=Algorytm)) + 
  geom_bar(position="dodge", stat="identity") + coord_flip()

plot3 = ggplot(diabetes, aes(fill=Podzial, y=Precyzja, x=Algorytm)) + 
  geom_bar(position="dodge", stat="identity") + coord_flip()

plot4 = ggplot(diabetes, aes(fill=Podzial, y=Skutecznosc, x=Algorytm)) + 
  geom_bar(position="dodge", stat="identity") + coord_flip()

figure <- ggarrange(plot1, plot2, plot3, plot4)

annotate_figure(figure, top = text_grob("Diabetes", color = "black", face = "bold", size = 14))


#ionosphere
plot1 = ggplot(ionosphere, aes(fill=Podzial, y=Czas, x=Algorytm)) + 
  geom_bar(position="dodge", stat="identity") + coord_flip()

plot2 = ggplot(ionosphere, aes(fill=Podzial, y=Kappa, x=Algorytm)) + 
  geom_bar(position="dodge", stat="identity") + coord_flip()

plot3 = ggplot(ionosphere, aes(fill=Podzial, y=Precyzja, x=Algorytm)) + 
  geom_bar(position="dodge", stat="identity") + coord_flip()

plot4 = ggplot(ionosphere, aes(fill=Podzial, y=Skutecznosc, x=Algorytm)) + 
  geom_bar(position="dodge", stat="identity") + coord_flip()

figure <- ggarrange(plot1, plot2, plot3, plot4)

annotate_figure(figure, top = text_grob("Ionosphere", color = "black", face = "bold", size = 14))

