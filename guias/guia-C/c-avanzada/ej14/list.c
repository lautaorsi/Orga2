#include "list.h"
#include <stdlib.h>
#include <stdio.h>

list_t* listNew(type_t t) {
    list_t* l = malloc(sizeof(list_t));
    l->type = t; // l->type es equivalente a (*l).type
    l->size = 0;
    l->first = NULL;
    return l;
}

void listAddFirst(list_t* l, void* data) {
    node_t* n = malloc(sizeof(node_t));
    switch(l->type) {
        case TypeFAT32:
            n->data = (void*) copy_fat32((fat32_t*) data);
            break;
        case TypeEXT4:
            n->data = (void*) copy_ext4((ext4_t*) data);
            break;
        case TypeNTFS:
            n->data = (void*) copy_ntfs((ntfs_t*) data);
            break;
    }
    n->next = l->first;
    l->first = n;
    l->size++;
}
//se asume: i < l->size
void* listGet(list_t* l, uint8_t i){
    node_t* n = l->first;
    for(uint8_t j = 0; j < i; j++)
    n = n->next;
    return n->data;
}
//se asume: i < l->size
void* listRemove(list_t* l, uint8_t i){
    node_t* tmp = NULL;
    void* data = NULL;
    if(i == 0){
        data = l->first->data;
        tmp = l->first;
        l->first = l->first->next;
    }
    else{
        node_t* n = l->first;
        for(uint8_t j = 0; j < i- 1; j++)
             n = n->next;
        data = n->next->data;
        tmp = n->next;
        n->next = n->next->next;
    }

    free(tmp);
    l->size--;
    return data;
}
void listDelete(list_t* l){
    node_t* n = l->first;
    while(n){
        node_t* tmp = n;
        n = n->next;
        switch(l->type) {
            case TypeFAT32:
                rm_fat32((fat32_t*) tmp->data);
                break;
            case TypeEXT4:
                rm_ext4((ext4_t*) tmp->data);
                break;
            case TypeNTFS:
                rm_ntfs((ntfs_t*) tmp->data);
                break;
        }
        free(tmp);
    }
    free(l);
 }

void listSwap(list_t* l, uint8_t i1, uint8_t i2){
    node_t* current = l->first;

    for(int j = 0; j != i1; j++){
        current = current->next;    
    }
    node_t* node1 = current;
    node_t* temp;
    switch(l->type) {
        case TypeFAT32:
            temp->data = (void*) copy_fat32((fat32_t*) node1);
            break;
        case TypeEXT4:
            temp->data = (void*) copy_ext4((ext4_t*) node1);
            break;
        case TypeNTFS:
            temp->data = (void*) copy_ntfs((ntfs_t*) node1);
            break;
    }

    current = l -> first;
    for(int j = 0; j != i2; j++){
        current = current->next;    
    }

    node_t* node2 = current;

    switch(l->type) {
        case TypeFAT32:
            node1->data = (void*) copy_fat32((fat32_t*) node2);
            break;
        case TypeEXT4:
            node1->data = (void*) copy_ext4((ext4_t*) node2);
            break;
        case TypeNTFS:
            node1->data = (void*) copy_ntfs((ntfs_t*) node2);
            break;
    }

        switch(l->type) {
        case TypeFAT32:
            node2->data = (void*) copy_fat32((fat32_t*) temp);
            break;
        case TypeEXT4:
            node2->data = (void*) copy_ext4((ext4_t*) temp);
            break;
        case TypeNTFS:
            node2->data = (void*) copy_ntfs((ntfs_t*) temp);
            break;
    }



}