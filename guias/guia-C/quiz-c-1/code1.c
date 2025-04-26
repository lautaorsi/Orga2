#include <stdio.h>

int main(){
    int n = 0;
    int i = 4;
    while(i){
        i >>= 1;
        n += i;
    }
    printf("%i",n);
}