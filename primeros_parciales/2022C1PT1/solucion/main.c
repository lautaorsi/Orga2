#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "ejs.h"

int main (void){
	uint8_t num = 5;
	str_array_t* unStrArr = strArrayNew(num);
	(*unStrArr).size = 0;
	(*unStrArr).capacity = 5;

	char* unStr = "hola";
	char* unStr2 = "chau";
	strArrayAddLast(unStrArr, unStr);
	strArrayAddLast(unStrArr, unStr2);

	char* str = (*unStrArr).data[0];
	char* str2 = (*unStrArr).data[1];

	strArraySwap(unStrArr, 0, 1);

	assert(strcmp((*unStrArr).data[0],"chau") == 0);

	strArrayDelete(unStrArr);
	return 0;    
}


