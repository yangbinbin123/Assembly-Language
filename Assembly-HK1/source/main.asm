TITLE BEAN HOMEWORK 1						(main.asm)
; 
;This is the second version of my assignment
;I add a loop to it and reconstruct its frame to make it more clear
;I make more detailed notations to make my program easy to read
;
;========================================================
; Student Name:YANGLINBIN(ÑîÁÖ±ò)
; Student ID:0540137
; Email:2830406835@qq.com
;========================================================
; Instructor: Sai-Keung WONG
; Email: cswingo@cs.nctu.edu.tw
; Assembly Language 
; Date: 2017/02/21
;========================================================
; Description:
;
; 
; Compute PI use Taylor series
; Reference: http://en.wikipedia.org/wiki/Taylor_series
; 
; Revision date:2017/3/4

INCLUDE Irvine32.inc 
INCLUDE Macros.inc

.data
msg1 BYTE "Please input n which is the number of terms:",0   
FOUR DWORD 4
term DWORD ?
dblOne REAL8 1.0
dblThree REAL8 2.0
dblFour REAL8 1.0
result Real8 0.0
Initialize Real8 0.0
dblOut REAL8 ?
pc DWORD ?


.code

P1 PROC     
	mov ecx,term
	.IF ecx > 100000
		mov ecx,NULL
		mov ecx,100000
	.ENDIF

	finit
	mov pc,1
	fld dblOne
	fstp dblFour
	fld result
	fld dblOne

L1:
	fld dblFour         ;ST(0) 
	fmul dblThree       ;ST(0) * 2
	fsub dblOne         ;ST(0) * 2 - 1
	fstp dblOut         ;dblOut = 2*n - 1  ST(0)=1.0
	fdiv dblOut         ;ST(0)=1/(2*n-1)

	.IF pc == 1         ;EVEN NUMBER +
		mov pc,0
	.ELSE               ;ODD NUMBER -
		mov pc,1
		fchs 
	.ENDIF

	fstp dblOut         ;dblOut=ST(0) 
	fadd dblOut         ;add the operand to the result
	fld dblFour         ;put dblFour into position ST(0)
	fadd dblOne			;dblOne+dblFour
	fstp dblFour	    ;dblOne+dblFour=dblFour 
    fld  dblOne         ;initialize make ST(0)=1 ST(1)=result

Loop L1
	call Crlf
	fstp dblOne         ;Make ST(0)=result
	fimul FOUR
	mWrite "Pi is:"
	call WriteFloat     ;PRINT THE FINAL RESULT
	call Crlf
	fstp dblOut

	ret
P1 ENDP

main PROC
	call Clrscr
	mwrite "************************************"
	call Crlf
	mwrite "This is Mr.Bean's first homework"
	call Crlf
	mwrite "************************************"
	call Crlf
P3:
	mov edx,OFFSET msg1
	call WriteString
	call ReadInt
	mov term,eax
	cmp term,0
	jz P2
    call P1      ;IF TERM NOT EUQAL ZERO THEN JUMP TO P1
	loop P3
P2:
	exit
main ENDP

END main