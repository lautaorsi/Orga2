#include <stdio.h>

int i = 0;

int someFunction(){
    int i = 1;
    return i;
}

int main(){
    printf("%d %d", i, someFunction());
    return 0;
}