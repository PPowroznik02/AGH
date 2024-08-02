#parametry modelu
nz<-500
nx<-500
fpeak<-30.0
dt<-0.002
et<-0.5
ds<-1.0

#polożenie źródła
xs<-nx/2.0
zs<-25

#ile będzie kroków czasowych dla sejsmogramu
nt<-et/dt+1;
st<-seq(0,et,length.out=nt)
ss<-rep(0,nt)

#model
V<-matrix(nrow=nz,ncol=nx,2000)
for (i in 1:nz/2)
{
  for (j in 1:nx)
  {
    V[i,j]<-1000
  }
}


#macierze dla pól ciśnień w czasie t+1, t i t-1
p<-matrix(nrow=nz,ncol=nx,0)
pm<-matrix(nrow=nz,ncol=nx,0)
pp<-matrix(nrow=nz,ncol=nx,0)
print(sejs)

#trzeba znaleźć vmax do warunku stabilności
vmax<-2000

#dtr - realny krok próbkowania który jest dzielnikiem dt
dtr <- ds/(2.0*vmax)
w2<-0
while(1)
{
  w2<-w2+1
  w1<-dt/w2
  if (w1<=dtr)
  {
    dtr<-w1
    break
  }
}


#inicjalizacja paska postępu
niter=et/dtr+1
prog_bar<-txtProgressBar(min=0,max=niter,style=3)
kk<-1 # ilosc dtr na jedna dt
kkk<-0 # ilosc dt
k<-1 # ilosc dtr
while (1)
{
  k<-k+1
  kk<-kk+1
  t<-k*dtr
  
  #pasek postępu
  setTxtProgressBar(prog_bar, k)
  
  #główna pętla do modelowania
  for (i in 2:(nz-1))
  {
    for (j in 2:(nx-1))
    {
      pp[i,j] = 2.0*p[i,j]-pm[i,j] + ((dtr*dtr)/(ds*ds))*V[i,j]*V[i,j]*
        ( p[i+1,j]+p[i-1,j]+p[i,j+1]+p[i,j-1]-4.0*p[i,j]) }
  }
  
  
  #dodanie źródła Rickera :)
  pp[zs,xs]<-pp[zs,xs]+exp(-(((pi*fpeak*(t-(1.0/fpeak)))*(pi*fpeak*(t-(1.0/fpeak))))))*(1.0-2.0*((pi
                                                                                                  *fpeak*(t-(1.0/fpeak)))*(pi*fpeak*(t-(1.0/fpeak)))))
  #trasparent lewa - warunek brzegowy dla lewej krawędzi modelu
  for (i in 1:nz)
  {
    pp[i,1]= p[i,1] + p[i,2] - pm[i,2] +
      V[i,1]*(dtr/ds)*(p[i,2]-p[i,1]-(pm[i,3]-pm[i,2]))
  }
  
  #trasparent prawa
  #zadanie dla was
  for (i in 1:nz)
  {
    pp[i,nx]= p[i,nx] + p[i,nx-1] - pm[i,nx-1] +
      V[i,nx]*(dtr/ds)*(p[i,nx-1]-p[i,nx]-(pm[i,nx-2]-pm[i,nx-1]))
  }
  
  #trasparent gora
  #zadanie dla was
  for (j in 1:nx)
  {
    pp[nz,j]= p[nz,j] + p[nz-1,j] - pm[nz-1,j] +
      V[nz,j]*(dtr/ds)*(p[nz-1,j]-p[nz,j]-(pm[nz-2,j]-pm[nz-1,j]))
  }
  
  
  #trasparent dol
  #zadanie dla was
  for (j in 1:nx)
  {
    pp[1,j]= p[1,j] + p[2,j] - pm[2,j] +
      V[1,j]*(dtr/ds)*(p[2,j]-p[1,j]-(pm[3,j]-pm[2,j]))
  }
  
  
  
  #przejście o krok do przodu z macierzami
  pm<-p
  p<-pp
  
  
  #warunek do zapisania próbki sejsmogramu (taki sam będziecie musieli zrobić dla animacji!!!)
  if ( kk*dtr + dtr/10.0 >= dt )
  {
    kk<-0
    kkk<-kkk+1
    
    #dodanie próbek do seismogramu
    #to wymyślacie sami
    a<-rowSums(pp)
    ss[kkk]<- a[1]

    #przerwanie po czasie
    if (kkk*dt > et) break
  } # od if dla sejsmogramu
}#pętla while

#wyrysowanie pola po obliczeniach
print(sejs)
image(t(apply(p, 2, rev)))
text(0.2,0.9,kkk*dt)
plot(st,ss, type='l')



  
  