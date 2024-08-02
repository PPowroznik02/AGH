#funkcja dla odleg³oœci
getR<-function(j,i,k)
{
  return(sqrt(((j-k)^2) + (i^2)))
}


#funkcja dla k¹ta
getAngle<-function(j,i,k)
{
  if (k == j)
  {
    return (90.0)
  }
  if (k < j)
  {
    ii = j - k
    tg = i / ii
    rad = atan(tg)
    deg = (rad/pi)*180
    return (deg)
  } 
  if (k > j)
  {
    ii = k - j
    tg = i / ii
    rad = atan(tg)
    deg = (rad/pi)*180
    return (deg)
  }
}

  #pomiar czasu
  start<-Sys.time()
  #wymiary
  N<-500
  M<-250
  #gêstoœci
  rho1<-3500
  rho2<-5500
  #sta³a grawitacji
  gamma<-6.67e-11
  #macierz gêstoœci
  rho<-matrix(nrow=M,ncol=N,rho1)
  #generacja modelu
  for (k in 1:3)
  {
    x<-round(100+runif(1)*(N-200))
    z<-round(50+runif(1)*(M-100))
    for (i in 1:M)
    {
      for (j in 1:N)
      {
        if ( sqrt((i-z)^2+(j-x)^2)< 50 )
          rho[i,j]<-rho2
      }
    }
  }
  
  image(t(apply(rho, 2, rev)),asp=0.5)
  box()
  
  #wektor na wyniki
  g<-rep(0,N)
  #to siê bêdzie d³ugo liczyæ :)
  #rho nie jest sta³e jak we wzorze wiêc wesz³o pod sumê
  for (k in 100:400)
  {
    suma<-0
    for (i in 1:M)
    {
      for (j in 1:N)
      {
        beta = (i+1-i)/(j+1-j)
        r = getR(j, i, k)
        r1 = getR(j, i+1, k)
        z = r1 / r
        logarytm = log(z)
        a = getAngle(j, i, k)
        a1 = getAngle(j, i+1, k)
        suma <- suma+ ( rho[i,j] * beta * (logarytm - (a-a1)) )
      }
    }
    g[k] = 2 * gamma * suma
  }
  
  #h<-seq(1,500,20)
  #wyœwietlenie wykresu
  plot(g[g>0])
  
  #pomiar czasu
  stop<-Sys.time()
  #wypisanie ró¿nicy czasu
  stop-start
  