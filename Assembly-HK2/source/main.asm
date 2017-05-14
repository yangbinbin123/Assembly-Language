TITLE This is Bean Homework 2
; 
;
;========================================================
; Student Name:YANGLINBIN(杨林彬)
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
; Revision date:2017/4/2

include Irvine32.inc
include Macros.inc

.data
avatarX BYTE 1
avatarY BYTE 1

avatarX_Old BYTE 1
avatarY_Old BYTE 1

DirectionFlag BYTE 1
JumpCounter BYTE 0

msg1 BYTE " 1) Change ship color",0dh,0ah,0dh,0ah,
          "  2) Show a frame around the screen rectangular area",0dh,0ah,0dh,0ah,
          "  3) Play now!!!",0dh,0ah,0dh,0ah,
          "  4) Show author information",0dh,0ah,0dh,0ah,
		  "  5) Quit game",0dh,0ah,0dh,0ah,
		  "  Please enter an option......",0dh,0ah,0dh,0ah,0
msg7 BYTE "Please select a color for the space ship",0dh,0ah,0dh,0ah,0

msg8 BYTE "  Student ID: 0540137",0dh,0ah,0dh,0ah,
		  "  Student Name: YANG LINBIN",0dh,0ah,0dh,0ah,
		  "  Student Email Address: 2830406835@qq.com",0dh,0ah,0dh,0ah,
		  "  >>>>>>>>>>>>>>>>>PRESS ESCAPE TO RETURN>>>>>>>>>>>>>>>>>",0dh,0ah,0dh,0ah,0

$sound BYTE 7,0
ColorType DWORD 1
position_x BYTE 0
position_y BYTE 0
pc_state DWORD 1
pc_counter DWORD 0
littleworm BYTE 1,1,1,1
choose_result DWORD 1      ; 1-BLUE 2-GREEN 3-YELLOW
.code


BlackColor PROC
	mov eax, white+black*16
	call SetTextColor
	ret
BlackColor ENDP

YellowColor PROC
	mov eax, yellow +yellow*16
	call SetTextColor
	ret
YellowColor ENDP

BlueColor PROC
	mov eax, blue+blue*16
	call SetTextColor
	ret
BlueColor ENDP

GreenColor PROC
	mov eax, green+green*16
	call SetTextColor
	ret
GreenColor ENDP

DelayTime PROC
	mov eax,50
	call Delay
	ret
DelayTime ENDP

MainScreen PROC
	mov dl,1
	mov dh,1
	call GotoXY
	mov edx,OFFSET msg1
	call WriteString

	mov dl,position_x
	mov dh,position_y
	call GotoXY

	mov ecx,60
L1:
	call GotoXY
	call YellowColor
	mov al, ' '
	call WriteChar
	inc dl
	loop L1
	
	dec dl
	xor ecx,ecx
	mov ecx,13
L2:
	call GotoXY
	call YellowColor
	mov al,' '
	call WriteChar
	inc dh
	loop L2

	dec dh
	xor ecx,ecx
	mov ecx,60
L3:
	call GotoXY
	call YellowColor
	mov al,' '
	call WriteChar
	dec dl
	loop L3

	inc dl
	xor ecx,ecx
	mov ecx,13
L4:
	call GotoXY
	call YellowColor
	mov al,' '
	call WriteChar
	dec dh
	loop L4
	ret
MainScreen ENDP

Model2 PROC
	call Clrscr
	mov dl,0
	mov dh,0
	call GotoXY

	cmp ColorType,1
	je C1
	cmp ColorType,2
	je C2
	cmp ColorType,3
	je C3
C1:
	call BlueColor
	jmp Start
C2:
	call GreenColor
	jmp Start
C3:
	call YellowColor
	jmp Start
Start:
	mov ecx,80
L1:
	call GotoXY
	mov al, ' '
	call WriteChar
	inc dl
	call DelayTime
	loop L1
	
	dec dl
	xor ecx,ecx
	mov ecx,22
L2:
	call GotoXY
	mov al,' '
	call WriteChar
	inc dh
	call DelayTime
	loop L2

	dec dh
	xor ecx,ecx
	mov ecx,80
L3:
	call GotoXY
	mov al,' '
	call WriteChar
	dec dl
	call DelayTime
	loop L3

	inc dl
	xor ecx,ecx
	mov ecx,22
