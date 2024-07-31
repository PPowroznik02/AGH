#include <stdio.h>
#include <stdlib.h> 
#include <time.h>

void wypelnij( int tab[], int rozmiar){
        for (int i=0; i<rozmiar; i++){
            tab[i] = rand() %100 + 1;
        }
    }
    
void wypisz( int tab[], int rozmiar){
        for (int j=0; j<rozmiar; j++){
            printf("%d", tab[j]);
            printf("%c", ' ');
        }
    }
    
int main()
{
    int ziarno, rozmiar;
    scanf ("%d", &ziarno);
    scanf ("%d", &rozmiar);
    
    int tab[rozmiar];
    
    srand (ziarno);
    
    wypelnij(tab, rozmiar);
    
    wypisz(tab, rozmiar);
}

