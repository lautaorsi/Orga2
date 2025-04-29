#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "ejs.h"

int main (void){
	uint8_t num = 5;
	str_array_t* unStrArr = strArrayNew(num);
	assert((*unStrArr).size == 0);
	assert((*unStrArr).data == NULL);
	assert((*unStrArr).capacity == 5);

	assert(strArrayGetSize(unStrArr) == 0);

	free(unStrArr);
	return 0;    
}


