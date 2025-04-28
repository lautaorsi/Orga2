#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "ej1.h"

int main (void){

	templo* unTemplo = malloc(24);
	unTemplo->colum_corto = 2;
	unTemplo->colum_largo = 5;
	size_t unaLong = 1;
	templo* arrTemplo = {unTemplo};
	templo* arrClasicos = templosClasicos(unTemplo, unaLong);
	assert(& *arrClasicos == & *arrTemplo);
	free(unTemplo);

	return 0;    
}


