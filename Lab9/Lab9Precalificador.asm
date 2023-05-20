; Universidad del Valle de Guatemala
; Mathew Cordero, 22982 - Jose de Leon,  22809 Grupo 4
; Descripcion:
; El programa realiza una inspeccion de los impuestos ISR a tributar y el regimen para el proximo año fiscal
; 20/05/2023

.386
.model flat, stdcall, c
.stack 4096

ExitProcess proto,dwExitCode:dword

.data
	ingresar_montos byte "Ingrese el monto del mes ",0

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
	
	;Montos
	mt1 DWORD ?
	mt2 DWORD ?
	mt3 DWORD ?
	mt4 DWORD ?
	mt5 DWORD ?
	mt6 DWORD ?
	mt7 DWORD ?
	mt8 DWORD ?
	mt9 DWORD ?
	mt10 DWORD ?
	mt11 DWORD ?
	mt12 DWORD ?

    meses DWORD mes1,mes2, mes3, mes4, mes5, mes6, mes7, mes8, mes9, mes10, mes11, mes12
	montos DWORD mt1,mt2,mt3,mt4,mt5,mt6,mt7,mt8,mt9,mt10,mt11,mt12
	
	fmt db "%s ",0Ah,0
	fmt2 db "%d", 0AH, 0
	msg1 db "El array contiene los siguientes elementos:",0AH, 0
	msg2 db "Fin del array",0AH, 0

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
	push offset msg1	; Guarda en pila el valor de dirección inicial de msg1
	call printf			; Llamado a printf

	mov esi, offset meses
	mov ebx, sizeof	meses

label1:
	mov eax, [esi]		; DIRECCIONAM. INDIRECTO: Cargar el valor del i-esimo elem de array a eax 
	push eax			; Pasar valor a pila p/imprimir
	push offset fmt		; Pasar formato 
	call printf

	sub ebx, 4			; Decrementar "contador"
	add esi, 4			; Moverse al sig. elem. del array
	cmp ebx,0			; Aún hay elementos en el array?
	jne label1			; Sí, entonces repetir proceso desde label1

	push offset msg2	; Guarda en pila el valor de dirección inicial de msg2
	call printf			; Llamado a printf

	push 0

	mov esi, offset montos
	mov ebx, sizeof montos

lector:
	push offset ingresar_montos
    call printf  
	

	mov eax,[esi-4]
    push eax            
    push offset fmt2    
    call scanf 

	sub ebx, 4
	add esi,4
	cmp ebx,0
	jne lector
	push 0

	
	mov eax,mt2
	push eax
	push offset fmt2
    call printf  

    call exit           


main endp
end