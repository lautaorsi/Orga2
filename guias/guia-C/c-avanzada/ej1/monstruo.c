#include <stdio.h>

typedef struct monstruo {
    char* nombre;
    int vida;
    double ataque;
    double defensa;
} monstruo;

monstruo monstruos[3] = {{"claudio1",20,200,200},{"claudio2",20,200,200},{"claudio3",20,200,200}};

int main(){    
    printf("%s %s %s ", monstruos[0].nombre, monstruos[1].nombre, monstruos[2].nombre);
    return 0;
}