#include <stdlib.h>
#include <stdio.h>


typedef struct Node_ {
    int liczba;
    struct Node_ *nast;
} Node;


void wypisz(Node *poczatkowy)
{
    for (Node *n = poczatkowy; n != NULL; n = n->nast)
    {
        printf("Element %p ma liczbę %d\n", n, n->liczba);
    }
    printf("\n");
}

void dodaj(Node **adres_poczatkowego, int nowa_liczba)
{
    Node *nowy = malloc(sizeof(Node));
    nowy->liczba = nowa_liczba;
    nowy->nast = NULL;

    if (*adres_poczatkowego == NULL) // lista jest pusta
    {
        *adres_poczatkowego = nowy;
    }
    else // są elementy, przynajmniej 1
    {
        Node *n = *adres_poczatkowego;

        while (n->nast != NULL)
            n = n->nast;

        n->nast = nowy;
    }
}

void suma(int a, int b, int * c, int * d)
{
    *c = a + b;
    *d = a * b;
    printf("c w funkcji %d\n", *c);
    printf("d w funkcji %d\n", *d);
}


int main()
{
    int a = 5, b = 6, c = 0, d = 0;
    suma(a, b, &c, &d);
    printf("c poza funkcją %d\n", c);
    printf("d poza funkcją %d\n", d);


    Node* glowa = NULL;

    dodaj(&glowa, 3);
    wypisz(glowa);

    Node *pierwszy = malloc(sizeof(Node));
    pierwszy->liczba = 5;
    pierwszy->nast = NULL;

    glowa = pierwszy;

    Node *drugi = malloc(sizeof(Node));
    drugi->liczba = 7;
    drugi->nast = NULL;

    pierwszy->nast = drugi;

    Node *trzeci = malloc(sizeof(Node));
    trzeci->liczba = 9;
    trzeci->nast = NULL;

    drugi->nast = trzeci;

    Node *poltorej = malloc(sizeof(Node));
    poltorej->liczba = 6;
    poltorej->nast = drugi;
    pierwszy->nast = poltorej;

    wypisz(glowa);
    wypisz(drugi);

    dodaj(glowa, 17);
    wypisz(glowa);

}