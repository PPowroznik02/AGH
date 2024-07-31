#include <stdio.h>
#include <stdlib.h>

int main(int liczba_parametrow, char *parametry[])
{
    int rozmiar_y, rozmiar_x;

    if (liczba_parametrow != 3){
        return 1;
    }
    
    rozmiar_y = atoi(parametry[1]);
    rozmiar_x = atoi(parametry[2]);


    int tab[rozmiar_y][rozmiar_x];
    int wpisywana = 1;
    int n, length_wek_y, length_wek_x,ilosc_wek;


    int *wsk = (&tab[0][0])-1;

    length_wek_x=rozmiar_x;
    length_wek_y=rozmiar_y;

////////////////////////////////////////////////////////////////////////

    if(rozmiar_y == rozmiar_x) ilosc_wek=2*rozmiar_x;
    else if (rozmiar_y > rozmiar_x) ilosc_wek=2*rozmiar_x+1;
    else if (rozmiar_y < rozmiar_x) ilosc_wek = 2*(rozmiar_y-1)+2;

    printf("liczba wektorow: %d\n", ilosc_wek);

    length_wek_y = length_wek_y-1;

////////////////////////////////////////////////////////////////////////

    for(int wek=1; wek<=ilosc_wek; wek++){

        n=0;

        if(wek % 4 == 1){
            while(n<length_wek_x){
                wsk=wsk+1;
                *wsk=wpisywana;
                wpisywana++;
                n++;
            }
            length_wek_x--;
        }
        else if(wek % 4 == 2){
            while(n<length_wek_y){
                wsk=wsk+rozmiar_x;
                *wsk=wpisywana;
                wpisywana++;
                n++;
            }
            length_wek_y--;
        }
        else if(wek % 4 == 3){
            while(n<length_wek_x){
                wsk=wsk-1;
                *wsk=wpisywana;
                wpisywana++;
                n++;
            }
            length_wek_x--;
        }
        else if(wek % 4 == 0){
            while(n<length_wek_y){
                wsk=wsk-rozmiar_x;
                *wsk=wpisywana;
                wpisywana++;
                n++;
            }
            length_wek_y--;
        }

    }

////////////////////////////////////////////////////////////////////////

    for(int i=0; i<rozmiar_y; i++){
        for(int j=0; j<rozmiar_x; j++) {
            printf("%3d ", tab[i][j]);
        }
        printf ("\n");
    }
}







