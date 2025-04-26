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
    ;prologo, preservo rdi
    push rbp
    mov rbp, rsp
    push rdi 

    xor r10,r10

    ;muevo a rdx la lista (8 bytes -> direcc firstElem
    ;                   8 bytes -> direcc lastElem)
    mov rdx, [rdi]

    ;la lista en si no importa, accedo al primer nodo de la lista
    mov rdx, qword [rdx]

    loop:
        ;si la direcc es null termino
        cmp rdx, 0
        je fin

        ;el nodo tiene en los primeros 8 bytes la direcc de pago_t, guardo pago_t en rcx
        mov rcx, qword [rdx]

        ;el ppio del nombre esta 8 bytes adelante (2 bytes de contenido + 6 de padding)
        mov rdi, qword [rcx + 8]

        mov rax,[rdi]

        call strcmp

    fin:
        ret

    







; uint8_t contar_pagos_rechazados_asm(list_t* pList, char* usuario);
contar_pagos_rechazados_asm:

; pagoSplitted_t* split_pagos_usuario_asm(list_t* pList, char* usuario);
split_pagos_usuario_asm:

