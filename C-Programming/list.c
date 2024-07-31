#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <malloc.h>

typedef struct node {
    int wartość;
    int rozmiar_klastra;
    struct node *next;
} NODE;

void wypisz(NODE *poczatkowy) {
    NODE *n = poczatkowy;
    if (n == NULL) {
        printf("lista jest pusta");
    }
    while (n != NULL) {
        printf("element: %d\n", n->wartość);
        n = n->next;
    }
    printf("\n");
}

void dodaj(NODE **adres_poczatkowy, int liczba) {
    NODE *nowy = malloc(sizeof(NODE));
    nowy->wartość = liczba;
    nowy->next = NULL;
    if (*adres_poczatkowy == NULL) {
        *adres_poczatkowy = nowy;
    } else {
        NODE *n = *adres_poczatkowy;
        while (n->next != NULL) {
            n = n->next;
        }
        n->next = nowy;
    }
}

void usun_ostatni(NODE **adres_poczatkowy) {
    NODE *n = *adres_poczatkowy;
    if ((*adres_poczatkowy)->next == NULL) {
        *adres_poczatkowy = NULL;
    } else {
        while (n->next->next != NULL) {
            n = n->next;
        }
        free(n->next);
    }
}

void usun_pierwszy(NODE **adres_poczatkowy) {
    NODE *n = *adres_poczatkowy;
    NODE *nast = *adres_poczatkowy;
    if ((*adres_poczatkowy)->next == NULL) {
        *adres_poczatkowy = NULL;
    } else {
        nast = nast->next;
        *adres_poczatkowy = nast;
        free(n);
    }
}

int main(int argc, char *argv[]) {
    NODE *glowa = NULL;
    int a = 1, b = 2, c = 3, d = 4;

    dodaj(&glowa, a);
    dodaj(&glowa, b);
    dodaj(&glowa, c);
    dodaj(&glowa, d);

//usuwanie calej listy
/*
    do{
        usun_ostatni(&glowa);
    }while(glowa!=NULL);
*/
    usun_pierwszy(&glowa);
    wypisz(glowa);
}

