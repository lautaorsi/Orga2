extern malloc
extern free
extern fprintf

section .data

section .text

global strCmp
global strClone
global strDelete
global strPrint
global strLen

; ** String **

; int32_t strCmp(char* a, char* b)
; a -> RDI
; b -> RSI
strCmp:
	;epilogo
	push rbp
	mov rbp, rsp


	xor r8, r8
	xor r9, r9

	loop:

	;leo los primeros 2 caracteres
	movzx r8, byte [rdi] 
	movzx r9, byte [rsi]

	;comparo los 2 primeros caracteres
	cmp r8d, r9d
	
	;si son distintos voy a la seccion "distintos"
	jne distintos

	;si son iguales comparo a 0
	cmp r8, 0
	je caso_cero

	;si no son cero, actualizo punteros y vuelvo a loopear
	add rsi, 1
	add rdi, 1
	jmp loop
	
	caso_cero:
	;si son cero, retorno 0
	mov rax, 0
	jmp fin

	distintos:
	;si r8 < r9 retorno -1
	jl ret1

	;si r8 > r9 retorno 1
	jg ret2

	ret1:
	mov rax, 1
	jmp fin

	ret2:
	mov rax, 0xFFFFFFFF
	jmp fin




	fin:
	;epilogo
	pop rbp
	ret

; char* strClone(char* a)
strClone:
	;prologo
	push rbp
	mov rbp, rsp

	push rbx

	mov rbx, rdi
	
	xor rax, rax

	;sizeof se fija la longitud de la palabra contenida en RDI y retorna la long
	call strLen


	

	;guardo longitud en rdi para pedir espacio + 1 para caracter final
	mov rdi, rax
	add rdi, 1


	call malloc 



	;guardo puntero a espacio liberado en r9
	mov r9, rax


	loop1:
		;me guardo la letra a la que apunta el puntero original
		movzx r10, byte [rbx]

		;pongo la letra en la posicion apuntada por el puntero
		mov byte [r9], r10b
		
		;si la letra guardada era el \0, freno
		cmp r10b, 0
		je fin4

		;actualizo las posiciones en ambas
		add r9, 1
		add rbx, 1
		jmp loop1

	fin4:
	
	
	;epilogo
	pop rbx
	pop rbp
	ret

; void strDelete(char* a)
strDelete:


	call free

	ret

; void strPrint(char* a, FILE* pFile)
strPrint:
	
	ret

; uint32_t strLen(char* a)
strLen:
	push rbp
	mov rbp, rsp

	xor eax, eax
	
	loop3:
		cmp byte [rdi], 0
		je fin3
		
		add eax, 1
		add rdi, 1
		jmp loop3


	fin3: 
		pop rbp
		ret


