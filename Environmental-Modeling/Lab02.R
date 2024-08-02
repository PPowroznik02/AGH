library(animation)
library(plotrix)
library(doSNOW)

#stworzenie i zarejestrowanie klastra
cl<-makeCluster(7)
registerDoSNOW(cl)

#pomiar czasu wykonania zadania
start<-Sys.time()

#wymiar
N=200
#krok
h<-5
p<-0
stan<-0
#liczba kó³
num<-3

#inicjalizacja macierzy dla kroku nowego i przesz³ego
Lnew<-matrix(nrow=N,ncol=N,0)
L<-matrix(nrow=N,ncol=N,0)
center_positions<-matrix(nrow=num,ncol=2,0)

#model alfa
a<-matrix(nrow=N,ncol=N,0.002)

for(f in 1:num){
  r<-20
  center<-round(runif(2)*N)
  for(x1 in (center[1]-r):(center[1]+r))
  {
    for(y1 in (center[2]-r):(center[2]+r))
    {
      p<-p+1
      if(x1>=0 && x1<=N && y1>=0 && y1<=N){
        if(((x1 - center[1]) * (x1 - center[1]) + (y1 - center[2]) * (y1 - center[2])) <= r * r){
          a[x1,y1]<-0.006
        }
      }
    }
  }
  center_positions[f,]<-center
}
#a[66:132,1:(N/2)]<-rep(0.006,67*(N/2))
image(t(apply( a, 2, rev)))

#max a do stabilnoœci
a_max<-max(a)

#krok czasowy
dt<-h^2/(4*a_max)

#czas symulacji
t<-0

#warunki brzegowe
L[,1]<-rep(0,N)
L[,N]<-rep(0,N)
L[1,]<-rep(0,N)
L[N,]<-rep(50,N)

#chcemy mieæ warunki brzegowe te¿ w nowym kroku
Lnew<-L

#wypisanie stanu pola w kroku 0
L

#liczba iteracji (wstêpnie DU¯O ZA MA£O)
niter<-50000

#inicjalizacja paska postêpu
prog_bar<-txtProgressBar( min=0,max=niter,style=3)

#blok do zapisu w animacji GIF o domyœlnych: interwale 1s i nazwie
animation.gif
saveGIF({
  #pasek postêpu nie umie w iterator pêtli for :(
  stepi<-(-1)
  
  #pêtla po iteracjach (k)
  for (k in 1:niter)
  {
    t<-t+dt
    #pasek postêpu i jego osobista zmienna(zmieniana wewn¹trz pêtli for)
    stepi<-stepi+1
    setTxtProgressBar( prog_bar, stepi)
    #pêtla po wierszach (i) i kolumnach (j)
    for (i in 2:(N-1))
      for (j in 2:(N-1)){
        Lnew[i,j]<-(1-(4*dt*a[i,j])/(h^2))*L[i,j] + dt*a[i,j]*
          ((L[i-1,j]+L[i+1,j]+L[i,j-1]+L[i,j+1])/(h^2))
      }
    #naiwny gradient 0 ale dzia³a :)
    Lnew[,1]<-L[,2]
    Lnew[,N]<-L[,N-1]
    
    #przejœcie o krok do przodu w iteracji
    #auxL to zachowana macierz do przetestowania czy pole jest stabilne (Wam siê przyda)
    auxL<-L
    if(k==1){
      Lold<-auxL
    }
    L<-Lnew
    if (k%%100==0)
    {
      #image po rotacji. apply zadaje funkcjê (tu rev) do kolejnych
      #kolumn (2) lub wierszy (1) dla zadanej macierzy (L)
      #rev odwraca kolejnoœæ
      Limg <- apply(L, 2, rev)
      image(t(Limg))
      
      #sprawdzenie stabilnosci pola
      if(stan==0){
        if(abs(1-(mean(Lnew)/mean(Lold))) < 0.001){
          print(paste0("Osiagnieto stabilnosc dla iteracji numer: ", k ))
          print(paste0("Odpowiada to liczbie dni: ", round((t/(3600*24)), 0) ))
          stan<-1
          text(0.2,0.9,round(t/(3600*24)), col="red")
        }
      }
      
      #dodanie w lewym górnym rogu czasu w dniach!
      if(stan!=1){
        text(0.2,0.9,round(t/(3600*24)))
      }
      else{
        stan<-2
      }
      
      for (i in seq(num)){
        draw.ellipse((center_positions[i,2]/200), 1-center_positions[i,1]/200, a = 1/(N/r), b = 1/(N/r), nv = 100, lwd = 1, border = "black")
      }
      #³adna czarna ramka
      box()
       
      Lold<-L
    }
  }
},interval=0.1) #SaveGIF

#pomiar czasu
stop<-Sys.time()
#wypisanie ró¿nicy czasu
stop-start

#zwolnienie klastra
stopCluster(cl)

#wypisanie wyniku
#L
#image standardowo
image (L)

