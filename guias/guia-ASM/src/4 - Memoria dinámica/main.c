#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "../test-utils.h"
#include "Memoria.h"

int main() {
	char* a = "";
	char* ac = strClone(a);
	assert(ac[0] == '\0');

}
