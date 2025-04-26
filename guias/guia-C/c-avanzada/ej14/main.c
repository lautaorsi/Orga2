#include <stdio.h>
#include <stdlib.h>
#include "list.h"

uint8_t x =  0x00000000;
uint8_t y = 0x00000001;

int main() {
 list_t* l = listNew(TypeFAT32);
 fat32_t* f1 = new_fat32();
 fat32_t* f2 = new_fat32();
 listAddFirst(l, f1);
 listAddFirst(l, f2);
 //listDelete(l);
 //rm_fat32(f1);
 //rm_fat32(f2);
 fat32_t* data = listGet(l, x);
 
 printf("%u  ", *data);
 data = listGet(l, y);
 printf("%u", *data);
 
 listSwap(l, x,y);
  
 data = listGet(l, x);
 printf("%u \n  ", *data);
 data = listGet(l, y);
 printf("%u", *data);
 
 return 0;
}