L4:
	call GotoXY
	mov al,' '
	call WriteChar
	call DelayTime
	dec dh
	loop L4

	mov dl, 17
	mov dh, 11
	call GotoXY
	call BlackColor
	mwrite ">>>>>>>>>>>>>>PRESS ESCAPE TO RETURN>>>>>>>>>>>>>>"
L5:
	call ReadKey
	jnz L6
	jmp L5
L6:
	ret
Model2 ENDP

DrawFrame PROC
	mov dl,0
	mov dh,0
	call GotoXY
	cmp ColorType,1
	je C1
	cmp ColorType,2
	je C2
	cmp ColorType,3
	je C3
C1:
	call BlueColor
	jmp Start
C2:
	call GreenColor
	jmp Start
C3:
	call YellowColor
	jmp Start
Start:
	mov ecx,80
L1:
	call GotoXY
	mov al, ' '
	call WriteChar
	inc dl
	loop L1
	
	dec dl
	xor ecx,ecx
	mov ecx,22
L2:
	call GotoXY
	mov al,' '
	call WriteChar
	inc dh
	loop L2

	dec dh
	xor ecx,ecx
	mov ecx,80
L3:
	call GotoXY
	mov al,' '
	call WriteChar
	dec dl
	loop L3

	inc dl
	xor ecx,ecx
	mov ecx,22
L4:
	call GotoXY
	mov al,' '
	call WriteChar
	dec dh
	loop L4
	ret
DrawFrame ENDP

ChangeSpaceShipColor PROC
	mov pc_counter, 0
	mov pc_state, 1
	mov ecx, 20
	L1: 
		inc pc_counter
		mov eax,pc_counter
		cmp eax,7
		je next
		cmp eax,14
		je next
	L2:
		cmp pc_state,1
		je L3
		cmp pc_state,2
		je L4
		cmp pc_state,3
		je L5
	L3:
		call TOBLUE
		jmp quit
	L4:
		call TOGREEN
		jmp quit
	L5:
		call TOYELLOW
		jmp quit
	next:
		inc pc_state
		mov eax,black+black*16
		call SetTextColor
		inc dl
	    call GotoXY
		mov al, ' '
		call WriteChar
	quit:
		loop L1
	ret
ChangeSpaceShipColor ENDP

TOBLUE PROC
	mov eax, white+blue*16
	call SetTextColor
	inc dl
	call GotoXY
	mov al, ' '
	call WriteChar
	ret
TOBLUE ENDP

TOYELLOW PROC
	mov eax, white+yellow*16
	call SetTextColor
	inc dl
	call GotoXY
	mov al, ' '
	call WriteChar
	ret
TOYELLOW ENDP

TOGREEN PROC
	mov eax, white+green*16
	call SetTextColor
	inc dl
	call GotoXY
	mov al, ' '
	call WriteChar
	ret
TOGREEN ENDP

Model1 PROC
	call Clrscr
	mov dl,22
	mov dh,0
	call GotoXY
	mov edx, OFFSET msg7
	call WriteString
	mov dl,29
	mov dh,2
	call GotoXY
	call ChangeSpaceShipColor
	mov dl,29
	mov dh,3
	call ChangeSpaceShipColor
	mov eax, white+black*16
	call SetTextColor

	mov dl,32
	mov dh,5
	call GotoXY
	mov eax,1
	call WriteDec

	mov dl,39
	mov dh,5
	call GotoXY
	mov eax,2
	call WriteDec

	mov dl,46
	mov dh,5
	call GotoXY
	mov eax,3
	call WriteDec
L1:
	call ReadKey
	jnz L2
	jmp L1
L2:
	cmp al,'1'
	jne L3
	mov ColorType,1
	call BlackColor
	mov eax,1000
	call Clrscr
	mov edx, offset $sound
	call WriteString
	mwrite ">>>>>>>>>>>>>>BLUE>>>>>>>>>>>>>>"
	call Delay
	ret
L3:
	cmp al,'2'
	jne L4
	mov ColorType,2
	call BlackColor
	mov eax,1000
	call Clrscr
	mov edx, offset $sound
	call WriteString
	mwrite ">>>>>>>>>>>>>>GREEN>>>>>>>>>>>>>>"
	call Delay
	ret
L4:
	cmp al,'3'
	jne L5
	mov ColorType,3
	call BlackColor
	mov eax,1000
	call Clrscr
	mov edx, offset $sound
	call WriteString
	mwrite ">>>>>>>>>>>>>>YEllOW>>>>>>>>>>>>>>"
	call Delay
	ret
L5:
	cmp al,27
	call BlackColor
	ret
	jne L6
L6:
	jmp L1
Model1 ENDP


TempCode1 PROC
	mov esi,OFFSET littleworm
	mov ecx,LENGTHOF littleworm
	cmp ColorType,1
	je C1
	cmp ColorType,2
	je C2
	cmp ColorType,3
	je C3
C1:
	call BlueColor
	jmp L1
C2:
	call GreenColor
	jmp L1
C3:
	call YellowColor
	jmp L1
L1:
	mov al,[esi]
	call WriteChar
	inc esi
	loop L1
	ret
TempCode1 ENDP

TempCode2 PROC
	mov esi,OFFSET littleworm
	mov ecx,LENGTHOF littleworm
L1:
	call BlackColor
	mov al,[esi]
	call WriteChar
	inc esi
	loop L1
	ret
TempCode2 ENDP

DrawWorm PROC
	mov dl,avatarX
	mov dh,avatarY
	call GotoXY
	call TempCode1
	ret
DrawWorm ENDP

DeleteOldWorm PROC
	mov dl,avatarX_Old
	mov dh,avatarY_Old
	call GotoXY
	call TempCode2
	ret
DeleteOldWorm ENDP

AutoWormRun PROC
L1:
	inc JumpCounter
	cmp JumpCounter,75
	je L2
	mov al,avatarX
	mov avatarX_Old,al
	mov al,DirectionFlag
	add avatarX,al
	jmp quit
L2:
	mov JumpCounter,0
	mov al,DirectionFlag
	neg al
	mov DirectionFlag,al
	jmp L1
quit:
	ret
AutoWormRun ENDP


Model3 PROC
	call Clrscr
	mov avatarY,1
	mov avatarY,1
	mov avatarX_Old,1
	mov avatarY_Old,1

	cmp ColorType,1
	je C1
	cmp ColorType,2
	je C2
	cmp ColorType,3
	je C3
C1:
	call BlueColor
	jmp Start
C2:
	call GreenColor
	jmp Start
C3:
	call YellowColor
	jmp Start

start:
	call DrawFrame
	call DrawWorm
L1:
	call ReadKey
	jnz L2
	jmp L1
L2:
	cmp al,'e'
	jne L3
	cmp avatarY,1
	jne L2A
	mov al,avatarY
	mov avatarY_Old,al
	call AutoWormRun
	call DeleteOldWorm
	call DrawWorm
	jmp L1
L2A:
	call AutoWormRun
	mov al,avatarY
	mov avatarY_Old,al
	dec avatarY
	call DeleteOldWorm
	call DrawWorm
	jmp L1
L3:
	cmp al,'c'
	jne L4
	cmp avatarY,20
	jne L3A
	mov al,avatarY
	mov avatarY_Old,al
	call AutoWormRun
	call DeleteOldWorm
	call DrawWorm
	jmp L1
L3A:
	call AutoWormRun
	mov al,avatarY
	mov avatarY_Old,al
	inc avatarY
	call DeleteOldWorm
	call DrawWorm
	jmp L1
L4:
	cmp al,27
	jne L5
	call BlackColor
	jmp quit
L5:
	jmp L1
quit:
	ret
Model3 ENDP

Model4 PROC
	call Clrscr
	mov edx,OFFSET msg8
	call WriteString
L1:
	call ReadKey
	jnz L2
	jmp L1
L2:
	cmp al,27
	jne L3
	jmp quit
L3:
	jmp L1
quit:
	ret
Model4 ENDP

Model5 PROC
	exit
	ret
Model5 ENDP

CommandControl PROC
	call Clrscr
	call MainScreen
	call BlackColor
	mov dh,15
	mov dl,1
	call GotoXY
	mwrite ">>>>>NOTE:YOU CAN PRESS ESCAPE TO RETURN TO MAIN MENU!!!!!>>>>>"
L1:
	call ReadKey
	jnz L2
	jmp L1
L2:
	cmp al,'1'
	jne L3
	call Model1
	call CommandControl
L3:
	cmp al, '2'
	jne L4
	call Model2
	call CommandControl
L4:
	cmp al, '3'
	jne L5
	call Model3
	call CommandControl
L5:
	cmp al, '4'
	jne L6
	call Model4
	call CommandControl
L6:
	cmp al, '5'
	jne L7
	call Clrscr
	call Model5
	call CommandControl
L7:
	jmp L1
	ret
CommandControl ENDP

main PROC
	call CommandControl
    exit
main ENDP

END main