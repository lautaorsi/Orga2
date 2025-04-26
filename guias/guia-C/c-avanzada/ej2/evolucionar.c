#include <stdio.h>

typedef struct monstruo {
    char* nombre;
    int vida;
    double ataque;
    double defensa;
} monstruo_t;


monstruo_t evolution(monstruo_t monstruo){
    monstruo.ataque += 10;
    monstruo.defensa += 10;
    return monstruo;
}


int main(){  
    monstruo_t monst = {"lautiman",100,20,40};
    printf("pre evolucion: %f %f \n", monst.ataque,monst.defensa);
    monst = evolution(monst);
    printf("post evolucion: %f %f \n", monst.ataque,monst.defensa);


    return 0;
}