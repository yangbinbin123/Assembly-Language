;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; National Chiao Tung University
; Department Of Computer Science
; 
; Assembly Programming Tests
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Write programs in the Release mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; $Student Name: YANG LINBIN
; $Student ID: 0540137
; $Student Email: 2830406835@qq.com
;
; Instructor Name: Sai-Keung Wong 
;
TITLE 
include Irvine32.inc
include Macros.inc
.data
MSG1 BYTE " MY STUDENT ID is: 0540137",0dh,0ah,0
MSG2 BYTE " PLEASE select one of the option",0dh,0ah,0
MSG3 BYTE " 1.Compute(1^2+2^2+3^2+...+n^2)/m",0dh,0ah,0
MSG4 BYTE " 2.Compute",0ah,0dh,0
MSG5 BYTE "   (1^2-2^2+3^2+...+(-1)^(n+1)n^2)*m",0dh,0ah,0
MSG6 BYTE " 3.ComputeS(n).",0dh,0ah,0
MSG7 BYTE "  Define S(n)=1 + S(n-1) + S(n-2),",0ah,0dh,0
MSG8 BYTE "  n>=2. S(0)=1,S(1)=1.5",0dh,0ah,0
MSG9 BYTE " 4.Quit program",0ah,0dh,0
MSG10 BYTE  "Please enter an option.......",0

MSG11 BYTE "2.Compute (1^2-2^2+3^2+...+(-1)^(n+1)n^2)*m",0
counter BYTE 49

frame_x BYTE 0
frame_y BYTE 0

m DWORD ?
n DWORD ?
result DWORD ?
i DWORD ?
pc DWORD 1
Sresult Real8 0.0
S1 Real8 1.0
S2 Real8 1.5
j DWORD 2
temp Real8 1.0
zero real8 0.0
S1_t real8 1.0
S2_t real8 1.5
.code

GreenColor PROC
	mov eax,white + green * 16
	call SetTextColor
	ret
GreenColor ENDP

BlackColor PROC
	mov eax, white+black*16
	call SetTextColor
	ret
BlackColor ENDP

BlueBackWhiteFont PROC
	mov eax, white+blue*16
	call SetTextColor
	ret
BlueBackWhiteFont ENDP

ShowMsg PROC
	call BlueBackWhiteFont
	mov dl,2
	mov dh,2
	call GotoXY
	mov edx,OFFSET MSG1
	call WriteString

	mov dl,2
	mov dh,3
	call GotoXY
	mov edx,OFFSET MSG2
	call WriteString

	mov dl,2
	mov dh,4
	call GotoXY
	mov edx,OFFSET MSG3
	call WriteString

	mov dl,2
	mov dh,5
	call GotoXY
	mov edx,OFFSET MSG4
	call WriteString
	mov dl,2
	mov dh,6
	call GotoXY
	mov edx,OFFSET MSG5
	call WriteString

	mov dl,2
	mov dh,7
	call GotoXY
	mov edx,OFFSET MSG6
	call WriteString

	mov dl,2
	mov dh,8
	call GotoXY
	mov edx,OFFSET MSG7
	call WriteString

	mov dl,2
	mov dh,9
	call GotoXY
	mov edx,OFFSET MSG8
	call WriteString

	mov dl,2
	mov dh,10
	call GotoXY
	mov edx,OFFSET MSG9
	call WriteString

	mov dl,2
	mov dh,11
	call GotoXY
	mov edx,OFFSET MSG10
	call WriteString
	ret
ShowMsg ENDP

DrawFrame PROC
	mov ecx,50
	mov dl,frame_x
	mov dh,frame_y
	call GotoXY
L1:
	call GreenColor
	mov al,' '
	call WriteChar
	inc dl
	call GotoXY
	loop L1

	xor ecx,ecx
	mov ecx,15

L2:
	call GreenColor
	mov al,' '
	call WriteChar
	inc dh
	call GotoXY
	loop L2

	xor ecx,ecx
	mov ecx,50

L3:
	call GreenColor
	mov al,' '
	call WriteChar
	dec dl
	call GotoXY
	loop L3

	xor ecx,ecx
	mov ecx,15

L4:
	call GreenColor
	mov al,' '
	call WriteChar
	dec dh
	call GotoXY
	loop L4

	ret
DrawFrame ENDP

PictureItBlue PROC
	mov ecx,14
	mov dl,1
	mov dh,1
	call GotoXY
L1:
	dec counter
	mov al,' '
	call BlueBackWhiteFont
	call WriteChar
	cmp counter, 0
	je L2
	jmp L3
L2:
	mov counter,49
	mov dl,1
	inc dh
	call GotoXY
	jmp L4
L3:
	inc dl
	call GotoXY
	jmp L1
L4:
	loop L1
	ret
PictureItBlue ENDP

