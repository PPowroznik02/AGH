#include <stdio.h>

int potega(int a, int b){
    if(b == 0)
    return 1;
    
    return a*potega(a,b-1);
}
    
int main()
{
    int a,b;
    scanf("%d", &a);
    scanf("%d", &b);
    
    printf("%d", potega(a,b));
}
