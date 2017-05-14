TITLE HARD WORK HAHA
;========================================================
; Student Name: YANG LINBIN
; Student ID: 0540137
; Email: 2830406835@qq.com
;========================================================
; Instructor: Sai-Keung WONG
; Email: cswingo@cs.nctu.edu.tw
; Room: EC706
; Assembly Language 
;========================================================
; Description:
;
; IMPORTANT: always save EBX, EDI and ESI as their
; values are preserved by the callers in C calling convention.
;
INCLUDE Irvine32.inc
INCLUDE Macros.inc

invisibleObjX  TEXTEQU %(-100000)
invisibleObjY  TEXTEQU %(-100000)

MOVE_LEFT		= 0
MOVE_TOP		= 1
MOVE_RIGHT		= 2
MOVE_DOWN		= 3

STOP_KEY        = 32
P_KEY           = 112
R_KEY           = 114
C_KEY           = 99
L_KEY           = 108
MOVE_LEFT_KEY	= 97
MOVE_TOP_KEY    = 119
MOVE_RIGHT_KEY  = 100
MOVE_DOWN_KEY = 115

; PROTO C is to make agreement on calling convention for INVOKE

c_updatePositionsOfAllObjects PROTO C

.data 

MY_INFO_AT_TOP_BAR	BYTE "My Student Name: YANG LINBIN StudentID: 0540137",0 

MyMsg BYTE "WELCOME TO WONDERFUL WONDERFUL WORLD!!!!!!",0dh, 0ah 
	  BYTE "HOPE YOU ENJOY MY PROJECT!!!!!",0dh, 0ah, 0dh, 0ah
	  BYTE "***********SIMPLE GUIDE BOOK***********",0dh, 0ah
	  BYTE "a:left; d:right, w:up; s:down",0dh, 0ah
	  BYTE "p:rainbow color",0dh, 0ah
	  BYTE "r:random color",0dh, 0ah
	  BYTE "c:clear",0dh, 0ah
	  BYTE "v:save",0dh, 0ah
	  BYTE "l:load",0dh, 0ah
	  BYTE "left mouse button:set target",0dh, 0ah
	  BYTE "spacebar:toggle grow / not grow",0dh, 0ah
	  BYTE "ESC:quit the program",0dh, 0ah
	  BYTE "***************************************",0dh, 0ah,0
MSG1 BYTE "Please enter the speed of the sphere(1-200):",0
MSG2 BYTE "Please enter the lifecycle of the sphere(1-100):",0
CaptionString BYTE "Student Name: YANG LINBIN",0

MessageString BYTE "Welcome to Wonderful World", 0dh, 0ah, 0dh, 0ah
				BYTE "My Student ID is 0540137", 0dh, 0ah, 0dh, 0ah
				BYTE "My Email is: 2830406835@qq.com", 0dh, 0ah, 0dh, 0ah
			    BYTE "If there is any problem, feel free to contact me!", 0dh, 0ah, 0dh, 0ah, 0
CaptionString_EndingMessage BYTE "Student Name: YANG LINBIN",0
MessageString_EndingMessage BYTE "My Student ID is 0540137", 0dh, 0ah, 0dh, 0ah
							BYTE "My Email is: 2830406835@qq.com", 0dh, 0ah, 0dh, 0ah
						 	BYTE "再见，期待着下次的相见！", 0dh, 0ah, 0dh, 0ah, 0
windowWidth		DWORD 8000
windowHeight	DWORD 8000

scaleFactor	DWORD	128
canvasMinX	DWORD -4000
canvasMaxX	DWORD 4000
canvasMinY	DWORD -4000
canvasMaxY	DWORD 4000
;
particleRangeMinX REAL8 0.0
particleRangeMaxX REAL8 0.0
particleRangeMinY REAL8 0.0
particleRangeMaxY REAL8 0.0
;
particleSize DWORD  2
numParticles DWORD 20000
particleMaxSpeed DWORD 3

moveDirection	DWORD	1

flgQuit		DWORD	0
maxNumObjects	DWORD 512
numObjects	DWORD	300
objPosX		SDWORD	2048 DUP(0)
objPosY		SDWORD	2048 DUP(0)
objTypes	BYTE	2048 DUP(1)
objSpeedX	SDWORD	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20
			SDWORD	2048 DUP(?)
