#include "type.h"
#include <stdlib.h>
fat32_t someN = 0X00000001;

fat32_t* new_fat32(){
    fat32_t *someFat = malloc(sizeof(fat32_t));
    *someFat = someN;
    someN ++;
    return someFat;
}
ext4_t* new_ext4(){
    ext4_t *someExt = malloc(sizeof(ext4_t));
    someExt = (ext4_t *)90;
    return someExt;
}
ntfs_t* new_ntfs(){
    ntfs_t *someNtfs = malloc(sizeof(ntfs_t));
    someNtfs = (ntfs_t *) 90;
    return someNtfs;
}
fat32_t* copy_fat32(fat32_t* file){
    fat32_t *copy = &*file;
    return copy;
}
ext4_t* copy_ext4(ext4_t* file){
    ext4_t *copy = &*file;
    return copy;
}
ntfs_t* copy_ntfs(ntfs_t* file){
    ntfs_t *copy = &*file;
    return copy;
}

void rm_fat32(fat32_t* file){
    free(file);
}
void rm_ext4(ext4_t* file){
    free(file);
}
void rm_ntfs(ntfs_t* file){
    free(file);
}