Model1 PROC
	call Clrscr
	mov edx, OFFSET MSG3
	call WriteString
	call Crlf
	mwrite "Please Input n [0,100]:"
	call ReadInt
	cmp eax,0
	je quit
	cmp eax,100
	jnl L1
	mov n,eax
	jmp L2
L1:
	call Clrscr
	mwrite "This integer n is not less than 100, We will return in 2 seconds!"
	mov eax,2000
	call Delay
	call Model1
L2:
	mwrite "Input m(non-zero,signed integer):"
	call ReadInt
	cmp eax,0
	JG L3
L3:
	mov m,eax
	call ArithUnit
	mov eax,2000
	call Delay
	call Model1
quit:
	call MainCommand 
	ret
Model1 ENDP

Model2 PROC
	call Clrscr
	mov edx,OFFSET MSG11
	call WriteString
	call Crlf
	mwrite "Please input n [0,50]:"
	call ReadInt
	cmp eax,0
	jl L1
	je quit
	cmp eax,50
	jg L1
	mov n,eax
	jmp L2
L1:
	mwrite "I am sorry, the integer you input is greater than 50 or below 0!"
	mov eax,2000
	call Delay
	call Model2
L2:
	call Crlf
	mwrite "Input m (non-zero,signed integer):"
	call ReadInt
	cmp eax,0
	jg L3
L3:
	mov m,eax
	call ArithUnit2
	mov eax,2000
	call delay
	call Model2
quit:
	call MainCommand 
	ret
Model2 ENDP

Model3 PROC
	call Clrscr
	mov edx,OFFSET MSG6
	call WriteString
	call Crlf
	mov edx,OFFSET MSG7
	call WriteString
	call Crlf
	mov edx,OFFSET MSG8
	call WriteString
	call Crlf
	mwrite "Please input n:"
	call ReadInt
	cmp eax,0
	jg L1
	je quit
L1:
	finit
	fld S1
	fld S2
	fld Sresult
	call ShowFPUStack
	mov m,eax
	.IF m == 1
		mwrite "1.0"
		mov eax,2000
		call Delay
		call Clrscr
		call Model3
	.ENDIF
	.IF m == 2
        mwrite "1.5"
		mov eax,2000
		call Delay
		call Clrscr
		call Model3
	.ENDIF
	mov eax,m
	sub eax,j
	mov ecx,eax
L2:
	fstp Sresult
	fstp S2
	fstp S1
	fld Sresult
	fadd S1
	fadd S2
	fadd temp
	fstp Sresult
	fld S2
	fld Sresult
	fstp S2
	fstp S1
	fstp Sresult
	fld zero
	fstp Sresult
	fld S1
	fld S2
	fld Sresult
	loop L2

	fstp Sresult
	call WriteFloat
	mov eax,2000
	call Delay
	call Clrscr
	fstp S2
	fstp S1
	fld S1_t
	fld S2_t
	fstp S2
	fstp S1
	call Model3
quit:
	call MainCommand 
	ret
Model3 ENDP

Model4 PROC
	call Clrscr
	mwrite "Thanks for playing this system."
	call Crlf
	mwrite "This program is written by"
	call Crlf
	mwrite "  Name: YANG LINBIN"
	call Crlf
	mwrite "  ID: 0540137"
	call Crlf
	mwrite "I am learning assembly programming."
	call Crlf
	mwrite "Please contact me at 2830406835@email."
	call Crlf
	mwrite "Press Enter to quit"
	ret
Model4 ENDP

ArithUnit2 PROC
	mov result,0
	mov ecx,n
	mov i,1
	L1:
		mov eax,i
		mul i
		.IF pc == 1
			mov pc,0
		.ELSE
			mov pc,1
			neg eax
		.ENDIF

		add result,eax
		inc i
	loop L1
	mov eax,result
	mul m
	call WriteInt
	ret
ArithUnit2 ENDP

ArithUnit PROC
	mov result,0
	mov ecx,n
	mov i,1
	L1:
		mov eax,i
		mul i
		add result,eax
		inc i
	loop L1
	mov eax,result
	div m
	call WriteInt
	ret
ArithUnit ENDP

MainCommand PROC
	call Clrscr
	call PictureItBlue
	call ShowMsg
	call DrawFrame
	call BlackColor
	mov dl, 0
    mov dh, 17
    call GotoXY
    mwrite "Note: When you test each module, you should wait 2 seconds"
    call Crlf
	mwrite "for next loop and enter 0 to return main Screen"
	call Crlf
    mwrite "Hope you enjoy my program!"
L1:
	call ReadKey
	jnz L2
	jmp L1
L2:
	cmp al, '1'
	jne L3
	call Model1
L3:
	cmp al, '2'
	jne L4
	call Model2
L4:
	cmp al, '3'
	jne L5
	call Model3
L5:
	cmp al, '4'
	jne L6
	call Model4
	jmp L7
	loop L1
L6:
	call MainCommand
L7:
	ret
MainCommand ENDP

main PROC
   call MainCommand
   call BlackColor
   call Crlf
   exit
main ENDP

END main