objSpeedY	SDWORD	2, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20
			SDWORD	2048 DUP(?)	
				
RainBowColor	DWORD	255, 0, 0
				DWORD	255, 165, 0
				DWORD	255, 255, 0
				DWORD	0, 255, 0
				DWORD	0, 127, 255
				DWORD	0, 0, 255
				DWORD	139, 0, 255	

objColor	DWORD	255, 0, 0
			DWORD	299*3 DUP(0)
DIGIT_MO_0		BYTE 0, 0, 1, 0dh
				BYTE 0, 0, 0, 0dh
				BYTE 0, 0, 0, 0dh
				BYTE 0, 0, 0, 0dh
				BYTE 0, 0, 0, 0ffh
DIGIT_MO_SIZE = ($-DIGIT_MO_0)				

offsetImage DWORD 0

openingMsg	BYTE	"This program shows the student ID using bitmap and manipulates images....", 0dh
			BYTE	"Great programming.", 0
movementDIR	BYTE 0
state		BYTE	0

imagePercentage DWORD	0

mImageStatus DWORD 0
mImagePtr0 BYTE 200000 DUP(?)
mImagePtr1 BYTE 200000 DUP(?)
mImagePtr2 BYTE 200000 DUP(?)
mTmpBuffer	BYTE 200000 DUP(?)
mImageWidth DWORD 0
mImageHeight DWORD 0
mBytesPerPixel DWORD 0
mImagePixelPointSize DWORD 6

counter DWORD  30
lifecycle DWORD 30
Speed DWORD 65
IdOfObject DWORD 0
LINBIN  DWORD 0
SUNSHINE DWORD 0
ColorType DWORD 0
temp DWORD 0
R_X DWORD ?
R_Y DWORD ?
flagV DWORD 0
divisor DWORD 7
stopflag DWORD 0
lflag DWORD 0
haha DWORD 0
mouseflag DWORD 0

Destination_X SDWORD 60000
Destination_Y SDWORD 60000
D_X REAL8 ?
D_Y REAL8 ?

Present_X SDWORD 0
Present_Y SDWORD 0

WidthOfPic REAL8 8.0
Canvas     REAL8 1000.0
Substrac   REAL8 50000.0

flagFin DWORD 0
flag1 DWORD 0
flag2 DWORD 0
flag3 DWORD 0
flag4 DWORD 0

CmpVar SDWORD ?
.code

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;void asm_ClearScreen()
;
;Clear the screen.
;We can set text color if you want.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
asm_ClearScreen PROC C
	mov al, 0
	mov ah, 0
	call SetTextColor
	call clrscr
	ret
asm_ClearScreen ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;void asm_ShowTitle()
;
;Show the title of the program
;at the beginning.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
asm_ShowTitle PROC C USES edx
	mov dx, 0
	call GotoXY
	xor eax, eax
	mov eax, red + 16*white
	call SetTextColor
	mov edx, offset MyMsg
	call WriteString
	ret
asm_ShowTitle ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;void asm_InitializeApp()
;
;This function is called
;at the beginning of the program.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
asm_InitializeApp PROC C USES ebx edi esi edx
	call AskForInput_Initialization
	call initGame
	ret
asm_InitializeApp ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;void asm_EndingMessage()
;
;This function is called
;when the program exits.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
asm_EndingMessage PROC C USES ebx edx
	mov ebx, OFFSET CaptionString_EndingMessage
	mov edx, OFFSET MessageString_EndingMessage
	call MsgBox
	mov eax, canvasMinX
	call WriteDec
	ret
asm_EndingMessage ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;void asm_updateSimulationNow()
;
;Update the simulation.
;For examples,
;we can update the positions of the objects.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
asm_updateSimulationNow PROC C USES edi esi ebx
	;
	call updateGame
	;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;DO NOT REMOVE THIS FOLLOWING LINE
	call c_updatePositionsOfAllObjects 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ret
asm_updateSimulationNow ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;void setCursor(int x, int y)
;
;Set the position of the cursor 
;in the console (text) window.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
setCursor PROC C USES edx,
	x:DWORD, y:DWORD
	mov edx, y
	shl edx, 8
	xor edx, x
	call Gotoxy
	ret
setCursor ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
asm_GetNumParticles PROC C
	mov eax, 10000
	ret
