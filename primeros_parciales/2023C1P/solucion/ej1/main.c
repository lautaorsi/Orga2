#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "ej1.h"

int main (void){

	char* unNombre = "asd";
	templo* unTemplo = malloc(24);
	unTemplo->colum_corto = 2;
	unTemplo->nombre = unNombre;
	unTemplo->colum_largo = 5;

	templo* otroTemplo = malloc(24);
	otroTemplo->colum_corto = 2;
	otroTemplo->nombre = unNombre;
	otroTemplo->colum_largo = 3;

	templo* Templo3 = malloc(24);
	Templo3->colum_corto = 2;
	Templo3->nombre = unNombre;
	Templo3->colum_largo = 3;



	size_t unaLong = 3;
	templo* arrTemplo = malloc(72);
	arrTemplo[0] = *Templo3;
	arrTemplo[1] = *unTemplo;
	arrTemplo[2] = *otroTemplo;
	templo* copiaArr = templosClasicos(arrTemplo, unaLong);
	assert(copiaArr[0].colum_corto == arrTemplo[1].colum_corto);
	assert(copiaArr[0].colum_largo == arrTemplo[1].colum_largo);
	assert(copiaArr[0].nombre == arrTemplo[1].nombre);

	
	free(Templo3);
	free(unTemplo);
	free(otroTemplo);
	free(arrTemplo);
	free(copiaArr);

	return 0;    
}


