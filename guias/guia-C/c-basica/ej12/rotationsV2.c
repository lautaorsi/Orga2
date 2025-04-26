#include <stdio.h>
#include <stdint.h>

int main(){
    uint32_t s[4]; 
    int rotations, actual;
    scanf("%u %u %u %u \n", &s[0], &s[1], &s[2], &s[3]);
    scanf("%d", &rotations);

    while(rotations > 0){
        actual= s[3]; 
        for(int i = 3; i > 0; i--){
            actual += s[i-1];
            s[i-1] = actual - s[i-1];
            actual -= s[i-1]; 
        }
        s[3] = actual;
        rotations--;
    }


    for(int i = 0; i < 4; i++){
        printf("%u",s[i]);
    }
    return 0;

}