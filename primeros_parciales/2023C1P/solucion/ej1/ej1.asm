global templosClasicos
global cuantosTemplosClasicos
global esTemploClasico

extern malloc



;########### SECCION DE TEXTO (PROGRAMA)
section .text


;templos (1 byte cant largo, + 7 padding
; 8 bytes direcc nombre,
; 1 byte cant corto + 7 padding por alineado a dato mas grande)


;templo* templosClasicos(templo* templo, size_t cant_templos) -> RDI, RSI
templosClasicos:
    ;prologo 
    push rbp
    mov rbp, rsp

    push rbx
    push r15
    push r14
    push r13


    ;preservo rdi,rsi por ser V
    mov rbx, rdi
    
    ;cuento la cant de templos clasicos para el malloc
    call cuantosTemplosClasicos
    
    mov rdi, rax ;voy a usar esto para el malloc, lo pongo en rdi pues es parametro
    
    mov r14, rax
    
    ;obviamente el struct no mide 1 byte, mide 24 y entonces lo multiplico
    mov r8, rdi
    shl r8, 3 
    shl rdi, 4
    add rdi, r8
    call malloc 

    ; si el tamano era cero termino aca, rax va a tener un pointer de 0 y listo
    cmp r14, 0
    je .fin

    ;como voy a hacer mas llamados preservo el puntero de la memoria liberada
    mov r15, rax
    
    push r15 ;como voy a estar iterando sobre la memoria liberada me guardo el puntero al comienzo

    .loop:


        mov rdi, rbx
        call esTemploClasico
        cmp rax, 0
        je .no_agregar
        
        ;pongo el templo_t en r9 y lo guardo en el puntero de malloc (hay que hacer 3 movs pq son 24 bytes = 3 * 8 bytes)
        mov r9, qword [rbx]
        mov [r15], r9
        mov r9, qword [rbx + 8]
        mov [r15 + 8], r9
        mov r9, qword [rbx + 16]
        mov [r15 + 16], r9
        dec r14
        ;actualizo puntero de r15
        add r15, 24

    .no_agregar:
        
        cmp r14, 0
        je .fin
        add rbx, 24
        jmp .loop

    .fin:
    pop rax
    pop r13
    pop r14
    pop r15
    pop rbx
    pop rbp
    ret

        



;uint8_t esTemploClasico(templo* templo)
esTemploClasico:
    xor rax, rax
    ;guardo en r8 largo y en r9 corto
    mov r8b, byte [rdi]
    mov r9b, byte [rdi + 16]
        
    ;multiplico por dos shfteando a derecha 
    shl r9b, 1 
    add r9b, 1

    cmp r8b, r9b
    jne .no_suma
    add rax, 1
    .no_suma:
    ret 
        


;uint32_t cuantosTemplosClasicos(templo* templo, size_t cant_templos_arr) -> RDI, RSI
cuantosTemplosClasicos:
    ;prologo
    push rbp
    mov rbp, rsp

    cmp rsi, 0
    je .fin

    and rax, 0
.loop:
        ;guardo en r8 largo y en r9 corto
        mov r8b, byte [rdi]
        mov r9b, byte [rdi + 16]
        
        ;multiplico por dos shfteando a derecha 
        shl r9b, 1 
        add r9b, 1

        cmp r8b, r9b
        jne .no_suma
        add rax, 1
        .no_suma:

        sub rsi, 1
        cmp rsi, 0
        je .fin
        add rdi, 24
        jmp .loop
.fin:
        pop rbp
        ret


