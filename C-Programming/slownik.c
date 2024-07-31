#include <stdlib.h>
#include <stdio.h>
#include <memory.h>
#include "list.h"

struct Node {
    struct Wezel * wezel;

    struct Node * nast;
};

struct Wezel {
    char literka;
    int koniec;

    // lista
    struct Node * glowa;

};

struct Wezel *stworz_wezel(char literka, int koniec)
{
    struct Wezel *wezel = malloc(sizeof(struct Wezel));
    wezel->koniec = koniec;
    wezel->literka = literka;
    wezel->glowa = NULL;

    return wezel;
}

struct Node * stworz_element_listy(struct Wezel * wezel) {
    struct Node * element_listy = malloc(sizeof (struct Node));
    element_listy->nast = NULL;
    element_listy->wezel = wezel;

    return element_listy;
}

void dodaj_element_listy_do_wezla(struct Node * element_list_do_dodania, struct Wezel * wezel) {

    if (wezel->glowa == NULL) {
        wezel->glowa = element_list_do_dodania;
    }
    else {
        struct Node * el = wezel->glowa;
        while (el->nast != NULL) {
            el = el->nast;
        }
        el->nast = element_list_do_dodania;
    }
}

void print_list(const List *list)
{
    ListElmt *element;

    struct Wezel *data;
    int i = 0;

    fprintf(stdout, "Rozmiar listy to %d\n", list_size(list));

    element = list_head(list);

    while (1)
    {
        data = list_data(element);
        fprintf(stdout, "list[%03d] literka %c\n", i, data->literka);

        i++;

        if (list_is_tail(element))
            break;
        else
            element = list_next(element);
    }
}

typedef unsigned char bajt;

int main()
{
    bajt c = 0x56;
    printf("%d\n", c);
    printf("0x%x\n", c);

//    printf("%d\n", c & 1);

    // 01010110
    // 10000000
    // 00000000

    // 01010110 >> 7 = 0000000 0 & 1 = 0
    // 01010110 >> 6 = 000000 01 & 1 = 1
    // 01010110 >> 5 = 00000 010 & 1 = 0
    // 01010110 >> 4 = 0000 0101 & 1 = 1


//    printf("%d", c >> 7 & 1) ;
//    printf("%d", c >> 6 & 1) ;
//    printf("%d", c >> 5 & 1) ;
//    printf("%d", c >> 4 & 1) ;

    for (int i = 7; i >= 0; i--)
    {
        bajt pixel = c >> i & 1;
        printf("%d", pixel) ;
    }

    return 1;
    struct Wezel *wezel_A = stworz_wezel('a', 0);

    struct Wezel *wezel_L = stworz_wezel('l', 0);
    struct Wezel *wezel_P = stworz_wezel('p', 0);



    struct Node * pierwszy_element_listy = stworz_element_listy(wezel_L);

//    wezel_A->glowa = pierwszy_element_listy;

    dodaj_element_listy_do_wezla(pierwszy_element_listy, wezel_A);

    struct Node * drugi_element_listy = stworz_element_listy(wezel_P);
    dodaj_element_listy_do_wezla(drugi_element_listy, wezel_A);

//    pierwszy_element_listy->nast = drugi_element_listy;

//    print_list(&wezel_A);
}