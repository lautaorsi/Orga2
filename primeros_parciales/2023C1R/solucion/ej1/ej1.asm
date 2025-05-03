global acumuladoPorCliente_asm
global en_blacklist_asm
global blacklistComercios_asm

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


	and rax, 0

	cmp rdx, 0
	je .fin

	mov rbx, rdi ;rbx = nombre
	mov r15, rdx ;r15 = cant de nombres
	mov r13, rsi ;r13 = lista de nombres
	.loop:
		mov rdi, rbx
		mov rsi, [r13]
		call strcmp
		cmp rax, 0
		jne .no_sumar
		inc rax
		jmp .fin
		.no_sumar:
		dec r15
		cmp r15, 0
		je .fin
		add r13, 8
		jmp .loop

		
	.fin:
	pop r13
	pop r14
	pop r15
	pop rbx
	pop rbp
	ret

blacklistComercios_asm:
	ret
