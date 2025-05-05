extern malloc

section .rodata
; Acá se pueden poner todas las máscaras y datos que necesiten para el ejercicio

section .text
; Marca un ejercicio como aún no completado (esto hace que no corran sus tests)
FALSE EQU 0
; Marca un ejercicio como hecho
TRUE  EQU 1

; Marca el ejercicio 1A como hecho (`true`) o pendiente (`false`).
;
; Funciones a implementar:
;   - es_indice_ordenado
global EJERCICIO_1A_HECHO
EJERCICIO_1A_HECHO: db TRUE ; Cambiar por `TRUE` para correr los tests.

; Marca el ejercicio 1B como hecho (`true`) o pendiente (`false`).
;
; Funciones a implementar:
;   - indice_a_inventario
global EJERCICIO_1B_HECHO
EJERCICIO_1B_HECHO: db TRUE ; Cambiar por `TRUE` para correr los tests.

;########### ESTOS SON LOS OFFSETS Y TAMAÑO DE LOS STRUCTS
; Completar las definiciones (serán revisadas por ABI enforcer):
ITEM_NOMBRE EQU 0
ITEM_FUERZA EQU 20
ITEM_DURABILIDAD EQU 24
ITEM_SIZE EQU 28


		



global es_indice_ordenado	
	; rdi = item_t**     inventario
	; rsi = uint16_t*    indice
	; dx = uint16_t     tamanio
	; rcx = comparador_t comparador
es_indice_ordenado:
	;prologo
	push rbp
	mov rbp, rsp
	push rbx
	push r15
	push r14
	push r13
	push r12
	sub rsp, 8
	
	cmp dx, 2
	and rax, 0
	mov rax, 1
	jl .fin


	mov rbx, rdi ;rbx lista de items
	mov r15, rsi ;r15 orden que deberian tener
	movzx r14, dx ;tamanio de listas
	mov r13, rcx ;funcion comparadora
	and r12, 0 ;uso r12 para recorrer las listas
	.loop:
		mov rdi, r15
		mov rsi, r12 ;cargo lista de indices e indice actual
		
		.loop1: 
			cmp rsi, 0
			je .fin1
			add rdi, 2
			dec rsi
			jmp .loop1
		.fin1:
			mov si, word [rdi] ;cargo indice de la lista r15

		mov rdi, rbx ;cargo lista de items

		.loop2:
			cmp si, 0
			je .fin2
			add rdi, 8
			dec si
			jmp .loop2
		.fin2:
			mov rax, [rdi]

		push rax
		sub rsp, 8 ;guardo en el stack el puntero al item

		mov rdi, r15		
		mov rsi, r12
		inc rsi ;cargo lista de indices e indice+1
		.loop3:
			cmp rsi, 0
			je .fin3
			add rdi, 2
			dec rsi
			jmp .loop3
		.fin3:
			mov si, [rdi]

		mov rdi, rbx ;lista de items e indice nuevo

		.loop4:
			cmp si, 0
			je .fin4
			add rdi, 8
			dec si
			jmp .loop4
		.fin4:
			mov rax, [rdi]

		add rsp, 8
		pop rdi ;recupero item anterior
		mov rsi, rax ;item siguiente

		call r13

		cmp ax, 0
		je .fin
		
		inc r12
		mov r8, r14
		dec r8
		cmp r12, r8
		jl .loop
		jmp .fin
		
	.fin:
	add rsp, 8
	pop r12
	pop r13
	pop r14
	pop r15
	pop rbx
	pop rbp
	ret

;; Dado un inventario y una vista, crear un nuevo inventario que mantenga el
;; orden descrito por la misma.

;; La memoria a solicitar para el nuevo inventario debe poder ser liberada
;; utilizando `free(ptr)`.

;; item_t** indice_a_inventario(item_t** inventario, uint16_t* indice, uint16_t tamanio);

;; Donde:
;; - `inventario` un array de punteros a ítems que representa el inventario a
;;   procesar.
;; - `indice` es el arreglo de índices en el inventario que representa la vista
;;   que vamos a usar para reorganizar el inventario.
;; - `tamanio` es el tamaño del inventario.
;; 
;; Tenga en consideración:
;; - Tanto los elementos de `inventario` como los del resultado son punteros a
;;   `ítems`. Se pide *copiar* estos punteros, **no se deben crear ni clonar
;;   ítems**

global indice_a_inventario
	; rdi = item_t**  inventario
	; rsi = uint16_t* indice
	; dx = uint16_t  tamanio
indice_a_inventario:

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
	mov r14, rdx
	and r13, 0
	and r12, 0


	and rdi, 0
	movzx rdi, dx
	shl rdi, 3
	call malloc

	cmp r14, 0
	je .fin

	mov r13, rax ;array en el que voy a guardar punteros a items
	push rax

	.loop:
		mov rdi, r15
		mov rsi, r12 ;cargo lista de indices e indice actual
		
		.loop1: 
			cmp rsi, 0
			je .fin1
			add rdi, 2
			dec rsi
			jmp .loop1
		.fin1:
			mov si, word [rdi] ;cargo indice de la lista r15

		mov rdi, rbx ;cargo lista de items

		.loop2:
			cmp si, 0
			je .fin2
			add rdi, 8
			dec si
			jmp .loop2
		.fin2:
			mov rax, [rdi] ;tengo en rax el puntero al item

		mov [r13], rax
		
		inc r12
		cmp r12, r14
		je .fin
		add r13, 8
		jmp .loop

	.fin:
	pop rax
	pop r12
	pop r13
	pop r14
	pop r15
	pop rbx
	pop rbp
	ret
