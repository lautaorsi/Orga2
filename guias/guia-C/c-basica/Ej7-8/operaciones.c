#include <stdio.h>

int main(){
    int a = 5; int b = 3; int c = 2 ; int d = 1;
    printf("a + b * c / d = %f \n", (a + b * c / d));
    printf("a %% b = %f \n", (a % b));
    printf("a == b = %c \n a != b = %c", (a != b));
    printf("a & b = %c \n a | b = %c", (a & b), (a | b));
    printf("~a = %i \n", ~a);
    printf("a && b = %c \n a || b = %c", (a && b ), (a || b));
    printf("a << 1 = %c \n", (a  << 1));
    printf("a >> 1 = %c \n", (a >> 1));
    printf("a += b = %c \n ", (a += b));
    printf("a -= b = %c \n ", (a -= b));
    printf("a *= b = %c \n ", (a *= b));
    printf("a /= b = %c \n ", (a /= b));
    printf("a %%= b = %c \n ", (a %= b));
}