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
//    List dzieci;

};

struct Wezel *stworz_wezel(char literka, int koniec)
{
    struct Wezel *wezel = malloc(sizeof(struct Wezel));
    wezel->koniec = koniec;
    wezel->literka = literka;
    list_init(&wezel->dzieci, free);

    return wezel;
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

int main()
{
    struct Wezel *wezel = stworzWezel('a', 0);

    struct Wezel *wezel_L = stworzWezel('l', 0);
    struct Wezel *wezel_B = stworzWezel('b', 0);

    list_ins_next(&wezel->dzieci, list_tail(&wezel->dzieci), wezel_L);
    list_ins_next(&wezel->dzieci, list_tail(&wezel->dzieci), wezel_B);

    print_list(&wezel->dzieci);
}