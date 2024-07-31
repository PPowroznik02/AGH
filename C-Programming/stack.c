#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <windows.h>
 
int max_size;
 
typedef struct StackElement {
    int data;
    struct stackElement * next;
} StackElement_type;
 
 
int push(StackElement_type **top, int number);
int pop(StackElement_type **top);
void empty(StackElement_type *top);
void show(StackElement_type *top);
int size(StackElement_type *top);
 
int main() {
 
 
    printf("Wprowadz maksymalny rozmiar stosu: ");
    scanf("%i", &max_size); Sleep(1000);
 
    if(max_size<=0) return 1;
    else {
        StackElement_type *top;
        top=NULL;
 
        int option=-1;
        int number=-1;
        while(option!=0) {
 
            system("cls");
            printf("Aktualny stan stosu: ");
            show(top);
 
            printf("\n\nDrogi uzytkowniku! Co chcesz zrobic?\n");
            printf("1. Polozyc element na stosie.\n");
            printf("2. Zdjac element ze stosu.\n");
            printf("3. Sprawdzic czy stos jest pusty.\n");
            printf("4. Policzyc elementy na stosie.\n");
            printf("0. Zakonczyc program.\n");
 
            scanf("%i", &option);
 
            switch (option) {
            case 0:
                return 0;
                break;
 
            case 1:
                printf("Wpisz liczbe jaka chcesz dodac: ");
                scanf("%i", &number);
                push(&top, number);
                break;
            case 2:
                pop(&top);
                break;
            case 3:
                empty(top); Sleep(2000);
                break;
            case 4:
                printf("Liczba elementow na stosie: %i", size(top)); Sleep(2000);
                break;
            default:
                printf("Podaj wlasciwa opcje."); Sleep(2000);
                break;
            }
        }
    }
 
 
 
    return 0;
}
 
int push(StackElement_type **top, int number) {
 
    if(size(*top)==max_size) {
        printf("\nSTACK OVERFLOW!! Nie mozna dodac elementu do stosu."); Sleep(2000);
        return 1;
    }
 
    if(*top==NULL) {
        *top=(StackElement_type *) malloc (sizeof(StackElement_type));
        (*top)->data=number;
        (*top)->next=NULL;
    }else {
        StackElement_type *newElement;
        newElement=(StackElement_type *)malloc(sizeof(StackElement_type));
        newElement->data=number;
        newElement->next=*top;
        *top=newElement;
    }
 
}
 
int pop(StackElement_type **top) {
 
    if (*top==NULL) {
      printf("\nSTACK UNDERFLOW!! Nie ma czego zdjac ze stosu."); Sleep(2000);
	}else {
	 StackElement_type * tmp=NULL;
   	 tmp=(*top)->next;
   	 free(*top);
   	 *top=tmp;
	}
 
 
}
 
 
void empty(StackElement_type *top) {
    (top==NULL) ? printf("Stack is empty :O") : printf("Stack is not empty :]");
}
 
void show(StackElement_type *top) {
 
    printf("\n");
    if(top==NULL) printf("List is empty");
    else {
        StackElement_type *current=top;
        do {
            printf("%i", current->data);
            printf("\n");
            current = current->next;
         }while (current != NULL);
 
    }
}
 
int size(StackElement_type *top) {
 
    int counter=0;
    StackElement_type *current=top;
 
    while(current!=NULL)
    {
        counter++;
        current=current->next;
    }
 
    return counter;
}
