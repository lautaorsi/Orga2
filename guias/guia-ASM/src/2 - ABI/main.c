#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "../test-utils.h"
#include "ABI.h"

int main() {
	/* Acá pueden realizar sus propias pruebas */
	assert(alternate_sum_4_using_c(8, 2, 5, 1) == 10	);

	assert(alternate_sum_4_using_c_alternative(8, 2, 5, 1) == 10);

	assert(alternate_sum_8(20,2,2,2,2,2,2,2) == 18);

	uint32_t *dest = malloc(4);
	product_2_f(dest,2,3.0);
	assert(*dest == 6);
	free(dest);

	double *des2 = malloc(8);
	product_9_f(des2, 1,1.0,5,1.0,1,3.0,1,1.0,1,1.0,1,1.0,1,1.0,1,1.0,1,2.0);
	assert(*des2 == 30.0);
	free(des2);
	return 0;
}
