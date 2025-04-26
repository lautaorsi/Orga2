

;########### ESTOS SON LOS OFFSETS Y TAMAÑO DE LOS STRUCTS
; Completar las definiciones (serán revisadas por ABI enforcer):
NODO_OFFSET_NEXT EQU 8
NODO_OFFSET_CATEGORIA EQU 1
NODO_OFFSET_ARREGLO EQU 8
NODO_OFFSET_LONGITUD EQU 4
NODO_SIZE EQU 32
PACKED_NODO_OFFSET_NEXT EQU 8
PACKED_NODO_OFFSET_CATEGORIA EQU 1
PACKED_NODO_OFFSET_ARREGLO EQU 8
PACKED_NODO_OFFSET_LONGITUD EQU 4
PACKED_NODO_SIZE EQU 21
LISTA_OFFSET_HEAD EQU 8
LISTA_SIZE EQU 8
PACKED_LISTA_OFFSET_HEAD EQU 8
PACKED_LISTA_SIZE EQU 8

;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS
global cantidad_total_de_elementos
global cantidad_total_de_elementos_packed

;########### DEFINICION DE FUNCIONES
;extern uint32_t cantidad_total_de_elementos(lista_t* lista);
;registros: lista[RDI]
cantidad_total_de_elementos:
	;prologo
	push rbp
	mov rbp, rsp

	xor eax, eax
	;Tenemos un pointer a una lista, accedemos a la lista
	MOV RDI, qword [RDI]

loop:
	;En la lista tenemos un header que es la direccion al primer nodo,
	;guardo en ESI el valor contenido en la direccion + offset para llegar a long (ppio del nodo + 24)
	MOV ESI, dword [RDI + 24]
	add eax, esi


	;Guardo en RDI la direccion del nuevo nodo
	MOV RDI, QWORD [RDI]

	xor r8, r8
	CMP RDI, r8
	jne loop

	pop rbp	
	ret

;extern uint32_t cantidad_total_de_elementos_packed(packed_lista_t* lista);
;registros: lista[RDI]
cantidad_total_de_elementos_packed:
	;prologo
	push rbp
	mov rbp, rsp

	xor eax, eax
	;Tenemos un pointer a una lista, accedemos a la lista
	MOV RDI, qword [RDI]

loop2:
	;En la lista tenemos un header que es la direccion al primer nodo,
	;guardo en ESI el valor contenido en la direccion + offset para llegar a long (ppio del nodo + 24)
	MOV ESI, dword [RDI + 17]
	add eax, esi


	;Guardo en RDI la direccion del nuevo nodo
	MOV RDI, QWORD [RDI]

	xor r8, r8
	CMP RDI, r8
	jne loop2

	pop rbp	
	
	
	ret

