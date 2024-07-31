#include <stdio.h>

int fibonacci(int n){
    if(n <= 2)
    return 1;
    
    return fibonacci(n-2)+fibonacci(n-1);
}
    
int main()
{
    int n;
    scanf("%d", &n);

    printf("%d", fibonacci(n));
}


