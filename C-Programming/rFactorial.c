#include <stdio.h>

int main()
{
    int silnia(int n){
        if(n == 1)
        return 1;
        
        return n*silnia(n-1);
    }
    
    int a;
    scanf("%d", &a);
    
    printf("%d", silnia(a));
}

