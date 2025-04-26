#include <stdio.h>
#include <stdint.h>

int main(){
    uint32_t low_mask = 0x7;
    uint32_t high_mask = 0xE0000000;
    uint32_t word1, word2;
    scanf("%x%x", &word1, &word2);
    printf("%d",((word1 & high_mask) >> 29) == (word2 & low_mask));



    return 0;

    
}