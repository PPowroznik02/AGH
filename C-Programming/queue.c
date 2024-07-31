#include <stdio.h>
#include <stdlib.h>

typedef struct a{

int liczba;
struct a *next;

} strk;

int odczyt(struct a *); //odczyt 1 elementu
struct a* usun(struct a *); // usuwanie 1 elementu
void wstaw(struct a *, int); // wstawienie na koniec
int main()
{
    struct a a;
    strk* wsk=&a;
    wsk->next=NULL;
    wsk->liczba=1;
    wstaw(wsk, 2);
    wstaw(wsk, 3);
    printf("%d\n\n", odczyt(wsk));
    wsk = a.next;
    return 0;
}
int odczyt(strk* a){

    for(struct a *n = a; n != NULL; n = n->next){
        printf("Element %p ma liczbe %d\n", n, n->liczba);
    }
    printf("\n");
}
strk * usun(strk *a){
    strk *w =a;// zapamietujemy to co usuwamy
    a=a->next; // przeskakujemy usuwany element
    free(w); // zwalniamy pamiec przeskoczonego elementu
    return a; // tak spreparowana liste wzracamy
}

void wstaw(strk *a, int dodawana){

    while(a->next != NULL)
    {
   
        a=a->next;

    }

    strk *nowy = (strk*) malloc(sizeof(strk));//nowy element w pamiec

    nowy->liczba=dodawana;// wartosc przpisana
    nowy->next=NULL;// wskaznik przypisany do NULL
    a->next=nowy; // podlaczamy nowa do starej
}
