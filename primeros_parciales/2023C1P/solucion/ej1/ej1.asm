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

    ;como voy a llamar a cuantosTemplosClasicos me guardo los registros volatiles que tenia
    push RDI
    push rsi


    call cuantosTemplosClasicos

    pop rsi
    pop rdi

    ;en r8 tengo la cantidad de templos
    mov r8, rax



    ;POR LAS DUDAS, como voy a llamar a malloc me guardo rdi y rsi (son volatiles)
    push rdi
    push rsi

    ;malloc pide cantidad de bytes, asi que tengo que hacer sizeof(templo) * cant_templos
    mov r10, r8
    shl r8, 3
    shl r10, 4
    add r8, r10
    
    ;pongo el valor en rdi para call malloc
    mov rdi, r8


    call malloc


    
    ;ahora en rax tengo el puntero al ppio del array 
    ;recupero los registros iniciales
    pop RsI
    pop rdi

    ;voy a mantener en rax el puntero para cuando haga el ret, y para iterar voy a usar r9
    mov r9, rax

    ;si el array era vacio, retorno la direcc sin mas
    cmp rsi, 0
    je fin1


    ;recordemos que rdi tiene la direccion del primer elemento del arreglo templos (24 bytes de long cada uno)
    loop1:

        ;me guardo el primer elem del array en r10, me fijo si es clasico
        mov r10, qword[rdi]

        push r10
        push r9
        push rsi
        push rdi

        call esTemploClasico
        
        pop rdi
        pop rsi
        pop r9
        pop r10


        cmp rax, 1
        jne no_agregar
        mov [r9], r10

        sub rsi, 1
        ;si ya recorri el array termino
        cmp rsi, 0
        je fin1

        no_agregar:
        add r9, 24
        add rdi, 24

        jmp loop1
        

    fin1:
        pop rbp
        ret
        

esTemploClasico:
    
    and rax, 0
    ;guardo en r8 largo y en r9 corto
    mov r8b, byte [rdi]
    mov r9b, byte [rdi + 16]
        
    ;multiplico por dos shfteando a derecha 
    shl r9b, 1 
    add r9b, 1

    cmp r8b, r9b
    jne fin2
    add rax, 1
    fin2:
        ret


    


;uint32_t cuantosTemplosClasicos(templo* templo, size_t cant_templos_arr) -> RDI, RSI
cuantosTemplosClasicos:
    ;prologo
    push rbp
    mov rbp, rsp

    cmp esi, 0
    je fin3

    and rax, 0


    loop3:
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
        je fin3
        jmp loop3




    fin3:
        pop rbp
        ret


