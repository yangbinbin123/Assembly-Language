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
frame_x BYTE 0
frame_y BYTE 0
position_x BYTE 1
position_y BYTE 16
width_array DWORD ?
quit_flag DWORD 1
zheng BYTE 1
type_map DWORD 0
counter DWORD 1
MYBITMAP1 BYTE 1,0,0,0,1,
			   1,1,0,1,1,
			   0,0,1,0,0,
			   1,1,0,1,1

MYBITMAP2 BYTE 1,1,1,1,1,
			   0,1,0,1,0,
			   1,1,1,1,1,
			   0,1,0,1,0

menu BYTE "************Author Information************",0dh,0ah,0dh,0ah,
		"Student Name:YANG LINBIN",0dh,0ah,
		"Student ID: 0540137",0
.code

BlueColor PROC
	mov eax,black+blue*16
	call SetTextColor
	ret
BlueColor ENDP

YellowColor PROC
	mov eax,black+yellow*16
	call SetTextColor
	ret
YellowColor ENDP

BlackColor PROC
	mov eax,white+16*black
	call SetTextColor
	ret
BlackColor ENDP

WhiteColor PROC
	mov eax, white+16*white
	call SetTextColor
	ret
WhiteColor ENDP

GreenColor PROC
	mov eax,green+16*green
	call SetTextColor
	ret
GreenColor ENDP

DrawFrame PROC
	mov ecx,60
	mov dl,0
	mov dh,0
	call GotoXY

L1:
	mov al,' '
	call BlueColor
	call WriteChar
	inc dl
	call GotoXY
	loop L1
	xor ecx,ecx
	mov ecx,20

L2:
	mov al,' '
	call BlueColor
	call WriteChar
	inc dh
	call GotoXY
	loop L2

	xor ecx,ecx
	mov ecx,60

L3:
	mov al,' '
	call BlueColor
	call WriteChar
	dec dl
	call GotoXY
	loop L3

	xor ecx,ecx
	mov ecx,20
L4:
	mov al, ' '
	call BlueColor
	call WriteChar
	dec dh
	call GotoXY
	loop L4
	ret
DrawFrame ENDP


FirstBitMap PROC
	mov dl,position_x
	mov dh,position_y
	call GotoXY
	cmp type_map,1
	je type_f
	mov esi, OFFSET MYBITMAP2
	mov ecx, LENGTHOF MYBITMAP2
	jmp common_type
type_f:
	mov esi, OFFSET MYBITMAP1
	mov ecx, LENGTHOF MYBITMAP1
common_type:
	mov width_array,5
L1:
	cmp width_array,0
	je L3
	mov al,[esi]
	cmp al,1
	je L2
	call BlackColor
	mwrite " "
	inc dl
	call GotoXY
	inc esi
	dec width_array
	jmp nextloop
L2:
	cmp counter,1
	je Action_1
	cmp counter,2
	je Action_2
	cmp counter,3
	je Action_3
Action_1:
	call YellowColor
	jmp Action_com
Action_2:
	call BlueColor
	jmp Action_com
Action_3:
	call GreenColor
Action_com:
	call OutTemp
	jmp nextloop
L3:
	mov width_array,5
	inc dh
	mov dl,position_x
	call GotoXY
	jmp L1
nextloop:
	loop L1
quit:
	call blackColor
	ret
FirstBitMap ENDP

OutTemp PROC
	mwrite " "
	inc dl
	call GotoXY
	inc esi
	dec width_array
	ret
OutTemp ENDP

ShowMsg PROC
	call Clrscr
	mov edx,OFFSET menu
	call WriteString
	call Crlf
	exit
ShowMsg ENDP

commandControl PROC
againput:
	call ReadKey
	jnz L1
	jmp againput
L1:
	cmp al,'r'
	jne L2
	dec position_y
	cmp position_y,0
	jne L1A
	inc position_y
	call Clrscr
	call DrawFrame
	call FirstBitMap
	call CommandControl
L1A:
	call Clrscr
	call DrawFrame
	call FirstBitMap
	call commandControl
L2:
	cmp al,'f'
	jne L3
	inc position_y
	cmp position_y,17
	jne L2A
	dec position_y
	call Clrscr
	call DrawFrame
	call FirstBitMap
	call CommandControl
L2A:
	call Clrscr
	call DrawFrame
	call FirstBitMap
	call commandControl
L3:
	cmp al,'d'
	jne L4
	dec position_x
	cmp position_x,0
	jne L3A
	inc position_x
	call Clrscr
	call DrawFrame
	call FirstBitMap
	call commandControl
L3A:
	call Clrscr
	call DrawFrame
	call FirstBitMap
	call commandControl
L4:
	cmp al,'g'
	jne L5
	inc position_x
	cmp position_x,56
	jne L4A
	dec position_x
	call Clrscr
	call DrawFrame
	call FirstBitMap
	call CommandControl
L4A:
	call Clrscr
	call DrawFrame
	call FirstBitMap
	call commandControl
L5:
	cmp al,32
	jne L6
	.IF type_map == 1
		mov type_map,0
	.ELSE
		mov type_map,1
	.ENDIF
	call Clrscr
	call DrawFrame
	call FirstBitMap
	call commandControl
L6:
	cmp al,'c'
	jne L7
	cmp counter,3
	jne L6A
	mov counter,1
	call DrawFrame
	call FirstBitMap
	call commandControl
L6A:
	inc counter
	call DrawFrame
	call FirstBitMap
	call commandControl
L7:
	cmp al,27
	jne L8
	call ShowMsg  
L8:
	cmp al,'b'
	jne L9
	mov type_map,1
	call BlackColor
	call Clrscr
	call DrawFrame
	call FirstBitMap
	call commandControl
L9:
	call commandControl
	ret
commandControl ENDP

main PROC
	call DrawFrame
	call CommandControl
	call BlackColor
	exit
main ENDP

END main