asm_GetNumParticles ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
asm_GetParticleMaxSpeed PROC C
	mov eax, particleMaxSpeed
	ret
asm_GetParticleMaxSpeed ENDP

;int asm_GetParticleSize()
;
;Return the particle size.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
asm_GetParticleSize PROC C
	;modify this procedure
	mov eax, 1
	ret
asm_GetParticleSize ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;void asm_handleMousePassiveEvent( int x, int y )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
asm_handleMousePassiveEvent PROC C USES eax ebx edx,
	x : DWORD, y : DWORD
	mov eax, x
	mWrite "x:"
	call WriteDec
	mWriteln " "
	mov eax, y
	mWrite "y:"
	call WriteDec
	mWriteln " "
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ret
asm_handleMousePassiveEvent ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;void asm_handleMouseEvent(int button, int status, int x, int y)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
asm_handleMouseEvent PROC C USES ebx,
	button : DWORD, status : DWORD, x : DWORD, y : DWORD
	cmp mouseflag,0
	jne L1
	mov mouseflag,1
	jmp L2
L1:
	mov mouseflag,0
L2:
	mWriteln "asm_handleMouseEvent"
	mov flagFin,1
	mov eax, button
	mWrite "button:"
	call WriteDec
	mWriteln " "
	mov eax, status
	mWrite "status:"
	call WriteDec
	mov eax, x
	mWrite "x:"
	call WriteInt
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	finit
	fld Canvas
	fimul x
	fdiv WidthOfPic
	fsub Substrac
	fistp Destination_X
	; mWriteln "***************Destination_X****************"
	; mov eax, Destination_X
	; call WriteInt
	; call Crlf
	; mwriteln "*******************************"
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov eax, y
	mWrite "y:"
	call WriteInt
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	finit
	fld Canvas
	fimul y
	fdiv WidthOfPic
	fstp D_Y
	fld Substrac
	fsub D_Y
	fistp Destination_Y
	; mWriteln "***************Destination_Y****************"
	; mov eax, Destination_Y
	; call WriteDec
	; call Crlf
	; mwriteln "*******************************"
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mWriteln " "
	mov eax, windowWidth
	mWrite "windowWidth:"
	call WriteDec
	mWriteln " "
	mov eax, windowHeight
	mWrite "windowHeight:"
	call WriteDec
	mWriteln " "
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ret
asm_handleMouseEvent ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;int asm_HandleKey(int key)
;
;Handle key events.
;Return 1 if the key has been handled.
;Return 0, otherwise.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
asm_HandleKey PROC C, 
	key : DWORD
	mov eax, key
	call WriteInt
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	cmp eax, MOVE_LEFT_KEY
	jne L1
	mov flagFin,0
	call moveLeft
	jmp exit0
L1:
	cmp eax, MOVE_RIGHT_KEY
	jne L2
	mov flagFin,0
	call moveRight
	jmp exit0
L2:
	cmp eax, MOVE_DOWN_KEY
	jne L3
	mov flagFin,0
	call moveDown
	jmp exit0
L3:
	cmp eax, MOVE_TOP_KEY
	jne L4
	mov flagFin,0
	call moveTop
	jmp exit0
L4:
	cmp eax, P_KEY
	jne L5
	mov ColorType, 1
	jmp exit0
L5:
	cmp eax, R_KEY
	jne L6
	mov ColorType, 0
	jmp exit0
L6:
	cmp eax, C_KEY
	jne L7
	cmp flagV,1
	jne L6A
	mov flagV,0
	jmp exit0
L6A:
	mov flagV,1
	jmp exit0
L7:
	cmp eax, STOP_KEY
	jne L8
	cmp stopflag,1
	jne L7A
	mov stopflag,0
	jmp exit0
L7A:
	mov stopflag,1
	jmp exit0
 L8:
 	cmp eax, L_KEY
 	jne L9
 	call loadData
L9:
exit0:
	mov eax, 0
	ret
asm_HandleKey ENDP

moveLeft PROC
	mov moveDirection, MOVE_LEFT
	ret
moveLeft ENDP

moveRight PROC
	mov moveDirection, MOVE_RIGHT
	ret
moveRight ENDP

moveDown PROC
	mov moveDirection, MOVE_DOWN
	ret
moveDown ENDP

moveTop PROC
	mov moveDirection, MOVE_TOP
	ret
