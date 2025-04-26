#include <stdio.h>
#include <stdint.h>

int main(){
    int8_t i8 = 100;
    int16_t i16 = 100;
    int32_t i32 = 100;
    int64_t i64 = 100;
    uint8_t ui8 = 100;
    uint16_t ui16 = 100;
    uint32_t ui32 = 100;
    uint64_t ui64 = 100;



    printf("char(%lu): %d \n", sizeof(i8),i8);
    printf("char(%lu): %d \n", sizeof(i16),i16);
    printf("char(%lu): %d \n", sizeof(i32),i32);
    printf("char(%lu): %d \n", sizeof(i64),i64);
    printf("char(%lu): %d \n", sizeof(ui8),ui8);
    printf("char(%lu): %d \n", sizeof(ui16),ui16);
    printf("char(%lu): %d \n", sizeof(ui32),ui32);
    printf("char(%lu): %d \n", sizeof(ui64),ui64);

    return(0);
}