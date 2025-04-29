extern malloc
extern strClone

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

    ;seteo data vacia
    mov qword [rax + 8], 0

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

    movzx rbx, byte [rdi + 1]
    cmp rbx, byte [rdi]
    je no_hacer_nada



    movzx rbx, byte [rdi]
    inc rbx
    mov byte [rdi], byte rbx



    ;guardo data (char**)
    mov rbx, qword [rdi + 8]

    ;pongo la primera direccion del arr en r15
    mov r15, [rdi]

.buscar_null:
    cmp r15, 0
    je posicion_a_guardar

    mov r15, [r15 + 8]
    jmp buscar_null

.posicion_a_guardar:
    mov rdi




.no_hacer_nada:
    pop r15
    pop rbx
    pop rbp
    ret



; void  strArraySwap(str_array_t* a, uint8_t i, uint8_t j)
strArraySwap:


; void  strArrayDelete(str_array_t* a)
strArrayDelete:


