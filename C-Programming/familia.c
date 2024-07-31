#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

typedef struct data {
    int rok;
    int miesiac;
    int dzien;
} data;

typedef struct czlowiek_ {
    char imie[200];
    char nazwisko[200];

    data data_urodzenia;
    int suma_dni_u;

    data data_smierci;
    int suma_dni_s;

    int pokolenie;
    bool partner;
    struct czlowiek *nastepny;
} czlowiek;

void dodaj(czlowiek **adres_poczatkowy, char imie[200], char nazwisko[200], int rok_u, int miesiac_u,
           int dzien_u, int rok_s, int miesiac_s, int dzien_s, int pokolenie, bool partner) {
    czlowiek *nowy = malloc(sizeof(czlowiek));
    nowy->imie[0] = '\0';
    nowy->nazwisko[0] = '\0';
    strcat(nowy->imie, imie);
    strcat(nowy->nazwisko, nazwisko);
    nowy->data_urodzenia.rok = rok_u;
    nowy->data_urodzenia.miesiac = miesiac_u;
    nowy->data_urodzenia.dzien = dzien_u;
    nowy->data_smierci.rok = rok_s;
    nowy->data_smierci.miesiac = miesiac_s;
    nowy->data_smierci.dzien = dzien_s;
    nowy->pokolenie = pokolenie;
    nowy->partner = partner;
    nowy->nastepny = NULL;
    if (*adres_poczatkowy == NULL) {
        *adres_poczatkowy = nowy;
    } else {
        czlowiek *n = *adres_poczatkowy;
        while (n->nastepny != NULL) {
            n = n->nastepny;
        }
        n->nastepny = nowy;
    }
}

void usun_ostatni(czlowiek **adres_poczatkowy) {
    czlowiek *n = *adres_poczatkowy;
    czlowiek *tmp = *adres_poczatkowy;
    tmp = n->nastepny;
    if ((*adres_poczatkowy)->nastepny == NULL) {
        *adres_poczatkowy = NULL;
    } else {
        while (tmp->nastepny != NULL) {
            n = n->nastepny;
            tmp = tmp->nastepny;
        }
        free(n->nastepny);
    }
}

void wypisz_familie(czlowiek *poczatkowy) {
    czlowiek *n = poczatkowy;
    czlowiek *p;
    p = n->nastepny;
    if (n == NULL) {
        printf("familia jest pusta");
    }
    while (n != NULL) {
        int tmp = n->pokolenie;
        if (n->partner != 1) {
            while (tmp >= 1) {
                printf("\t");
                tmp -= 1;
            }
        }
        printf("%s %s ", n->imie, n->nazwisko);
        printf("(%d-%d-%d", n->data_urodzenia.rok, n->data_urodzenia.miesiac, n->data_urodzenia.dzien);
        if (n->data_smierci.dzien != 0) {
            printf(" - %d-%d-%d", n->data_smierci.rok, n->data_smierci.miesiac, n->data_smierci.dzien);
        }
        printf(")");
        if (p->partner == 1) {
            printf(" + ");
        } else {
            printf("\n");
        }
        n = n->nastepny;
        if (p->nastepny != NULL) {
            p = p->nastepny;
        }
    }
    printf("\n");
}

void wypisz_sortowane(czlowiek *poczatkowy) {
    czlowiek *n = poczatkowy;
    if (n == NULL) {
        printf("lista jest pusta");
    }
    while (n != NULL) {
        printf("%s %s ", n->imie, n->nazwisko);
        printf("(%d-%d-%d", n->data_urodzenia.rok, n->data_urodzenia.miesiac, n->data_urodzenia.dzien);
        if (n->data_smierci.dzien != 0) {
            printf(" - %d-%d-%d", n->data_smierci.rok, n->data_smierci.miesiac, n->data_smierci.dzien);
        }
        printf(")");
        printf("\n");
        n = n->nastepny;
    }
    printf("\n");
}

