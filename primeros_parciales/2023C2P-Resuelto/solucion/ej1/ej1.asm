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
; rsi -> direccion del string usuario
contar_pagos_aprobados_asm:
        ;prologo
        push rbp
        mov rbp, rsp
        push rbx
        push r15
        push r14
        push r13

        and r14, 0 ;uso r14 de contador

        mov rbx, [rdi] ;entro a la direccion de la lista, en los primeros 8 bytes tengo la direccion de listelem

        cmp rbx, 0 ;si no tiene elems la lista termino aca
        je .fin

        
        mov r15, rsi ;guardo nombre para no perderlo
        

        .loop:
        mov r13, [rbx] ;accedo a direccion de pago_t
        mov rdi, [r13 + 16] ;cargo en rdi el nombre del cobrador
        mov rsi, r15 ;cargo en rsi el nombre a contar
        
        call strcmp ;en rdi tengo nombre de cobrador y en rsi nombre de usuario a comparar

        cmp rax, 0
        jne .no_sumar

        movzx rdi, byte [r13 + 1] ;agarro aprobado
        cmp rdi, 1
        jne .no_sumar
        add r14, 1

        .no_sumar:
        mov rbx, [rbx + 8] ;me muevo a siguiente listelem
        cmp rbx, 0 ;si es null termino
        je .fin
        jmp .loop
        
        .fin:
        mov rax, r14
        pop r13
        pop r14
        pop r15
        pop rbx
        pop rbp
        ret





    

    







; uint8_t contar_pagos_rechazados_asm(list_t* pList, char* usuario);
contar_pagos_rechazados_asm:
        ;prologo
        push rbp
        mov rbp, rsp
        push rbx
        push r15
        push r14
        push r13

        and r14, 0 ;uso r14 de contador

        mov rbx, [rdi] ;entro a la direccion de la lista, en los primeros 8 bytes tengo la direccion de listelem

        cmp rbx, 0 ;si no tiene elems la lista termino aca
        je .fin

        
        mov r15, rsi ;guardo nombre para no perderlo
        

        .loop:
        mov r13, [rbx] ;accedo a direccion de pago_t
        mov rdi, [r13 + 16] ;cargo en rdi el nombre del cobrador
        mov rsi, r15 ;cargo en rsi el nombre a contar
        
        call strcmp ;en rdi tengo nombre de cobrador y en rsi nombre de usuario a comparar

        cmp rax, 0
        jne .no_sumar

        movzx rdi, byte [r13 + 1] ;agarro aprobado
        cmp rdi, 0
        jne .no_sumar
        add r14, 1

        .no_sumar:
        mov rbx, [rbx + 8] ;me muevo a siguiente listelem
        cmp rbx, 0 ;si es null termino
        je .fin
        jmp .loop
        
        .fin:
        mov rax, r14
        pop r13
        pop r14
        pop r15
        pop rbx
        pop rbp
        ret

; rdi -> list_t*
; rsi -> char*
; rdx -> array a llenar
; rax -> pagos__t**
llenar_array_pagos_aprobados_asm:
        ;prologo
        push rbp
        mov rbp, rsp
        push rbx
        push r15
        push r14
        push r13

        mov rbx, [rdi] ;entro a la direccion de la lista, en los primeros 8 bytes tengo la direccion de listelem
        mov r15, rsi    ;r15 = nombre
        mov r14, rdx    ;r14 = posicion de array a llenar

        push rdx ;preservo direccion de array para el retorno
        sub rsp, 8 ;alineo stack

        cmp rbx, 0 ;si no tiene elems la lista termino aca
        je .fin

        .loop:
        mov r13, [rbx] ;accedo a direccion de pago_t
        mov rdi, [r13 + 16] ;cargo en rdi el nombre del cobrador
        mov rsi, r15 ;cargo en rsi el nombre a comparar
        
        call strcmp ;en rdi tengo nombre de cobrador y en rsi nombre de usuario a comparar

        cmp rax, 0 ;si no tiene el mismo nombre no lo agrego
        jne .no_agregar

        movzx rdi, byte [r13 + 1] 
        cmp rdi, 0      ;si no fue aprobado no lo agrego
        je .no_agregar
        mov [r14], r13
        add r14, 8 ;actualizo indice a llenar de array

        .no_agregar:
        mov rbx, [rbx + 8] ;me muevo a siguiente listelem
        cmp rbx, 0 ;si es null termino
        je .fin
        
        jmp .loop

        .fin:
        add rsp, 8
        pop rax
        pop r13
        pop r14
        pop r15
        pop rbx
        pop rbp
        ret