moveTop ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;void asm_SetWindowDimension(int w, int h, int scaledWidth, int scaledHeight)
;
;w: window resolution (i.e. number of pixels) along the x-axis.
;h: window resolution (i.e. number of pixels) along the y-axis. 
;scaledWidth : scaled up width
;scaledHeight : scaled up height
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
asm_SetWindowDimension PROC C USES ebx,
	w: DWORD, h: DWORD, scaledWidth : DWORD, scaledHeight : DWORD
	mov ebx, offset windowWidth
	mov eax, w
	mov [ebx], eax
	mov eax, scaledWidth
	shr eax, 1	; divide by 2, i.e. eax = eax/2
	mov ebx, offset canvasMaxX
	mov [ebx], eax
	neg eax
	mov ebx, offset canvasMinX
	mov [ebx], eax
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov ebx, offset windowHeight
	mov eax, h
	mov [ebx], eax
	mov eax, scaledHeight
	shr eax, 1	; divide by 2, i.e. eax = eax/2
	mov ebx, offset canvasMaxY
	mov [ebx], eax
	neg eax
	mov ebx, offset canvasMinY
	mov [ebx], eax
	;
	finit
	fild canvasMinX
	fstp particleRangeMinX
	;
	finit
	fild canvasMaxX
	fstp particleRangeMaxX
	;
	finit
	fild canvasMinY
	fstp particleRangeMinY
	;
	finit
	fild canvasMaxY
	fstp particleRangeMaxY	
	;
	call asm_RefreshWindowSize
	ret
asm_SetWindowDimension ENDP	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;int asm_GetNumOfObjects()
;
;Return the number of objects
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
asm_GetNumOfObjects PROC C
	mov eax, 1024
	ret
asm_GetNumOfObjects ENDP	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;int asm_GetObjectType(int objID)
;
;Return the object type
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
asm_GetObjectType		PROC C USES ebx edx,
	objID: DWORD
	push ebx
	push edx
	xor eax, eax
	mov edx, offset objTypes
	mov ebx, objID
	mov al, [edx + ebx]
	pop edx
	pop ebx
	ret
asm_GetObjectType  ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;void asm_GetObjectColor (int &r, int &g, int &b, int objID)
;Input: objID, the ID of the object
;
;Return the color three color components
;red, green and blue.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DivisionFunc PROC

ret
DivisionFunc ENDP

asm_GetObjectColor  PROC C USES ebx edi esi,
	r: PTR DWORD, g: PTR DWORD, b: PTR DWORD, objID: DWORD
	cmp ColorType,0
	jne L1A
	jmp R_DOM
L1A:
	mov esi, OFFSET RainBowColor
	mov eax,objID
	cdq
    xor edx,edx                          ;这里需要注意，random除法
	mov ebx, divisor
	div ebx
	mov eax, [esi+edx*4]
	add edx,1
	mov ebx, [esi+edx*4]
	add edx,1
	mov ecx, [esi+edx*4]
	mov edi, r
	mov DWORD PTR [edi], eax
	mov edi, g
	mov DWORD PTR [edi], ebx
	mov edi, b
	mov DWORD PTR [edi], ecx
	jmp quit0
R_DOM:
	cmp LINBIN,0
	je L1
	jmp L2
L1:
	call RandomColor
	add LINBIN,1
L2:
	mov edx, objID
	mov esi, OFFSET objColor
	mov eax, [esi+edx*4]
	add edx,1
	mov ebx, [esi+edx*4]
	add edx,1
	mov ecx, [esi+edx*4]
	mov edi, r
	mov DWORD PTR [edi], eax
	mov edi, g
	mov DWORD PTR [edi], ebx
	mov edi, b
	mov DWORD PTR [edi], ecx
quit0:
	ret
asm_GetObjectColor ENDP

RandomColor PROC USES esi ecx
   mov esi, OFFSET objColor
   mov ecx, 900
L1:
   cmp SUNSHINE,3
   jb L2
   jmp L3
L2:
   add SUNSHINE,1
   jmp quit0
L3:
   call Random32            
   mov ebx, eax
   and ebx, 0ffh
   mov [esi], ebx
quit0:
   add esi, 4
   loop L1
   ret
RandomColor ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;int asm_ComputeRotationAngle(a, b)
;return an angle*10.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
asm_ComputeRotationAngle PROC C USES ebx,
	a: DWORD, b: DWORD
	mov ebx, b
	shl ebx, 1
	mov eax, a
	add eax, 10
	ret
asm_ComputeRotationAngle ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;int asm_ComputeObjPositionX(int x, int objID)
;
;Return the x-coordinate in eax.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
asm_ComputeObjPositionX PROC C USES edi esi ebx edx,
	x: DWORD, objID: DWORD
	;modify this procedure
	mov ebx, objID
	mov esi, offset objPosX
	mov eax, [esi+ebx*4]
	ret
asm_ComputeObjPositionX ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;int asm_ComputeObjPositionY(int y, int objID)
;
;Return the y-coordinate in eax.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
asm_ComputeObjPositionY PROC C USES ebx esi edx,
	y: DWORD, objID: DWORD
	;modify this procedure
	mov ebx, objID
	mov esi, offset objPosY
	mov eax, [esi+ebx*4]
	ret
asm_ComputeObjPositionY ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; The input image's information:
; imageIndex : the index of an image, starting from 0
; imagePtr : the starting address of the image, i.e., the address of the first byte of the image
; (w, h) defines the dimension of the image.
; w: width
; h: height
; Thus, the image has w times h pixels.
; bytesPerPixel : the number of bytes used to represent one pixel
;
; Purpose of this procedure:
; Copy the image to our own database
;
asm_SetImageInfo PROC C USES esi edi ebx,
imageIndex : DWORD,
imagePtr : PTR BYTE, w : DWORD, h : DWORD, bytesPerPixel : DWORD
	mov mImageStatus, 1
	push w
	pop mImageWidth
	push h
	pop mImageHeight
	push bytesPerPixel
	pop mBytesPerPixel

	mov eax,h
	mul w
	mul bytesPerPixel
	mov ecx,eax
	mov edi, offset mImagePtr0
	mov esi, imagePtr
L1:
	mov al, [esi]
	mov [edi],al
	inc edi
	inc esi
	loop L1
	ret
asm_SetImageInfo ENDP

asm_GetImagePixelSize PROC C
mov eax, mImagePixelPointSize
ret
asm_GetImagePixelSize ENDP

asm_GetImageStatus PROC C
mov eax, 1
ret
asm_GetImageStatus ENDP

asm_getImagePercentage PROC C
mov eax, imagePercentage
ret
asm_getImagePercentage ENDP

;
;asm_GetImageColour(int imageIndex, int ix, int iy, int &r, int &g, int &b)
;
asm_GetImageColour PROC C USES ebx esi, 
imageIndex : DWORD,
ix: DWORD, iy : DWORD,
r: PTR DWORD, g: PTR DWORD, b: PTR DWORD
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov esi, offset mImagePtr0
	mov eax, ix
	mul mImageWidth
	add eax,iy
	mul mBytesPerPixel
	add esi, eax
	mov al, [esi]
	inc esi
	mov bl, [esi]
	inc esi
	mov cl, [esi]
	mov esi, r
	movzx ax,al
	movzx eax,ax
	mov DWORD PTR [esi], eax
	mov esi, g
	movzx bx,bl
	movzx ebx,bx
	mov DWORD PTR [esi], ebx
	mov esi, b
	movzx cx,cl
	movzx ecx,cx
	mov DWORD PTR [esi], ecx
	ret
asm_GetImageColour ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;const char *asm_getStudentInfoString()
;
;return pointer in edx
asm_getStudentInfoString PROC C
	mov eax, offset MY_INFO_AT_TOP_BAR
	ret
asm_getStudentInfoString ENDP

;
; Return the particle system state in eax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
asm_GetParticleSystemState PROC C
	mov eax, 1
	ret
asm_GetParticleSystemState ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;void asm_GetImageDimension(int &iw, int &ih)
asm_GetImageDimension PROC C USES ebx,
iw : PTR DWORD, ih : PTR DWORD
	mov ebx, iw
	mov eax, mImageWidth
	mov DWORD PTR [ebx], eax
	mov ebx, ih
	mov eax, mImageHeight
	mov DWORD PTR [ebx], eax
	ret
