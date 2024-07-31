#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int liczba_argumentow, char *argumenty[]) {

    if (liczba_argumentow != 2) {
        printf("źle wywołany program\nWywołujemy go: %s <n>\n", argumenty[0]);
        return 1;
    }

    printf("%s\n", argumenty[1]);

    int N = atoi(argumenty[1]);

    printf("N = %d\n", N);

    //int tab[N]; tak nie robimy
    int *tab = malloc(N * sizeof(int));

    if (tab == NULL) {
        printf("Nie udało się przydzielić pamięci :(\n");
        return 2;
    }
    int *wsk = tab;
    int *koniec = tab + N;
    printf("tab = %ld, koniec = %ld\n", tab, koniec);
    while (wsk != koniec) {
        printf("wsk = %ld\n", wsk);
        *wsk = rand() % 100;
        wsk++;
    }

//    for (int i = 0; i < N; ++i) {
//        tab[i] = rand() % 100;
//    }
    wsk = tab;
    while (wsk != koniec) {
        printf("%5d", *wsk);
        wsk++;
    }
//    for (int i = 0; i < N; ++i) {
//        printf("%5d", tab[i]);
//    }
    free(tab);


    return 0;
}