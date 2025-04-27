#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "../test-utils.h"
#include "Memoria.h"

int main() {
	char* a = "hola";
	char* ac = strClone(a);
	assert(ac[0] == 'h');
	assert(ac[01] == 'o');
	assert(ac[02] == 'l');
	assert(ac[03] == 'a');
	assert(ac[04] == '/0');



}
