#include <stdio.h>
#include <stdint.h>

int main(){
    float x = 0.1;
    double y = 0.1;

    printf("el valor de x es %f \n",x);
    printf("el valor de y es %lf \n",y);

    int x2 = (int) x;
    int y2 = (int) y;

    printf("el valor de x es %i \n",x2);
    printf("el valor de y es %i \n",y2);

}