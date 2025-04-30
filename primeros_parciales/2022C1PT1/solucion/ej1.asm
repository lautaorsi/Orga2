extern malloc
extern strClone
extern free

global strArrayNew
global strArrayGetSize
global strArrayAddLast
global strArraySwap
global strArrayDelete

;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

; str_array_t* strArrayNew(uint8_t capacity)
strArrayNew:
    ;prolog
    push rbp
    mov rbp, rsp
    push rbx
    push r15
    push r14
    push r13

    ;guardo la capacidad en rbx
    mov rbx, rdi

    xor rdi, rdi
    add rdi, 16

    call malloc

    ;guardo capacidad
    mov [rax + 1], rbx

    ;seteo size 0
    mov [rax], byte 0

    ;guardo el pointer al struct 
    mov r13, rax

    ;hago el malloc para data
    mov rdi, rbx
    shl rdi, 3

    call malloc

    ;seteo el pointer a data
    mov qword [r13 + 8], rax

    ;si era capacidad 0 lo devuelvo asi nomas
    cmp rbx, 0 
    je .fin

    ;si no le asigno nulls a cada posicion del array de strings
    .loop:
        mov qword [rax], 0
        add rax, 8
        dec rbx
        cmp rbx, 0 
        je .fin
        jmp .loop




    .fin:
    mov rax, r13

    pop r13
    pop r14
    pop r15
    pop rbx
    pop rbp
    ret





; uint8_t  strArrayGetSize(str_array_t* a)
strArrayGetSize:
    movzx rax, byte [rdi]
    ret

; void  strArrayAddLast(str_array_t* a, char* data)
strArrayAddLast:
    push rbp
    mov rbp, rsp
    push rbx
    push r15

    movzx rbx, byte [rdi + 1] ;agarro la capacidad
    movzx r8, byte [rdi]
    cmp rbx, r8 ;si es igual al tamano no hago nada
    je .fin



    mov r8, [rdi] ;caso contrario incremento el tamano
    inc r8
    mov [rdi], r8



    ;agarro data (char**, lista de strings)
    mov r15, qword [rdi + 8]

.buscar_null:
    mov r9, [r15] ;voy a la direccion a la que apunta al elemento del array
    cmp r9, 0 ;si la direccion del elemento es NULL esta vacio y pongo ahi la palabra
    je .guardar_palabra

    add r15, 8 ;si no es NULL, voy al siguiente elemento del array
    jmp .buscar_null

.guardar_palabra:
    mov [r15], rsi
    je .fin


.fin:
    pop r15
    pop rbx
    pop rbp
    ret



; void  strArraySwap(str_array_t* a, uint8_t i, uint8_t j)
; a -> rdi
; i -> rsi
; j -> rdx
strArraySwap:
    ;prologo
    push rbp
    mov rbp, rsp
    push rbx
    push r15
    
    ;cargo el tamano
    xor r8, r8
    mov r8b, byte [rdi]

    ;me fijo si alguno esta fuera de rango
    cmp rsi, r8
    jg .fin
    cmp rdx, r8
    jg .fin

    mov r9, [rdi + 8] ;cargo array 

    mov r10, rsi ;cargo indice para iterar

    .loopPrimerElem: ;busco el primer puntero
        cmp r10, 0
        je .salirPrimerLoop
        dec r10
        add r9, 8
        jmp .loopPrimerElem
    .salirPrimerLoop:
        mov rbx, [r9] ;me guardo palabra en rbx, recordemos que en r9 es la posicion a guardar la 2da palabra
        mov r10, rdx ;iterador
        mov r15, [rdi + 8] ;cargo array para recorrer de nuevo y saber donde guardar 1era palabra
    .loopSegundoElem:
        cmp r10, 0
        je .swappear
        dec r10
        add r15, 8
        jmp .loopSegundoElem
    .swappear:
        mov r8, [r15] ;me guardo la palabra que esta en el indice de r15
        mov [r9], r8 ;en el indice de r9 pongo la palabra guardada en el indice r15
        mov [r15], rbx ;en el indice r15 pongo la palabra antes guardada en r9

    .fin:
    pop r15
    pop rbx
    pop rbp
    ret


        
        


    

    


; void  strArrayDelete(str_array_t* a)
strArrayDelete:
    ;prologo
    push rbp
    mov rbp, rsp

    ;guardo puntero al struct pq voy a llamar a free y rdi es volatil
    push rdi
    sub rsp, 8 ;alineada

   
    mov rdi, [rdi + 8] ;pongo en rdi el puntero al array de strings

    call free ;libero el array
    
    ;recupero el puntero al struct
    add rsp, 8
    pop rdi
    
    ;libero puntero a struct
    call free

    pop rbp
    ret
