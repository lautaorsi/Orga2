global templosClasicos
global cuantosTemplosClasicos

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



    


;uint32_t cuantosTemplosClasicos(templo* templo, size_t cant_templos_arr) -> RDI, RSI
cuantosTemplosClasicos:
    ;prologo
    push rbp
    mov rbp, rsp

    cmp esi, 0
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
        jne no_suma
        add rax, 1
        no_suma:

        sub rsi, 1
        cmp rsi, 0
        je .fin
        jmp .loop




.fin:
        pop rbp
        ret


