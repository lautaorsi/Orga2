; /** defines bool y puntero **/
%define NULL 0
%define TRUE 1
%define FALSE 0

section .data

section .text

global string_proc_list_create_asm
global string_proc_node_create_asm
global string_proc_list_add_node_asm
global string_proc_list_concat_asm

; FUNCIONES auxiliares que pueden llegar a necesitar:
extern malloc
extern free
extern str_concat


string_proc_list_create_asm:
    ;prologo
    push rbp
    mov rbp, rsp

    ;la struct lista tiene 2 punteros (16 bytes totales)
    mov rdi, 16

    call malloc

    ;en rax tengo el pointer al struct, los setteo en null
    and r8, 0
    mov [rax], r8
    mov [rax + 8], r8

    mov rdi, rax

    ;epilogo
    pop rbp
    ret



;rdi -> uint8_t type
;rsi -> char* hash
;retorna puntero a nodo
string_proc_node_create_asm:
    ;prologo
    push rbp
    mov rbp, rsp

    push rbx
    push r15
    push r14
    push r13

    ;preservo rdi, rsi
    mov rbx, rdi
    mov r15, rsi
    
    ;cargo cant de bytes para malloc
    mov rdi, 32
    
    call malloc

    and r14, 0
    mov [rax], r14
    mov [rax + 8], r14
    mov [rax + 16], rbx ;guardo el type 
    mov [rax + 24], r15 ;guardo el puntero al hash

    mov rdi,rax

    ;epilogo
    pop r13
    pop r14
    pop r15
    pop rbx
    pop rbp
    ret

; rdi -> puntero a lista
; rsi -> uint8_t type
; rdx -> char* hash
string_proc_list_add_node_asm:
    ;prologo
    push rbp
    mov rbp, rsp

    push rbx
    push r15
    push r14
    push r13

    ;preservo puntero a lista
    mov rbx, rdi

    ;acomodo registros para call node create
    mov rdi, rsi
    mov rsi, rdx

    call string_proc_node_create_asm ;en rax tengo el puntero al nodo, con el type y hash ya cargados

    mov rdi, [rbx + 8] ;agarro puntero a ult elemento de la lista
    mov [rax + 8], rdi ;lo pongo en "anterior" de nuevo nodo

    ;me fijo si lista esta vacia con el puntero al ultimo elemento (si es null esta vacia)
    cmp rdi, 0
    jne .lista_no_vacia

    ;caso lista vacia
    mov [rbx], rax ;pongo el nodo como primer elemento
    mov [rbx + 8], rax ;y tambien como ultimo elemento
    jmp .fin

    .lista_no_vacia:
        mov [rdi], rax ;pongo el nuevo nodo como next del ultimo elemento
        mov [rbx + 8], rax ;pongo nuevo nodo como ultimo en lista
        jmp .fin
    



    .fin:
    pop r13
    pop r14
    pop r15
    pop rbx

    ;epilogo
    pop rbp
    ret

;rdi -> lista_t* lista
;rsi -> uint8_t type
;rdx -> char* hash
;rax -> char*
string_proc_list_concat_asm:
    ;prologo
    push rbp
    mov rbp, rsp

    push rbx
    push r15
    push r14
    push r13

    mov r13, rsi ;preservo tipo
    mov r14, rdx ;preservo hash

    mov rdi, [rdi] ;guardo en rdi puntero a primer nodo
    
    cmp rdi, 0 ;si es null es lista vacia y termina
    je .fin

    push rdi ;guardo puntero a nodo

    and rdi, 0
    add rdi, 1
    call malloc         ;hago un string vacio para el hash
    mov rsi, rax

    mov rdi, r14 ;hash original
    mov byte [rsi], 0 ;con el str vacio

    push rsi

    call str_concat

    mov r14, rax ;guardo hash en r14 

    pop rdi ;recupero puntero a 1 byte de malloc y lo libero
    call free

    pop rdi ;recupero puntero a nodo

  


    
    .loop:
        mov r15, [rdi] ;guardo direccion de next en r15
        movzx r8, byte [rdi + 16] ;guardo tipo del nodo 
        cmp r8, r13 ;comparo tipos
        jne .no_agregar
        mov rsi, [rdi + 24] ;agarro el string si son iguales
        mov rdi, r14 ;cargo el hash

        call str_concat 
        
        mov rdi, r14 ;guardo puntero de hash anterior para liberarlo
        mov r14, rax ;actualizo el hash

        call free ;libero hash anterior

        
        .no_agregar:
            cmp r15, 0 ;si el siguiente es null termine
            je .fin
            mov rdi, r15 ;actualizo nodo a siguiente
            jmp .loop

    

    .fin:
    mov rax, r14
    pop r13
    pop r14
    pop r15
    pop rbx


    ;epilogo
    pop rbp
    ret



