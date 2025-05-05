global acumuladoPorCliente_asm
global en_blacklist_asm
global blacklistComercios_asm
global contar_pagos_blacklisteados

extern malloc
extern strcmp

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;RDI -> uint8_t cantidad de pagos
;RSI -> pago_t * pagos
;rax -> uint32_t* total de pagos 
acumuladoPorCliente_asm:
	;prologo
	push rbp
	mov rbp, rsp
	push rbx
	push r15
	push r14
	push r13


	push rdi
	push RSI ;preservo registros volatiles

	and rdi, 0 
	mov rdi, 80
	call malloc ;armo array de enteros (10 pointers = 80 bytes)

	mov rdi, rax
	
	pop r14 ;r13 = cantidad de pagos
	pop r13 ; r14 = arreglo de pagos
	mov r15, rax ; r15 = puntero array total

	;setteo todos los valores del malloc a cero
	and qword [r15], 0
	and qword [r15 + 8], 0
	and qword [r15 + 16], 0
	and qword [r15 + 24], 0
	and qword [r15 + 32], 0
	and qword [r15 + 40], 0



	cmp r13, 0
	je .fin ;si no hay pagos no itero

	.loop:
	movzx r8, byte [r14 + 16] ;obtengo id de cliente
	movzx r10, byte [r14] ;guardo en r10 el valor de pago
	movzx rbx, byte [r14 + 17] ;guardo aprobado
	cmp rbx, 0 ;si no esta aprobado paso al sig
	je .siguiente
	mov r9, r15 ;indice para iterar
	cmp r8, 0 ;si es id 0 lo guardo en el lugar
	jne .buscar_indice
	add [r15], r10
	jmp .siguiente
		.buscar_indice:
			dec r8
			add r9, 4
			cmp r8, 0
			je .agregar_en_indice
			jmp .buscar_indice
			.agregar_en_indice:
				add [r9], r10
	.siguiente:
	dec r13
	cmp r13, 0
	je .fin 
	add r14, 24 ;paso al siguiente pago
	jmp .loop

	.fin:
	mov rax, r15
	pop r13
	pop r14
	pop r15
	pop rbx
	pop rbp
	ret


;rdi -> char* comercio
;rsi -> char** lista de strings
;rdx -> longitud de lista
en_blacklist_asm:
	;prologo
	push rbp
	mov rbp, rsp
	push rbx
	push r15
	push r14
	push r13


	and r14, 0

	cmp rdx, 0
	je .fin

	mov rbx, rdi ;rbx = nombre
	mov r15, rdx ;r15 = cant de nombres
	mov r13, rsi ;r13 = lista de nombres
	.loop:
		mov rdi, rbx ;cargo nombre que estoy buscando
		mov rsi, [r13] ;cargo nombre del indice actual del array
		
		call strcmp	;comparo nombres

		cmp rax, 0
		jne .no_sumar ;si no son iguales sigo

		inc r14
		jmp .fin ;si son iguales pongo 1 en rax y termino

		.no_sumar:
		dec r15	;resto 1 a la cantidad de strings que me quedan recorrer
		cmp r15, 0 ;si ya recorri todos termino con rax = 0
		je .fin
		add r13, 8 ;si no termine, actualizo indice y loopeo
		jmp .loop

		
	.fin:
	mov rax, r14
	pop r13
	pop r14
	pop r15
	pop rbx
	pop rbp
	ret


;RDI -> uint8_t cantidad pagos
;rsi -> pago_t * arr_pagos
;rdx -> char** arr_comercios blacklisteados
;rcx -> uint8_t cantidad de blacklisteados
contar_pagos_blacklisteados:
	push rbp
	mov rbp, rsp

	push rbx
	push r15
	push r14
	push r13
	push r12

	mov rbx, rdi
	mov r15, rsi
	mov r14, rdx
	mov r13, rcx
	and r12, 0

	cmp rbx, 0
	je .fin

	.loop:
		mov rdi, [r15 + 8] ;agarro nombre del pago_t
		mov rsi, r14 ;cargo nombres blackilisteados
		mov rdx, r13 ;cargo longitud de lista RSI
		call en_blacklist_asm

		cmp rax, 0
		je .no_sumar
		
		inc r12

		.no_sumar:
		dec rbx
		cmp rbx, 0
		je .fin
		add r15, 24
		jmp .loop

	.fin:
	mov rax, r12
	pop r12
	pop r13
	pop r14
	pop r15
	pop rbx
	pop rbp
	ret






;RDI -> uint8_t cantidad pagos
;rsi -> pago_t * arr_pagos
;rdx -> char** arr_comercios blacklisteados
;rcx -> uint8_t size_comercios
;rax -> pago_t ** lista de pagos realizados por comercios blacklisteados 
blacklistComercios_asm:
	;prologo
	push rbp
	mov rbp, rsp
	push rbx
	push r15
	push r14
	push r13
	push r12

	mov rbx, rdi
	mov r15, rsi
	mov r14, rdx ;preservo los inputs en registros no volatiles
	mov r13, rcx

	call contar_pagos_blacklisteados

	mov rdi, rax 
	mov rbx, rdi
	shl rdi, 3 ;(multiplico por 8)
	call malloc

	mov r12, rax ;guardo puntero a array de pago_t
	push rax ;preservo puntero para iterar en r12
	sub rsp, 8

	cmp rbx, 0 ;si no hay pagos termino
	je .fin

	.loop:
	
	mov rdi, [r15 + 8]		;cargo el nombre de pago_t
	mov rsi, r14		;cargo la lista de nombres blacklisteados
	mov rdx, r13		;cargo el size de la lista
	call en_blacklist_asm
	
	cmp rax, 0 	;si no esta en blacklist no agrego el pago
	je .no_agregar

	mov [r12], r15
	
	dec rbx
	cmp rbx, 0
	je .fin
	add r12, 8 

	.no_agregar:
	add r15, 24
	
	jmp .loop

	.fin:
	add rsp, 8
	pop rax
	pop r12
	pop r13
	pop r14
	pop r15
	pop rbx
	pop rbp
	ret


