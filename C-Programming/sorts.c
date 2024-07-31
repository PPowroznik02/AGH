#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <synchapi.h>

void swap(int *a, int *b) {
    int tmp;
    tmp = *a;
    *a = *b;
    *b = tmp;
}

int sl(int tab[], int ilosc) {
    int suma = 0;
    for (int i = 0; i < ilosc; ++i) {
        suma = suma + tab[i];
    }
    return suma;
}

int slbw(int tab[], int ilosc) {
    int suma = 0;
    for (int i = 1; i < ilosc; ++i) {
        suma = suma + abs(tab[i - 1] - tab[i]);
    }
    return suma;
}

void babelkowe_sort(int *tab, int liczbaliczb) {
    for (int i = liczbaliczb; i > 0; i--) {
        for (int j = 1; j < i; j++) {
            if (tab[j] < tab[j - 1]) {
                swap(&tab[j],&tab[j-1]);
            }
        }
    }
}

void wstawianie_sort(int *tab, int liczbaliczb) {
    int tmp, j;
    for (int i = 1; i < liczbaliczb; ++i) {
        tmp = tab[i];
        j = i - 1;
        while (j >= 0 && tmp < tab[j]) {
            tab[j + 1] = tab[j];
            j--;
        }
        tab[j + 1] = tmp;
    }
}

void wybor_sort(int *tab, int liczbaliczb) {
    int min;
    for (int i = 0; i < liczbaliczb - 1; ++i) {
        min = i;
        for (int j = i; j < liczbaliczb; ++j) {
            if (tab[min] > tab[j]) {
                min = j;
            }
        }
        swap(&tab[min], &tab[i]);
    }
}

void shell_sort(int *tab, int liczbaliczb) {
    int ods;
    for (ods = 1; ods < liczbaliczb; ods = 3 * ods + 1);
    ods = ods / 9;
    if (ods == 0)
        ods++;

    while (ods) {
        int tmp, j;
        for (int i = 1; i <= liczbaliczb - ods; ++i) {
            tmp = tab[i];
            j = i - ods;
            while (j >= 0 && tmp < tab[j]) {
                tab[j + ods] = tab[j];
                j = j - ods;
            }
            tab[j + ods] = tmp;
        }
        ods = ods / 3;
    }
}

void quick_sort(int *tab, int lewy, int prawy) {
    int i, j, piwot;

    i = (lewy + prawy) / 2;
    piwot = tab[i];
    tab[i] = tab[prawy];

    j = lewy;
    for (i = lewy; i < prawy; ++i) {
        if (tab[i] < piwot) {
            swap(&tab[i], &tab[j]);
            j++;
        }
    }
    tab[prawy] = tab[j];
    tab[j] = piwot;

    if (lewy < j - 1) {
        quick_sort(tab, lewy, j - 1);
    }
    if (j + 1 < prawy) {
        quick_sort(tab, j + 1, prawy);
    }
}

void kopcuj(int tab[], int liczbaliczb, int i) {
    int najwiekszy = i;
    int lewy = 2 * i + 1;
    int prawy = 2 * i + 2;

    if (lewy < liczbaliczb && tab[lewy] > tab[najwiekszy])
        najwiekszy = lewy;

    if (prawy < liczbaliczb && tab[prawy] > tab[najwiekszy])
        najwiekszy = prawy;

    if (najwiekszy != i) {
        swap(&tab[i], &tab[najwiekszy]);
        kopcuj(tab, liczbaliczb, najwiekszy);
    }
}

void kopcowe_sort(int tab[], int liczbaliczb) {
    for (int i = liczbaliczb / 2 - 1; i >= 0; i--)
        kopcuj(tab, liczbaliczb, i);

    for (int i = liczbaliczb - 1; i >= 0; i--) {
        swap(&tab[0], &tab[i]);

        kopcuj(tab, i, 0);
    }
}

int main(int argc, char *argv[]) {

    FILE *f;
    f = fopen(argv[1], "r");

///////////////////////////////////////////////////
    int ilosc;
    fscanf(f, "%d", &ilosc);

    int tab[ilosc];
    for (int i = 0; i < ilosc; i++) {
        fscanf(f, "%d", &tab[i]);
    }

    for (int j = 0; j < ilosc; ++j) {
        printf("%d ", tab[j]);
    }
    printf("\n");
////////////////////////////////////////////////////
    printf("przed sortowaniem\n");
    printf("sl: %d\n", sl(tab, ilosc));
    printf("slbw: %d\n", slbw(tab, ilosc));

    clock_t poczatek = clock();

    //babelkowe_sort(tab, ilosc);
    //wstawianie_sort(tab, ilosc);
    //wybor_sort(tab,ilosc);
    //shell_sort(tab,ilosc);
    //quick_sort(tab, 0,ilosc - 1);
    //kopcowe_sort(tab,ilosc);

    clock_t koniec = clock();
    double czas_wykonywania = (double) ((koniec - poczatek)) / CLOCKS_PER_SEC;


    for (int j = 0; j < ilosc; ++j) {
        printf("%d ", tab[j]);
    }
    printf("\n");
    printf("\npo sortowaniu\n");
    printf("sl: %d\n", sl(tab, ilosc));
    printf("slbw: %d\n", slbw(tab, ilosc));
    printf("czas: %lf\n", czas_wykonywania);

    fclose(f);
    return 0;
}

