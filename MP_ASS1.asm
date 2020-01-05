
		

%macro 	Print		2

	
		 
	MOV	 RAX,1
	MOV	 RDI,1
	MOV	 RSI,%1
	MOV	 RDX,%2
	syscall
%endmacro

%macro	Exit		0	
	Print nline,nlinelen			
	mov RAX,60
	mov RDI,0
	syscall
%endmacro


Display :
	
		mov		rbx,16
		mov		rcx,2
		mov		rsi,	char_no+1

	back1:
			mov 	rdx,0
			div 	rbx
			CMP	dl,09h
			JBE	add30
			add	dl,07H

	add30:
			add	dl,30H
			mov	[rsi],dl
			dec	rsi
			dec	rcx
			jnz	back1
			Print	char_no,2
	ret	
;..........................................................................

section 		.data

	ano 		DB	"ASS NO1 ",10
			DB	"Count no of POS and NEG NO."	,10
			DB	"SECOB274::"		
	anolen 	EQU	$-ano

	arr64		DQ	-11h,22h,33h
	n		EQU	3

	pmsg		DB 	"count pos no::"
	pmsglen	EQU	$-pmsg
	
	nmsg		DB 	"count neg no::"
	nmsglen	EQU	$-nmsg

	nline		DB	10,10
	nlinelen	EQU	$-nline
	
;................................................................
section .bss
	p_count 	resq		1
	n_count	resq		1
	char_no	resb		2
;.................................................................

section 		.txt
global		 _start
_start :
		Print 	nline,nlinelen
	Print ano,anolen
	

	MOV	 RAX,0
	MOV	 RCX,0
	MOV	 RBX,0
	MOV	 RDX,0

	MOV	 RSI,arr64
	MOV	 RCX,n

	BACK		:	MOV	 RAX,[RSI]
				BT 	 RAX,63
				JC   	 negative	
				INC	 RBX
				JMP	next

	negative	:	INC RDX
	
	next		:	ADD 	RSI,8
				DEC 	RCX
				JNZ BACK
	
	

	
	mov 		[p_count],rbx
	mov		[n_count],rdx
	Print 	nline,nlinelen
	Print		pmsg,pmsglen
	mov		rax,[p_count]
	call 		Display

	Print 	nline,nlinelen
	Print 	nmsg,nmsglen
	mov		rax,[n_count]
	call 		Display


	Exit	
;.................................................................
