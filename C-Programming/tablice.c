#include <stdio.h>

int main() {

//    int a = -5;
//    printf("a = %d, size = %ldB\n", a, sizeof(a));
//    unsigned int b = -5;
//    printf("b = %u, size = %ldB \n", b, sizeof(b));
//
//    int c = 4294967291;
//    printf("c = %d, size = %ldB \n", c, sizeof(c));
//
//
//    char d = 200;
//    printf("d = %d, size = %ldB \n", d, sizeof(d));
//    unsigned char e = 200;
//    printf("e = %u, size = %ldB \n", e, sizeof(e));


    int A[5];

    int * w = A;



    printf("A = 0x%lx, Rozmiar A = %ldB \n", A, sizeof(A));

    for (int i = 0; i < 5; ++i) {
        A[i] = i+1;
    }
    for (int i = 0; i < 5; ++i) {
        printf("%d: %d [0x%lx]\n", i, A[i], (long)&A[i]);
    }
    printf("\n");
    printf("w = 0x%lx, Rozmiar w = %ldB \n", w, sizeof(w));
    printf("*w = %d, &w = 0x%lx\n", *w, &w);

    for (int i = 0; i < 5; ++i) {
        printf("*(w+%d) = %d, w[%d] = %d\n", i, *(w+i), i, w[i]);
    }
    printf("A[5] = %d\n", A[5]);
    A[5] = 17;
    printf("A[5] = %d\n", A[5]);

    int B[4][4];


    return 0;
}
