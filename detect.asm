; ssb/detect.asm
; PT: funções em Assembly para detecção das informações do hardware
[BITS 16]
; ---------------------------------------------------------------------------------------------------------------------------
; PT: ficheiros com as configurações
%include "../config.inc.asm"
; ===========================================================================================================================
; PT: secção de código
; ===========================================================================================================================
[SECTION .text]
; PT: é nesta secção que se coloca o código executável - as instruções e as funções
; ---------------------------------------------------------------------------------------------------------------------------
; PT: esta função devolve o stack segment
[GLOBAL get_stacksegment]
get_stacksegment:
  ; PT: esta função não altera nenhum registo excepto o ax, que é o registo em que o C/C++ espera os resultados
  ; PT: por esse motivo não é preciso guardar registos na stack nem criar uma stack frame com enter e leave
  mov ax, ss
  ret
; ---------------------------------------------------------------------------------------------------------------------------
; PT: esta função devolve o data segment
[GLOBAL get_datasegment]
get_datasegment:
  ; PT: preencher aqui
  mov ax, ds
  ret
; ---------------------------------------------------------------------------------------------------------------------------
; PT: esta função devolve o code segment
[GLOBAL get_codesegment]
get_codesegment:
  ; PT: preencher aqui
  mov ax, cs
  ret
; ---------------------------------------------------------------------------------------------------------------------------
; PT: esta função devolve o número de discos
[GLOBAL get_diskcount]
get_diskcount:
  
  push ds
  mov ax,0x40 ; puxa o segmento 40 bios 
  mov ds, ax  ; envia o valor para o ds
  mov al, [0x75] ;copia o byte  que esta no 75 para o al
  pop ds
  ret
; ---------------------------------------------------------------------------------------------------------------------------
; PT: esta função devolve o disk size
[GLOBAL get_disksize]
get_disksize:
  enter 0,0        ; posiçao inicial
  push si
  mov si, EDP      ; atribuir os valores do  EDP  ao si
  mov ah, 0x48     ; Ah = 48 - chamar a funçao da bios 
  mov dx, [bp + 6] ; bp + 6,  uma vez que os parametros estao na posiçao 6 
  int 0x13
  mov eax, [EDP.sector]
  mov edx, [EDP.sector + 4] ; aplica-se porque o valor é superior 16 bits(necessario 64 bits)
  pop si
  leave
  ret
; ---------------------------------------------------------------------------------------------------------------------------
; PT: esta função devolve o total da memoria
[GLOBAL get_totalmem]
get_totalmem:
  push es
  push di
  push ecx
  push ebx	
  mov eax, 0xe820
  mov edx, 0x0534D4150 ; numero hex representa o SMAP
  xor ebx,ebx
  mov ecx, 24  ; tamanho da mensagem
  ;mov [es:di], dword
  int 0x15
  
  ; PT: preencher aqui 
  ret
; ---------------------------------------------------------------------------------------------------------------------------
; PT: esta função devolve o code segment
[GLOBAL get_date]
get_date:
	push cx
	push dx
	mov ah,04h ;function 04h (get RTC date)
	int 1Ah ;BIOS Interrupt 1Ah (Read Real Time Clock)
	
	;CH - Century
	;CL - Year
	;DH - Month
	;DL - Day
.cvtday:
	mov al,dl ;copy contents of day (dl) to al
	shr al,4
	add al,30h ;add 30h to convert to ascii
	mov [Date.day],al
	mov al,dl
	and al,0fh 
	add al,30h
	mov [Date.day + 1],al
.cvtmo:
;Converts the system date from BCD to ASCII
	mov al,dh ;copy contents of month (dh) to al
	shr al,4
	add al,30h ;add 30h to convert to ascii
	mov [Date.month],al
	mov al,dh
	and al,0fh
	add al,30h
	mov [Date.month + 1],al
.cvtcent:
	mov al,ch ;copy contents of century (ch) to al
	shr al,4
	add al,30h ;add 30h to convert to ascii
	mov [Date.year],al
	mov al,ch
	and al,0fh
	add al,30h
	mov [Date.year + 1],al
	mov al,cl ;copy contents of year (cl) to al
	shr al,4
	add al,30h ;add 30h to convert to ascii
	mov [Date.year + 2],al
	mov al,cl
	and al,0fh
	add al,30h
	mov [Date.year + 3],al
		
	mov ax, Date
	pop dx	
	pop cx
	ret
; ---------------------------------------------------------------------------------------------------------------------------
; PT: esta função devolve o get time
[GLOBAL get_time]
get_time:
;Get time from the system
	push cx
	push dx
	mov ah,02h
	int 1Ah
;	CH - Hours
	;CL - Minutes
	;DH - Seconds
.cvthrs:
;Converts the system time from BCD to ASCII
	mov al,ch ;copy contents of hours (ch) to bh
	shr al,4
	add al,30h ;add 30h to convert to ascii
	mov [Time.hour],al
	mov al,ch
	and al,0fh
	add al,30h
	mov [Time.hour + 1],al
	
.cvtmin:
	mov al,cl ;copy contents of minutes (cl) to bh
	shr al,4
	add al,30h ;add 30h to convert to ascii
	mov [Time.min],al
	mov al,cl
	and al,0fh
	add al,30h
	mov [Time.min + 1],al
	
.cvtsec:
	mov al,dh ;copy contents of seconds (dh) to bh
	shr al,4
	add al,30h ;add 30h to convert to ascii
	mov [Time.sec],al
	mov al,dh
	and al,0fh
	add al,30h
	mov [Time.sec + 1],al
	
	mov ax,Time
	pop dx	
	pop cx
	ret
; ===========================================================================================================================
; PT: secção de dados
; ===========================================================================================================================
[SECTION .data]
; PT é nesta secção que se coloca os dados estáticos
EDP:
.size	 dw  0x1e
.flag    dw  0
.cyl	 dd	 0
.head 	 dd  0
.sectort dd  0
.sector  dq  0
.bps     dw  0
.opt     dd  0
RAM:
.baseaddr dq 0
.lenlow   dd 0
.lenhigh  dd 0
.type     dd 0
.acpi     dd 0 
Date: 
.day db '00/'
.month db '00/'
.year db '0000'	, 0
Time:
.hour db '00:'
.min db	'00:'
.sec db '00' , 0