void sortuj_urodzenie(czlowiek *poczatkowy){
    czlowiek *n = poczatkowy;
    int ilosc = 0;
    while(n != NULL){
        ilosc++;
        n = n->nastepny;
    }
    for (int i = 0; i < ilosc; ++i) {
        for (int j = 1; j < i; ++j) {

        }
    }
}

void wczytaj_czlowieka(FILE *f, int pokolenie, czlowiek **glowa, bool partner) {
    char imie[200] = {0};
    char nazwisko[200] = {0};
    char c[2] = {0};
    c[0] = fgetc(f);

    if (c != EOF) {


        //wczytnie imienia
        while (strcmp(c, ",")) {
            if (strcmp(c, " ")) {
                strcat(imie, c);
            }
            c[0] = fgetc(f);
        }
        //printf("%s\n", imie);
        c[0] = fgetc(f);

        //wczytanie nazwiska
        while (strcmp(c, ",")) {
            if (strcmp(c, " ")) {
                strcat(nazwisko, c);
            }

            c[0] = fgetc(f);
        }
        //printf("%s\n", nazwisko);
        c[0] = fgetc(f);


        // wczytanie urodzenia
        char data_urodzenia[50] = {0};
        int rok_u, miesiac_u, dzien_u;
        while (strcmp(c, ",")) {
            if (strcmp(c, " ")) {
                strcat(data_urodzenia, c);
            }
            c[0] = fgetc(f);
        }
        //printf("%s\n", data_urodzenia);
        char *tmp = strtok(data_urodzenia, "-");
        rok_u = atoi(tmp);

        tmp = strtok(NULL, "-");
        miesiac_u = atoi(tmp);

        tmp = strtok(NULL, "-");
        dzien_u = atoi(tmp);

        //printf("%d %d %d\n", rok_u, miesiac_u, dzien_u);

        c[0] = fgetc(f);


        //wczytanie smierci
        char data_smierci[50] = {0};
        int rok_s, miesiac_s, dzien_s;
        while (strcmp(c, ",")) {
            if (strcmp(c, " ")) {
                strcat(data_smierci, c);
            }
            c[0] = fgetc(f);
        }
        //printf("%s\n", data_smierci);
        char *tmp_2 = strtok(data_smierci, "-");
        rok_s = atoi(tmp_2);

        tmp_2 = strtok(NULL, "-");
        miesiac_s = atoi(tmp_2);

        tmp_2 = strtok(NULL, "-");
        dzien_s = atoi(tmp_2);

        //printf("%d %d %d\n", rok_s, miesiac_s, dzien_s);

        if (dzien_u != 0) {
            dodaj(glowa, imie, nazwisko, rok_u, miesiac_u, dzien_u, rok_s, miesiac_s, dzien_s, pokolenie, partner);
        }
    }
}

int wczytaj(FILE *f, int pokolenie, czlowiek **glowa, bool partner) {
    char c[2] = {0};

    c[0] = fgetc(f);

    if (c[0] == EOF) {
        return 0;
    }

    while (strcmp(c, " ") == 0) {
        c[0] = fgetc(f);
    }
    if (strcmp(c, "]") == 0) {
        return 0;
    }
    //printf("czlowiek1\n");
    wczytaj_czlowieka(f, pokolenie, glowa, partner);
    //printf("czlowiek2\n");
    wczytaj_czlowieka(f, pokolenie, glowa, 1);

    c[0] = fgetc(f);
    while (strcmp(c, "[")) {
        c[0] = fgetc(f);
    }
    while (wczytaj(f, pokolenie + 1, glowa, partner)) {
        c[0] = fgetc(f);
    }

    return 1;
}

int main(int argc, char *argv[]) {
    FILE *f;
    f = fopen(argv[1], "r");
    czlowiek *glowa;
    glowa = NULL;
    wczytaj(f, 0, &glowa, 0);
    printf("\n");
    wypisz_familie(glowa);

    //sortuj_urodzenie(glowa);
    //wypisz_sortowane(glowa);

    fclose(f);
    return 0;
}


