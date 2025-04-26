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


int main(){
    persona_t *persona = crearPersona(21,"Lautaro");
    printf("%d %s", (*persona).edad, (*persona).nombre);
    return 0;
}