asm_GetImageDimension ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Compute a position to place an image.
; This position defines the lower left corner
; of the image.
;
asm_GetImagePos PROC C USES ebx,
	x : PTR DWORD,
	y : PTR DWORD
	mov eax, canvasMinX
	mov ebx, scaleFactor
	cdq
	idiv ebx
	mov ebx, x
	mov [ebx], eax
	mov eax, canvasMinY
	mov ebx, scaleFactor
	cdq
	idiv ebx
	mov ebx, y
	mov [ebx], eax
	ret
asm_GetImagePos ENDP

DelayTime PROC USES eax
mov eax,5
call delay
ret
DelayTime ENDP

TextColor PROC
mov eax, white + 16*blue
call SetTextColor
ret
TextColor ENDP

FirstMsg PROC USES eax
call TextColor
mov edx, OFFSET MSG1
mov ecx, LENGTHOF MSG1
L1:
	mov eax, [edx]
	call WriteChar
	call DelayTime
	inc edx
	loop L1
	call ReadInt
	cmp eax,0
	je L1A
	mov Speed,eax
L1A:
ret
FirstMsg ENDP

SecondMsg PROC USES eax
call TextColor
mov edx, OFFSET MSG2
mov ecx, LENGTHOF MSG2
L1:
	mov eax, [edx]
	call WriteChar
	call DelayTime
	inc edx
	loop L1
	call ReadInt
	cmp eax,0
	je L1A
	mov lifecycle,eax
L1A:
ret
SecondMsg ENDP

AskForInput_Initialization PROC USES ebx edi esi
	call Crlf
	call FirstMsg
	call SecondMsg
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov ebx, OFFSET CaptionString
	mov edx, OFFSET MessageString
	call MsgBox
	mov eax, green + white*16
	call SetTextColor
	ret
AskForInput_Initialization ENDP

asm_RefreshWindowSize PROC
	ret
asm_RefreshWindowSize ENDP

initGame PROC
	ret
initGame ENDP

updateGame PROC USES esi ebx
	cmp IdOfObject,1024
	je quit0                 ;如果Object数量超过了1024那么update将不会再发挥作用
	cmp stopflag,1
	je L1                    ;这里是用来检测stopflag，如果为1表示0th小球后面的球体的位置不在改变
	cmp counter,0
	je con1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	sub counter,1
; 	cmp flagFin,1
; 	jne con2
; 	call AutoMovePosition    ;这里的主要目的是提高程序运行的效率,如果没有点击事件发生就跳过这一步
; ; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; con2:
	jmp L1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;改变后面小球的位置（0，0）to (PresentX, PresentY)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
con1:
	push lifecycle
	pop counter
	mov edi, OFFSET objPosX
	mov esi, OFFSET objPosY
	mov eax, [esi]  ; Y
	mov ecx, [edi]  ; X
	add IdOfObject,1
	mov ebx, IdOfObject
	mov [esi+ebx*4],eax
	mov [edi+ebx*4],ecx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;往左边运动
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
L1:
	cmp flagFin,1
	jne L1B
	call AutoMovePositionXL
	mov eax,flag2
	call WriteDec
	call Crlf
	cmp flag2, 1
	je L1A
	jmp L3
L1B:
	cmp moveDirection,0
	jne L2
L1A:
	mov moveDirection,0
	mov esi, offset objPosX
	mov eax, [esi]
	sub eax, Speed
	cmp eax, -50000
	jle L3A
	mov [esi], eax
	mov Present_X,eax
	call CheckState
	jmp quit0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;往上运动
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
L2:
	cmp flagFin,1
	jne L2B
	call AutoMovePositionYU
	cmp flag4, 1
	je L2A
	jmp L4
L2B:
	cmp moveDirection,1
	jne L3
L2A:
	mov moveDirection,1
	mov esi, offset objPosY
	mov eax, [esi]
	add eax, Speed
	cmp eax, 50000
	jge L4A
	mov [esi], eax
	mov Present_Y,eax
	call CheckState
	jmp quit0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;往右边运动
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
L3:
	cmp flagFin,1
	jne L3B
	call AutoMovePositionXR
	cmp flag1, 1
	je L3A
	jmp L2
L3B:
	cmp moveDirection,2
	jne L4
L3A:
	mov moveDirection,2
	mov esi, offset objPosX
	mov eax, [esi]
	add eax, Speed
	cmp eax, 50000
	jge L1A
	mov [esi], eax
	mov Present_X,eax
	call CheckState
	jmp quit0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;往下运动
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
L4:
	cmp flagFin,1
	jne L4B
	call AutoMovePositionYD
	cmp flag3, 1
	je L4A
	jmp quit0