; rdi -> list_t*
; rsi -> char*
; rdx -> array a llenar
; rax -> pagos__t**
llenar_array_pagos_rechazados_asm:
        ;prologo
        push rbp
        mov rbp, rsp
        push rbx
        push r15
        push r14
        push r13

        mov rbx, [rdi] ;entro a la direccion de la lista, en los primeros 8 bytes tengo la direccion de listelem
        mov r15, rsi    ;r15 = nombre
        mov r14, rdx    ;r14 = posicion de array a llenar

        push rdx ;preservo direccion de array para el retorno
        sub rsp, 8 ;alineo stack

        cmp rbx, 0 ;si no tiene elems la lista termino aca
        je .fin

        .loop:
        mov r13, [rbx] ;accedo a direccion de pago_t
        mov rdi, [r13 + 16] ;cargo en rdi el nombre del cobrador
        mov rsi, r15 ;cargo en rsi el nombre a comparar
        
        call strcmp ;en rdi tengo nombre de cobrador y en rsi nombre de usuario a comparar

        cmp rax, 0 ;si no tiene el mismo nombre no lo agrego
        jne .no_agregar

        movzx rdi, byte [r13 + 1] 
        cmp rdi, 1      ;si fue aprobado no lo agrego
        je .no_agregar
        mov [r14], r13
        add r14, 8 ;actualizo indice a llenar de array

        .no_agregar:
        mov rbx, [rbx + 8] ;me muevo a siguiente listelem
        cmp rbx, 0 ;si es null termino
        je .fin
        jmp .loop

        .fin:
        add rsp, 8
        pop rax
        pop r13
        pop r14
        pop r15
        pop rbx
        pop rbp
        ret


        

        
        

        

        
        
        







; pagoSplitted_t* split_pagos_usuario_asm(list_t* pList, char* usuario);
; pagoSplitted_t mide 24 bytes
split_pagos_usuario_asm:
        ;prologo
        push rbp
        mov rbp, rsp
        push rbx
        push r15
        push r14
        push r13

        mov rbx, rdi ; rbx = direccion al list_t
        mov r15, rsi ; rsi = nombre de usuario
        
        and rdi, 0
        add rdi, 24

        call malloc ;reservo 24 bytes para el pago_splitted

        mov r14, rax ;preservo el puntero al pago_splitted

        mov rdi, rbx 
        mov rsi, r15
        call contar_pagos_aprobados_asm
        
        mov byte [r14], al ;guardo cantidad pagos aprobados

        mov rdi, rbx
        mov rsi, r15
        call contar_pagos_rechazados_asm

        mov byte [r14 + 1], al   ;guardo cantidad pagos rechazados

        and rdi, 0
        mov dil, byte [r14]
        shl rdi, 3 ;el array va a tener cant aprobados * 8

        call malloc

        mov rdi, rbx
        mov rsi, r15
        mov rdx, rax

        call llenar_array_pagos_aprobados_asm

        mov [r14 + 8], rax ;guardo el array llenado
        
        and rdi, 0
        mov dil, byte [r14 + 1]
        shl rdi, 3 ;el array va a tener cant rechazados * 8

        call malloc

        mov rdi, rbx
        mov rsi, r15
        mov rdx, rax

        call llenar_array_pagos_rechazados_asm

        mov [r14 + 16], rax

        mov rax, r14

        ;epilogo
        pop r13
        pop r14
        pop r15
        pop rbx
        pop rbp
        ret
