#include <stdlib.h>
#include <stdio.h>


typedef struct Persona {
    int edad;
    char *nombre;
} persona_t;

persona_t *crearPersona(int edad, char nombre[]){
    persona_t *some_person = malloc(sizeof(persona_t));
    (*some_person).edad = edad;
    (*some_person).nombre = nombre;
    return some_person;
}

void eliminarPersona(persona_t *persona){
    free(persona);
}

int main(){
    persona_t *persona = crearPersona(21,"Lautaro");
    printf("%d %s", (*persona).edad, (*persona).nombre);
    eliminarPersona(persona);
    
    return 0;
}