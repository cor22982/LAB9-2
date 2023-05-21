; Universidad del Valle de Guatemala
; Mathew Cordero, 22982 - Jose de Leon,  22809 Grupo 4
; Descripcion:
; El programa realiza una inspeccion de los impuestos ISR a tributar y el regimen para el proximo a�o fiscal
; 20/05/2023

.386
.model flat, stdcall, c
.stack 4096

ExitProcess proto,dwExitCode:dword

.data
	ingresar_montos byte "Ingrese el monto del mes ",0
	n DWORD 12 ;numero de meses y facturas
	monto_anual DWORD 0 ;este es el monto anual
	pivote DWORD ?
    
    ;ADVERTENCIAS
    adv1 byte "Aviso Siguiente mes fiscal Peque�o Contribuyente | MONTO ANUAL TOTAL: Q.%d.00",0Ah,0
    adv2 byte "Aviso Siguiente mes fiscal Mediano Contribuyente | MONTO ANUAL TOTAL: Q.%d.00",0Ah,0

	;MESES
	mes1 BYTE  "Ene 2022:", 0
    mes2 BYTE  "Feb 2022:", 0
    mes3 BYTE  "Mar 2022:", 0
    mes4 BYTE  "Abr 2022:", 0
    mes5 BYTE  "May 2022:", 0
    mes6 BYTE  "Jun 2022:", 0
    mes7 BYTE  "Jul 2022:", 0
    mes8 BYTE  "Ago 2022:", 0
    mes9 BYTE  "Sep 2022:", 0
    mes10 BYTE "Oct 2022:", 0
    mes11 BYTE "Nov 2022:", 0
	mes12 BYTE "Dic 2022:", 0
	

    meses DWORD mes1,mes2, mes3, mes4, mes5, mes6, mes7, mes8, mes9, mes10, mes11, mes12
	montos DWORD 0,0,0,0,0,0,0,0,0,0,0,0
	isr DWORD 0,0,0,0,0,0,0,0,0,0,0,0
	
	;formatos
	fmt db "%s ",0
	fmt2 db "%d",0Ah,0

.code
    includelib libucrt.lib
    includelib legacy_stdio_definitions.lib
    includelib libcmt.lib
    includelib libvcruntime.lib

    extrn printf:near
    extrn scanf:near
    extrn exit:near

public main
main proc
    mov esi,0
lector:

    push offset ingresar_montos
    call printf
    mov ebx,meses[esi*4]
    push ebx
    push offset fmt
    call printf

    lea eax,pivote
    push eax
    push offset fmt2
    call scanf
    mov eax,pivote
    mov montos[esi*4],eax
    inc esi
    cmp esi,n
    jne lector
    push 0

    mov esi,0
imprimir:
    mov eax,montos[esi*4]
	push eax
	push offset fmt2
	call printf
    inc esi
    cmp esi,n
    jne imprimir
    push 0

    mov esi,0
    mov ebx,0
calculadora:
    mov eax,montos[esi*4]
    add ebx,eax ;sumamos todos los montos
    ;OPERAMOS
    imul eax,5
    mov ecx, 100
    cdq
    idiv ecx      
    mov isr[esi*4],eax
    inc esi
    cmp esi,n
    jne calculadora
    mov monto_anual,ebx ; lo movemos a nuestra variable
    push 0

    mov esi,0
imprimir2:
    mov eax,isr[esi*4]
	push eax
	push offset fmt2
	call printf
    inc esi
    cmp esi,n
    jne imprimir2
    push 0

    mov eax,monto_anual
    push eax
    push offset fmt2
    call printf


;COMPARAREMOS EN QUE REGIME ESTA
    cmp eax, 150000
    ja lp1
    jnae lp2


lp1: 
    mov eax,0
    mov eax,monto_anual
    push eax
    push offset adv2
    call printf
    call exit
lp2:
    mov eax,0
    mov eax,monto_anual
    push eax
    push offset adv1
    call printf
    call exit

    

main endp
end