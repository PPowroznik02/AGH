//
// Created by ts on 11.03.2022.
//

#include <stdio.h>

#define BYTE_TO_BINARY_PATTERN "%c%c%c%c%c%c%c%c"
#define BYTE_TO_BINARY(byte)  \
  (byte & 0x80 ? '1' : '0'), \
  (byte & 0x40 ? '1' : '0'), \
  (byte & 0x20 ? '1' : '0'), \
  (byte & 0x10 ? '1' : '0'), \
  (byte & 0x08 ? '1' : '0'), \
  (byte & 0x04 ? '1' : '0'), \
  (byte & 0x02 ? '1' : '0'), \
  (byte & 0x01 ? '1' : '0')

#define BINARY(x) printf(#x " = " BYTE_TO_BINARY_PATTERN "\n", BYTE_TO_BINARY(x));

int main() {

//    double d = 10;
//
//    int a = 5;
//    printf("a = %d, size = %ldB\n", a, sizeof(a));
//    signed char c = 7;
//    printf("c = %d, size = %ldB\n", c, sizeof(c));
//    unsigned char uc = 9;
//    printf("uc = %d, size = %ldB\n", uc, sizeof(uc));
//    printf("\n");
//    a = 254;
//    printf("a = %d, size = %ldB\n", a, sizeof(a));
//    c = 254;
//    printf("c = %d, size = %ldB\n", c, sizeof(c));
//    uc = 254;
//    printf("uc = %d, size = %ldB\n", uc, sizeof(uc));

    double d = 6.5;
    printf("d = %f, &d = %ld\n", d, &d);

    int i = d;
    printf("i = %d, &i = %ld\n", i, &i);

    int * w = &i;
    printf("w = %ld, &w = %ld, *w = %d\n", w, &w, *w);

    *w = 17;

    printf("i = %d, &i = %ld\n", i, &i);

    float * wf = &i;

    printf("wf = %ld, &wf = %ld, *wf = %f\n", wf, &wf, *wf);
}