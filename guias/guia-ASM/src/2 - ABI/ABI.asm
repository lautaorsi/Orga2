extern sumar_c
extern restar_c
;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS

global alternate_sum_4
global alternate_sum_4_using_c
global alternate_sum_4_using_c_alternative
global alternate_sum_8
global product_2_f
global product_9_f

;########### DEFINICION DE FUNCIONES
; uint32_t alternate_sum_4(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; parametros: 
; x1 --> EDI
; x2 --> ESI
; x3 --> EDX
; x4 --> ECX
alternate_sum_4:
  sub EDI, ESI
  add EDI, EDX
  sub EDI, ECX

  mov EAX, EDI
  ret

; uint32_t alternate_sum_4_using_c(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; parametros: 
; x1 --> EDI
; x2 --> ESI
; x3 --> EDX
; x4 --> ECX
alternate_sum_4_using_c:
  ;prologo
  push RBP ;pila alineada
  mov RBP, RSP ;strack frame armado
  push R12
  push R13	; preservo no volatiles, al ser 2 la pila queda alineada

  mov R12D, EDX ; guardo los parámetros x3 y x4 ya que están en registros volátiles
  mov R13D, ECX ; y tienen que sobrevivir al llamado a función

  call restar_c 
  ;recibe los parámetros por EDI y ESI, de acuerdo a la convención, y resulta que ya tenemos los valores en esos registros
  
  mov EDI, EAX ;tomamos el resultado del llamado anterior y lo pasamos como primer parámetro
  mov ESI, R12D
  call sumar_c

  mov EDI, EAX
  mov ESI, R13D
  call restar_c

  ;el resultado final ya está en EAX, así que no hay que hacer más nada

  ;epilogo
  pop R13 ;restauramos los registros no volátiles
  pop R12
  pop RBP ;pila desalineada, RBP restaurado, RSP apuntando a la dirección de retorno
  ret


alternate_sum_4_using_c_alternative:
  ;prologo
  push RBP ;pila alineada
  mov RBP, RSP ;strack frame armado
  sub RSP, 16 ; muevo el tope de la pila 8 bytes para guardar x4, y 8 bytes para que quede alineada

  mov [RBP-8], RCX ; guardo x4 en la pila

  push RDX  ;preservo x3 en la pila, desalineandola
  sub RSP, 8 ;alineo
  call restar_c 
  add RSP, 8 ;restauro tope
  pop RDX ;recupero x3
  
  mov EDI, EAX
  mov ESI, EDX
  call sumar_c

  mov EDI, EAX
  mov ESI, [RBP - 8] ;leo x4 de la pila
  call restar_c

  ;el resultado final ya está en EAX, así que no hay que hacer más nada

  ;epilogo
  add RSP, 16 ;restauro tope de pila
  pop RBP ;pila desalineada, RBP restaurado, RSP apuntando a la dirección de retorno
  ret


; uint32_t alternate_sum_8(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4, uint32_t x5, uint32_t x6, uint32_t x7, uint32_t x8);
; registros y pila: x1[EDI], x2[ESI], x3[EDX], x4[ECX], x5[R8], x6[R9], x7[RBP + 0x10], x8[RBP + 0x18]
alternate_sum_8:
	;prologo
  push RBP ;pila alineada
  mov RBP, RSP ;stack frame armado
  
  sub edi, esi
  add edi, edx
  sub edi, ecx
  add edi, r8d
  sub edi, r9d
  
  mov esi, [rbp + 16]
  mov edx, [rbp + 24]

  add edi, esi
  sub edi, edx

  mov eax, edi


  pop RBP;
	;epilogo2
	ret


; SUGERENCIA: investigar uso de instrucciones para convertir enteros a floats y viceversa
;void product_2_f(uint32_t * destination, uint32_t x1, float f1);
;registros: destination[EDI], x1[ESI], f1[XMM0]
product_2_f:
	;prologo
  push RBP ;pila alineada
  mov RBP, RSP ;stack frame armado


  CVTSI2SD XMM1, ESI        ; paso a float el primer numero (2do param) 
	CVTSS2SD Xmm0, XMM0

  MULSD XMM1, XMM0          ; multiplico ambos floats y guardo en XMM1
  
  CVTTSD2SI ESI, XMM1       ; guardo en esi el resultado, truncando a int
  
  MOV [RDI], ESI            ; cambio la direccion del puntero EDI a ESI
  
  ;epilogo
  pop RBP  
  ret


;extern void product_9_f(double * destination
;, uint32_t x1, float f1, uint32_t x2, float f2, uint32_t x3, float f3, uint32_t x4, float f4
;, uint32_t x5, float f5, uint32_t x6, float f6, uint32_t x7, float f7, uint32_t x8, float f8
;, uint32_t x9, float f9);
;registros y pila: destination[rdi], x1[ESI], f1[XMM0], x2[EDX], f2[XMM1], x3[ECX], f3[XMM2], x4[R8], f4[XMM3]
;	, x5[R9], f5[XMM4], x6[RBP + 0x10], f6[XMM5], x7[RBP + 0x18], f7[XMM6], x8[RBP + 0x20], f8[XMM7],
;	, x9[RBP + 0x28], f9[RBP + 0x30]
product_9_f:
	;prologo
	push rbp
	mov rbp, rsp

	;convertimos los flotantes de cada registro xmm en doubles
  CVTSS2SD XMM0, XMM0
  CVTSS2SD XMM1, XMM1
  CVTSS2SD XMM2, XMM2
  CVTSS2SD XMM3, XMM3
  CVTSS2SD XMM4, XMM4
  CVTSS2SD XMM5, XMM5
  CVTSS2SD XMM6, XMM6
  CVTSS2SD XMM7, XMM7


	;multiplicamos los doubles en xmm0 <- xmm0 * xmm1, xmmo * xmm2 , ...
	MULSD XMM0, XMM1
  MULSD XMM0, XMM2 
  MULSD XMM0, XMM3
  MULSD XMM0, XMM4
  MULSD XMM0, XMM5
  MULSD XMM0, XMM6
  MULSD XMM0, XMM7

  ;guardamos el ultimo float en pila en registros
  MOVSS XMM1, DWORD [RBP + 0x30]

  ;convertimos float a double
  CVTSS2SD XMM1, XMM1

  ;multiplicamos
  MULSD XMM0, XMM1


	; convertimos los enteros guardados en registros en doubles y los multiplicamos por xmm0.
	CVTSI2SD XMM1, RSI
  CVTSI2SD XMM2, RDX
  CVTSI2SD XMM3, RCX
  CVTSI2SD XMM4, R8D
  CVTSI2SD XMM5, R9D
  MULSD XMM0, XMM1
  MULSD XMM0, XMM2
  MULSD XMM0, XMM3
  MULSD XMM0, XMM4
  MULSD XMM0, XMM5

  ;guardamos los enteros de pila en registros ya utilizados
  MOV EDX, DWORD [RBP + 0x10]
  MOV ECX, DWORD [RBP + 0x18]
  MOV R8D, DWORD [RBP + 0x20]
  MOV R9D, DWORD [RBP + 0x28]
  





  ;convertimos enteros a double
  CVTSI2SD XMM2, RDX
  CVTSI2SD XMM3, RCX
  CVTSI2SD XMM4, R8D
  CVTSI2SD XMM5, R9D

  ;multiplicamos en xmm0
  MULSD XMM0, XMM2
  MULSD XMM0, XMM3
  MULSD XMM0, XMM4
  MULSD XMM0, XMM5

  MOVSD [RDI], XMM0

	; epilogo
	pop rbp
	ret