L4B:
	cmp moveDirection,3
	jne quit0
L4A:
	mov moveDirection,3
	mov esi, offset objPosY
	mov eax, [esi]
	sub eax, Speed
	cmp eax, -50000
	jle L2A
	mov [esi], eax
	mov Present_Y,eax
	call CheckState
quit0:
	ret
updateGame ENDP

ClearSphere PROC USES eax ebx
mov esi, OFFSET objPosX
mov edi, OFFSET objPosY
mov eax, [esi]
mov ebx, [edi]
mov ecx, LENGTHOF objPosX
L1:
	mov [esi],eax
	mov [edi],ebx
	add esi, 4
	add edi, 4
	loop L1
ret
ClearSphere ENDP

CheckState PROC
cmp flagV,1
je L1
jmp quit0
L1:
	call ClearSphere
quit0:
ret
CheckState ENDP

loadData PROC USES esi edi eax edx ebx
mov esi, OFFSET objPosX
mov edi, OFFSET objPosY
mov ecx, LENGTHOF objPosY
L1:
	mov eax,haha
	mwrite "ObjectID:"
	call WriteDec
	call Crlf
	cmp ColorType,0
	jne L2
	call PrintColor
	jmp L3
	L2:
	call PrintColor1
L3:
	mwrite "PositionX:"
	mov eax, [esi]
	call WriteDec
	add esi,4
	mwrite "  PositionY:"
	mov eax, [edi]
	call WriteDec
	add edi,4	
	add haha,1
loop L1
ret
loadData ENDP

PrintColor PROC
	push esi
	mov esi, OFFSET objColor
	mov ebx, haha
    mov eax, [esi+ebx*4] 
    mwrite "R："
    call WriteDec
    add ebx,1
    mov eax, [esi+ebx*4]
    mwrite " G："
    call WriteDec
    add ebx,1
    mov eax, [esi+ebx*4]
    mwrite " B："
    call WriteDec
    call Crlf
	pop esi
ret 
PrintColor ENDP

PrintColor1 PROC
	push esi
	mov esi, OFFSET RainBowColor
	cdq
	mov ebx, divisor
	div ebx
    mov eax, [esi+edx*4] 
    mwrite "R："
    call WriteDec
    add edx,1
    mov eax, [esi+edx*4]
    mwrite " G："
    call WriteDec
    add edx,1
    mov eax, [esi+edx*4]
    mwrite " B："
    call WriteDec
    call Crlf
	pop esi
ret
PrintColor1 ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
AutoMovePositionXR PROC
push eax
mov eax,Present_X
cmp Destination_X, eax
pop eax
jl L1A
finit
fild Destination_X
fisub Present_X
fistp CmpVar
cmp CmpVar,100
jg L1
L1A:
mov flag1,0
jmp quit0
L1:
mov flag1,1  ;水平向右前进
quit0:
ret 
AutoMovePositionXR ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
AutoMovePositionXL PROC
push eax
mov eax,Present_X


cmp Destination_X, eax
pop eax
jg L1A

finit 
fild Present_X
fisub Destination_X
fistp CmpVar
cmp CmpVar,100
jg L1
L1A:
mov flag2,0
jmp quit0
L1:
mov flag2,1  ;水平向左前进
quit0:
ret
AutoMovePositionXL ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AutoMovePositionYU PROC
push eax
mov eax,Present_Y
cmp Destination_Y, eax
pop eax
jl L1A

finit
fild Destination_Y
fisub Present_Y
fistp CmpVar
cmp CmpVar,100
jg L1
L1A:
mov flag4,0
jmp quit0
L1:
mov flag4,1  ;竖直向上前进

quit0:
ret 
AutoMovePositionYU ENDP

AutoMovePositionYD PROC
push eax
mov eax,Present_Y
cmp Destination_Y, eax
pop eax
jg L1A
finit 
fild Present_Y
fisub Destination_Y
fistp CmpVar
cmp CmpVar,100
jg L1
L1A:
mov flag3,0
jmp quit0
L1:
mov flag3,1  ;竖直向下前进
quit0:
ret 
AutoMovePositionYD ENDP

END
