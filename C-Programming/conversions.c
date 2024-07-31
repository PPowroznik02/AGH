#include <stdio.h>
//itoa
int dwojkowa(int liczba){
    int dwojkowa = 0, mnoznik=1;
    while(liczba>0){
        dwojkowa = dwojkowa+((liczba%2)*mnoznik);
        liczba = liczba/2;
        mnoznik = mnoznik*10;
    }
    printf ("binarnie: ");
    return dwojkowa;
}

int piatkowa(int liczba){
    int piatkowa = 0, mnoznik=1;
    while(liczba>0){
        piatkowa = piatkowa+((liczba%5)*mnoznik);
        liczba = liczba/5;
        mnoznik = mnoznik*10;
    }
    printf ("piatkowo: ");
    return piatkowa;
}

int osemkowa(int liczba){
    int osemkowa = 0, mnoznik=1;
    while(liczba>0){
        osemkowa = osemkowa+((liczba%8)*mnoznik);
        liczba = liczba/8;
        mnoznik = mnoznik*10;
    }
    printf ("osemkowo: ");
    return osemkowa;
}


int main()
{
    int x;
    scanf("%d", &x);
    
    printf("%d\n", dwojkowa(x));
    printf("%d\n", piatkowa(x));
    printf("%d\n", osemkowa(x));
    //printf("%c", szesnastkowa(x));
}


