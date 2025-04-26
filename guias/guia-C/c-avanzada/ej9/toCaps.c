#include <stdio.h>
#include <ctype.h>
#include <stdint.h>

char* toCaps(char* string){
    int i = 0;
    
    while(*string != '\0'){
        if(!islower(string[i])){
            string[i] += 32;
        }
        i++;
    }
    return string;
}


int main(){
    char word[4] = "Hola";
    printf("%s", word);
    printf("\n %s", toCaps(word));
    
    return 0;
}