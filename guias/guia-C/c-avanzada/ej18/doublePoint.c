#include <stdio.h>

void allocateArray(int **arr, int size, int value) {
    *arr = (int*) malloc(size * sizeof(int));
    if(*arr != NULL) {
        for(int i=0; i<size; i++) {
            (*arr)[i] = value;
        }
    }
}
    // Uso
    int *vector = NULL;
    allocateArray(&vector)
    for(int i = 0; i < 5; i++)
    printf("%d\n", vector[i]);
    free(vector);