#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "ej1.h"

int main (void){

    pago_t* unArr = malloc(20 * sizeof(pago_t));  


    unArr[0].aprobado = 1; unArr[0].cliente = 0; unArr[0].comercio = "comercio0"; unArr[0].monto = 200;
    unArr[1].aprobado = 0; unArr[1].cliente = 0; unArr[1].comercio = "comercio0"; unArr[1].monto = 100;

    unArr[2].aprobado = 1; unArr[2].cliente = 1; unArr[2].comercio = "comercio1"; unArr[2].monto = 200;
    unArr[3].aprobado = 0; unArr[3].cliente = 1; unArr[3].comercio = "comercio1"; unArr[3].monto = 100;

    unArr[4].aprobado = 1; unArr[4].cliente = 2; unArr[4].comercio = "comercio2"; unArr[4].monto = 200;
    unArr[5].aprobado = 0; unArr[5].cliente = 2; unArr[5].comercio = "comercio2"; unArr[5].monto = 100;

    unArr[6].aprobado = 1; unArr[6].cliente = 3; unArr[6].comercio = "comercio3"; unArr[6].monto = 200;
    unArr[7].aprobado = 1; unArr[7].cliente = 3; unArr[7].comercio = "comercio3"; unArr[7].monto = 100;

    unArr[8].aprobado = 1; unArr[8].cliente = 4; unArr[8].comercio = "comercio4"; unArr[8].monto = 200;
    unArr[9].aprobado = 0; unArr[9].cliente = 4; unArr[9].comercio = "comercio4"; unArr[9].monto = 100;

    unArr[10].aprobado = 1; unArr[10].cliente = 5; unArr[10].comercio = "comercio5"; unArr[10].monto = 200;
    unArr[11].aprobado = 0; unArr[11].cliente = 5; unArr[11].comercio = "comercio5"; unArr[11].monto = 100;

    unArr[12].aprobado = 1; unArr[12].cliente = 6; unArr[12].comercio = "comercio6"; unArr[12].monto = 200;
    unArr[13].aprobado = 1; unArr[13].cliente = 6; unArr[13].comercio = "comercio6"; unArr[13].monto = 100;

    unArr[14].aprobado = 1; unArr[14].cliente = 7; unArr[14].comercio = "comercio7"; unArr[14].monto = 200;
    unArr[15].aprobado = 0; unArr[15].cliente = 7; unArr[15].comercio = "comercio7"; unArr[15].monto = 100;

    unArr[16].aprobado = 1; unArr[16].cliente = 8; unArr[16].comercio = "comercio8"; unArr[16].monto = 200;
    unArr[17].aprobado = 0; unArr[17].cliente = 8; unArr[17].comercio = "comercio8"; unArr[17].monto = 100;

    unArr[18].aprobado = 1; unArr[18].cliente = 9; unArr[18].comercio = "comercio9"; unArr[18].monto = 200;
    unArr[19].aprobado = 0; unArr[19].cliente = 9; unArr[19].comercio = "comercio9"; unArr[19].monto = 100;

    

    char** unStr = malloc(32);
    char* n1 = "comercio1";
    char* n2 = "comercio3";
    char* n3 = "comercio6";
    char* n4 = "comercio8";
    unStr[0] = n1;
    unStr[1] = n2;
    unStr[2] = n3;
    unStr[3] = n4;
    char* unNombre = "pedro";

    assert(6 == contar_pagos_blacklisteados(20, unArr, unStr, 4));

    pago_t** res = blacklistComercios_asm(20, unArr, unStr, 2);

    free(unStr);
    free(res);
    free(unArr);
   
 
}


