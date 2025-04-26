#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

int main(){
    uint16_t dice[6] = {1,2,3,4,5,6};
    uint16_t rollCount[6] = {0,0,0,0,0,0};
    int rollsLeft = 60000000;
    while(rollsLeft != 0){
        rollCount[(rand() % 6)]++;
        rollsLeft--; 
    }
    
    

    printf("%d %d %d %d %d %d", rollCount[0], rollCount[1], rollCount[2], rollCount[3], rollCount[4], rollCount[5]);

    return 0;

}