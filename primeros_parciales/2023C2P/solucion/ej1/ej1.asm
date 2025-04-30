section .text

global contar_pagos_aprobados_asm
global contar_pagos_rechazados_asm

global split_pagos_usuario_asm

extern malloc
extern free
extern strcmp


;########### SECCION DE TEXTO (PROGRAMA)

; uint8_t contar_pagos_aprobados_asm(list_t* pList, char* usuario);
; rdi -> direccion de la lista
; rsi -> direccion del principio del nombre de usuario
contar_pagos_aprobados_asm:
    ;prologo
    push rbp
    mov rbp, rsp
    push rbx
    push r15
    push r14
    push r13

    xor r13, r13 ;limpio r13 para usarlo como contador

    ;en rbx guardo el s_list
    mov rbx, qword [rdi]

    ;ahora en r15 guardo el primer elem de la lista
    mov r15, qword[rbx]

.loop:
        mov r14, qword r15 ;en r14 guardo la direcc al pago_t del nodo
        add r14, 16
        mov rdi, qword [r14] ;uso el offset para acceder a la direccion al str

        call strcmp

        cmp rax, 0
        jne .no_sumar
        add r13, 1

.no_sumar:
        ;cargo la direccion al proximo nodo en r15
        mov r15, [r15 + 8]
        ;si la direcc es null termina
        cmp r15, 0
        je .terminar
        ;si no, loopeamos
        jmp .loop
.terminar:
        pop r13
        pop r14
        pop r15
        pop rbx
        pop rbp
        ret





    

    







; uint8_t contar_pagos_rechazados_asm(list_t* pList, char* usuario);
contar_pagos_rechazados_asm:

; pagoSplitted_t* split_pagos_usuario_asm(list_t* pList, char* usuario);
split_pagos_usuario_asm:

