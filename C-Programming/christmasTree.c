#include <stdio.h>

int main()
{
    int wysokosc;
    scanf("%d", &wysokosc);
    
    int a = 1;
    
    for (int i=1; i<=wysokosc; i++){
        for (int l=0; l<wysokosc-i; l++)
            printf("%c", ' ');
        for (int k=0; k<a; k++)
            printf("%c", '*');
    printf("\n");
    a=a+2;
    }
}

