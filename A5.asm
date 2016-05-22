.model tiny
	print_color macro
	   mov ax,0920h    ;AH=Function number AL=Space character  
	   mov cx,200      ; number of chars that will be painted
	   int 10h         ;BIOS function 09h
	   int 21h         ;DOS function 09h
	endm

	red macro
	   mov bl,04       ;red color
	   print_color
	endm

	grey macro
	   mov bl,07      ;white grey color
	   print_color
	endm

	mas_0L macro
	  lea     dx, msg_0L
	  red
	endm

	mas_1L macro
	  lea     dx, msg_1L
	  print_str
	endm
	mas_2L macro
	   lea     dx, msg_2L
	   print_str
	endm

	mas_4L macro
	   lea     dx, msg_4L
	   grey
	endm

	mas_5L macro
	   lea     dx, msg_5L
	   print_str
	endm
	 
	mas_9L macro
	   lea     dx, msg_9L
	   print_str
	endm
	 
	mas_10L macro
	   lea     dx, msg_10L
	   print_str
	endm

	mas_11L macro
	   lea  dx, msg_11L
	   red
	endm

	dark_green macro
	   mov bl,02h      ;dark green color
	   print_color
	endm	

	print_str macro
	  mov     ah, 09h
	  int     21h
	endm

	AX_to_DEC macro
	    mov bx, 10              ; divisor
	    xor cx, cx              ; CX=0 (number of digits)
	    First_Loop:
	        xor dx, dx              ; Attention: DIV applies also DX!
	        div bx                  ; DX:AX / BX = AX remainder: DX
	        push dx                 ; LIFO
	        inc cx                  ; increment number of digits
	        test  ax, ax            ; AX = 0?
	        jnz First_Loop          ; no: once more
	 
	        mov di,offset decimal   ; target string DECIMAL
	    Second_Loop:
	        pop ax                  ; get back pushed digit
	        or ax,00110000b        ; to ASCII
	        mov byte ptr [di], al   ; save AL
	        inc di                  ; DI points to next character in string DECIMAL
	        loop Second_Loop        ; until there are no digits left
	 
	        mov byte ptr [di], '$'  ; End-of-string delimiter for INT 21 / FN 09h
	endm
	 
	AX_to_DEC2 macro
        mov bx, 10              ; divisor
        xor cx, cx              ; CX=0 (number of digits)
	 
	    x_loop:
	        xor dx, dx              ; Attention: DIV applies also DX!
	        div bx                  ; DX:AX / BX = AX remainder: DX
	        push dx                 ; LIFO
	        inc cx                  ; increment number of digits
	        test  ax, ax            ; AX = 0?
	        jnz  x_loop          ; no: once more
	 
	        mov di,offset x         ; target string x
	     y_loop:
	        pop ax                  ; get back pushed digit
	        or ax,00110000b        ; to ASCII
	        mov byte ptr [di], al   ; save AL
	        inc di                  ; DI points to next character in string DECIMAL
	        loop y_loop     ; until there are no digits left
	 
	        mov byte ptr [di], '$'  ; End-of-string delimiter for INT 21 / FN 09h
	endm

	print_true macro
	    mas_2L
	    lea dx,msg_score
	    dark_green
	endm	

	correct_score macro
	    xor ax, ax
	    ;mov dl, 115   ;wait dl
	    mov al, dl    ;al for show numbers  <-------------------------------------------------- *** Link Here***
	    add al, 0
	    adc ah, 0
	    mov val, ax
	 
	    mov ax,val
	    AX_to_DEC
	endm

	wrong_score macro
	    xor ax, ax
	    ;mov dl, 100    ;wait dl
	    mov al, dl     ;al for show numbers  <------------------------------------------------ *** Link Here***
	    add al, 0
	    adc ah, 0
	    mov val_x, ax
	 
	    mov ax,val_x
	    AX_to_DEC2
	endm

	print_space macro
	    lea dx,msg_space
	    grey
	endm
	 
	print_numbers macro
	  mov     ax, 4c00h
	  int     21h
	endm

	print macro
	  mas_0L
	  mas_1L
	 
	  ;===========Answer==================
	  correct_score
	  print_true
	 
	  wrong_score
	  print_false
	  ;===========END Answer==================
	  mas_4L
	  mas_9L
	  mas_10L
	  mas_11L
	endm
.data
	tempProc	db 	0
	temp2		db 	0
	temp		db 	0
	Score 		db  0
	HiScore 	db  0
	PoCarBar	db  23 ; for Position of Car on Left-bar
	PlayerPos	db	33 ; 24-42 ; for Position of Car on Street
	PlayerPosTemp db 33
	BotPosTemp	db  5,27	
	multi		db 	3
	BotPos		db	44 dup (-1)	;24-42
	CountFrame 	db 	0
	CountSpawn	dw  0 ;0-3
	savePress	db 	0 ;store Pressed key by User
	temp3 		db 	0
	gameStatus 	db 	0 ; 0 is normal and 1 is GameOver
	Menu 		db	"                                                                                "	;0
				db	"                                                                                "	;1
				db	"                                                                                "	;2
				db	"                      ",219,219,219,219,219,219,"    ",219,219,219,219,219,"     ",219,219,219,219,219,"   ",219,219,219,219,219,219,"                        "	;3
				db	"                      ",219,219,"   ",219,219,"  ",219,219,"   ",219,219,"   ",219,219,"   ",219,219,"  ",219,219,"   ",219,219,"                       "	;4
				db	"                      ",219,219,219,219,219,219,"   ",219,219,"   ",219,219,"   ",219,219,"   ",219,219,"  ",219,219,"   ",219,219,"                       " 	;5
				db	"                      ",219,219,"  ",219,219,"   ",219,219,"   ",219,219,"   ",219,219,219,219,219,219,219,"  ",219,219,"   ",219,219,"                       "	;1
				db	"                      ",219,219,"   ",219,219,"   ",219,219,219,219,219,"    ",219,219,"   ",219,219,"  ",219,219,219,219,219,219,"                        "	;2
				db	"                                                                                "	;3
				db	"           ",219,219,"",219,219,"",219,219,"  ",219,219,"   ",219,219,"",219,219,"",219,219,"  ",219,219,"   ",219,219,"  ",219,219,"",219,219,"",219,219,"",219,219,"  ",219,219,"",219,219,"",219,219,"  ",219,219,"",219,219,"",219,219,"               "	;6
				db	"           ",219,219,"      ",219,219,"  ",219,219,"       ",219,219,"   ",219,219,"     ",219,219,"     ",219,219,"      ",219,219,"   ",219,219,"              "	;7
				db	"           ",219,219,"",219,219,"    ",219,219,"  ",219,219," ",219,219,"",219,219,"  ",219,219,"",219,219,"",219,219,219,"     ",219,219,"     ",219,219,"",219,219,219,"   ",219,219,"",219,219,"",219,219,"               "	;8
				db	"           ",219,219,"      ",219,219,"  ",219,219,"   ",219,219,"  ",219,219,"   ",219,219,"     ",219,219,"     ",219,219,"      ",219,219,"  ",219,219,"               "	;9
				db	"           ",219,219,"      ",219,219,"   ",219,219,"",219,219,"",219,219,"  ",219,219,"   ",219,219,"     ",219,219,"     ",219,219,"",219,219,"",219,219,"  ",219,219,"   ",219,219,"   TM         "	;10
				db	"                                                                                "
				db	"                                                                                "
				db	"                             TM  AND  ",1,"  2016                               "
				db	"                                                                                "
				db	"                               KINOMA  CO.,LTD.                                 "
				db	"                         LICENSED  BY  NINELEVENTDO                             "
				db	"                                                                                "
				db	"                    COMORG  SOFTWARE  ASSIGNMENT5 OPEN PROJECT                  "
				db	"                                                                                "
				db	"                                                                                "
				db	"                                                                                $"	;4
 	val dw ?
	msg_score db ""
	decimal db "00000$"
	val_x dw ?
	msg_x db ""
	x db "00000$"
	Wrong 		db 0

	IsPlayerWin	db 0 ; 0 is lose and 1 is winner
	win		db "                                                                                "
			db "      ",219,219,"    ",219,219,"   ",219,219,"",219,219,"",219,219,"   ",219,219,"    ",219,219,"            ",219,219,"  ",219,219,"  ",219,219,"  ",219,219,"",219,219,"",219,219,"  ",219,219,"    ",219,219,"      "
			db "       ",219,219,"  ",219,219,"   ",219,219,"    ",219,219,"  ",219,219,"    ",219,219,"            ",219,219,"  ",219,219,"  ",219,219,"    ",219,219,"    ",219,219,"",219,219,"  ",219,219,"      "
			db "        ",219,219,"",219,219,"    ",219,219,"    ",219,219,"  ",219,219,"    ",219,219,"            ",219,219,"  ",219,219,"  ",219,219,"    ",219,219,"    ",219,219," ",219,219," ",219,219,"      "
			db "         ",219,219,"     ",219,219,"    ",219,219,"  ",219,219,"    ",219,219,"            ",219,219,"  ",219,219,"  ",219,219,"    ",219,219,"    ",219,219,"  ",219,219,"",219,219,"      "
			db "         ",219,219,"     ",219,219,"    ",219,219,"  ",219,219,"    ",219,219,"             ",219,219,"",219,219,"",219,219,"",219,219,"     ",219,219,"    ",219,219,"   ",219,219,219,"       "
			db "        ",219,219,"      ",219,219,"",219,219,"",219,219,"    ",219,219,"",219,219,"",219,219,"               ",219,219,"  ",219,219,"    ",219,219,"",219,219,"",219,219,"  ",219,219,"    ",219,219,"      "
			db "                                                                                $"
			

	lose	db "                                                                                "
			db "      ",219,219,"    ",219,219,"   ",219,219,"",219,219,"",219,219,"   ",219,219,"    ",219,219,"      ",219,219,"       ",219,219,"",219,219,"",219,219,"    ",219,219,"",219,219,"",219,219,"   ",219,219,"",219,219,"",219,219,"      "
			db "       ",219,219,"  ",219,219,"   ",219,219,"    ",219,219,"  ",219,219,"    ",219,219,"      ",219,219,"      ",219,219,"    ",219,219,"  ",219,219,"        ",219,219,"          "
			db "        ",219,219,"",219,219,"    ",219,219,"    ",219,219,"  ",219,219,"    ",219,219,"      ",219,219,"      ",219,219,"    ",219,219,"   ",219,219,"",219,219,"",219,219,"   ",219,219,"",219,219,"        "
			db "         ",219,219,"     ",219,219,"    ",219,219,"  ",219,219,"    ",219,219,"      ",219,219,"      ",219,219,"    ",219,219,"        ",219,219,"  ",219,219,"          "
			db "         ",219,219,"     ",219,219,"    ",219,219,"  ",219,219,"    ",219,219,"      ",219,219,"      ",219,219,"    ",219,219,"  ",219,219,"    ",219,219,"  ",219,219,"          "
			db "         ",219,219,"      ",219,219,"",219,219,"",219,219,"    ",219,219,"",219,219,"",219,219,"       ",219,219,"",219,219,"",219,219,"   ",219,219,"",219,219,"",219,219,"    ",219,219,"",219,219,"",219,219,"   ",219,219,"",219,219,"",219,219,"      "
			db "                                                                                $"
	
	msg_0L  db 10,13,'===============================   [END Game] ===================================$'
	msg_1L db 10,13,'                             ___________________$'                            
	msg_2L db 10,13,'                                   Score:$'                              
	                              
	msg_4L db 10,13,'                             ___________________$'
	                        
	msg_9L db 10,13,' $'      
	                   
	msg_10L db 10,13,'                               Esc to exit...$'
	msg_11L db 10,13,'===============================================================================$'
 	msg_space db ' $',0


.code
	org		0100h
main:
MenuScreen:
	mov     ah, 00h ; Set to 80x25
    mov     al, 03h
    int     10h

    mov		ah,2
	mov		bh,0
	mov 	dh,0
	mov		dl,0
	int 10h

	mov 	ah,09
	mov 	al," "
	mov 	bh,0
	mov 	bl,04h
	mov 	cx,1200
	int 10h

	mov		ah,2
	mov		bh,0
	mov 	dh,0
	mov		dl,0
	int 10h

	mov		ah, 09
	mov 	dx, offset Menu
	int 21h

   	mov 	ah,00
   	int 16h

   	mov cx, 24
   	ClearMenuScreen:

	    mov		ah,2
		mov		bh,0
		mov 	dh,cl
		mov		dl,0
		int 10h

		push	cx

		mov 	ah,09
		mov 	al," "
		mov 	bh,0
		mov 	bl,04h
		mov 	cx,80
		int 10h

		MOV     CX, 01H
		MOV     DX, 64
		MOV     AH, 86H
		INT     15H

		pop		cx
		loop 	ClearMenuScreen

EndMenuZone:


ScreenZone:

	mov     ah, 00h ; Set to 80x25
    mov     al, 03h
    int     10h

CreateStreet:
	CreateLine:
	; 	set data
		mov		temp, 0

	LcreateLine:
		mov		temp2, 23
		CreateStreetBar:
		mov 	ah, 02h ; set cursor
		mov 	dh, temp
		mov 	dl, temp2 ; 23-43
		int 	10h

		mov 	ax, 177
		mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
		mov		bh, 0
		mov 	bl, 007h; color
		mov		cx, 1
		int		10h
		;-------- end 1 char created

		inc 	temp2
		cmp 	temp2, 44
		jne 	CreateStreetBar

		mov 	ah, 02h ; set cursor
		mov 	dh, temp
		mov 	dl, 10
		int 	10h

		mov 	ax, '|'
		mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
		mov		bh, 0
		mov 	bl, 004h; color
		mov		cx, 1
		int		10h
		;-------- end 1 char created

		mov 	ah, 02h ; set cursor
		mov 	dh, temp
		mov 	dl, 55
		int 	10h

		mov 	ax, '|'
		mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
		mov		bh, 0
		mov 	bl, 004h; color
		mov		cx, 1
		int		10h
		;-------- end 1 char created

		mov 	ah, 02h ; set cursor
		mov 	dh, temp
		mov 	dl, 22
		int 	10h

		mov 	ax, 206
		mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
		mov		bh, 0
		mov 	bl, 00Ah; color
		mov		cx, 1
		int		10h
		;-------- end 1 char created
		jmp 	skipLcreateLine
		jmpLcreateLine:
		jmp 	LcreateLine
		skipLcreateLine:

		mov 	ah, 02h ; set cursor
		mov 	dh, temp
		mov 	dl, 44
		int 	10h

		mov 	ax, 206
		mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
		mov		bh, 0
		mov 	bl, 00Ah; color
		mov		cx, 1
		int		10h
		;-------- end 1 char created


		mov 	ah, 02h ; set cursor
		mov 	dh, temp
		mov 	dl, 4
		int 	10h

		mov 	ax, 176
		mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
		mov		bh, 0
		mov 	bl, 007h; color
		mov		cx, 1
		int		10h
		;-------- end 1 char created
		
		inc 	temp

		cmp		temp, 25
		jne		jmpLcreateLine

		; create goal
		mov 	ah, 02h ; set cursor
		mov 	dh, 0
		mov 	dl, 4
		int 	10h

		mov 	ax, 244
		mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
		mov		bh, 0
		mov 	bl, 00Bh; color
		mov		cx, 1
		int		10h
		;-------- end 1 char created

		; create start-point
		mov 	ah, 02h ; set cursor
		mov 	dh, 24
		mov 	dl, 4
		int 	10h

		mov 	ax, 244
		mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
		mov		bh, 0
		mov 	bl, 00Eh; color
		mov		cx, 1
		int		10h
		;-------- end 1 char created

		; create car-bar
		mov 	ah, 02h ; set cursor
		mov 	dh, PoCarBar
		mov 	dl, 4
		int 	10h

		mov 	ax, 207
		mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
		mov		bh, 0
		mov 	bl, 00Ch; color
		mov		cx, 1
		int		10h

		jmp 	skiptoScreenZone
		toScreenZone:
		jmp 	ScreenZone
		skiptoScreenZone:
		call	DrawScore
		;call	DrawHiScore
		;call	BotSpawn
		call	DrawCar
		;call 	DrawBotCar
		call 	RandomBot

		cmp 	gameStatus, 1
		je 		quit


		add 	CountSpawn, 1
		cmp 	CountSpawn, 5
		jne 	skipCountSpawn
		mov 	CountSpawn, 0
		add 	Score, 1

		skipCountSpawn:

		mov     cx, 01h		; add 16 = 1sec delay
		mov     dx, 2120h
		mov     ah, 86h
		int     15h

		; Input Left or Right for Red-Car
		input:
		mov 	ah, 01h
		int 	16h

		jz 		Notinput; not press

		mov		ah, 00h
		int 	16h
		;mov 	savePress, ax #bug

		cmp 	ax, 4B00h   ;arrow LEFT.
	    je  	arrow_left
	    cmp 	ax, 4D00h   ;arrow RIGHT.
	    je  	arrow_right

	    arrow_left:

	    cmp 	PlayerPos, 24
	    jle 	ContinuePressed
	    dec 	PlayerPos

	    jmp 	ContinuePressed
	    arrow_right:

	    cmp 	PlayerPos, 42
	    jge		ContinuePressed
	    inc 	PlayerPos

	    ContinuePressed:
		; Pressed Left


		Notinput:
		inc 	CountFrame
		cmp		CountFrame,25
		jl 		skipCountFrame

		dec 	PoCarBar
		mov 	CountFrame, 0
		skipCountFrame:

		cmp 	PoCarBar, 0
		jne 	toScreenZone
Winner: 
		mov 	IsPlayerWin, 1
quit:

		mov     ah, 00h ; Set to 80x25
	    mov     al, 03h
	    int     10h

	    mov 	al, HiScore
		cmp		al, Score
		ja 		skipNewHigh

		mov 	al, Score
		mov 	HiScore, al

skipNewHigh:
EndGame:

	mov     ah, 00h ; Set to 80x25
    mov     al, 03h
    int     10h

    cmp IsPlayerWin, 1
    je WinEnd

    call LoseScreenEnd
    jmp  ExitGame
    
    WinEnd:
    call WinScreenEnd
    ExitGame:

;---------- Show last screen
	mov     ah, 02h         ; Move cursor XY
    mov     bh, 00h
    mov     dh, 18
    mov     dl, 0
    int     10h

	mas_0L
  	mas_1L

	mov 	dl, Score
	correct_score
	print_true
	 
	mov 	dl, Wrong
	wrong_score
	;===========END Answer==================
	mas_4L
	mas_9L
	mas_10L
	mas_11L

    mov ah,00
    int 16h

    mov ah, 00
    mov al, 03
    int 10h

    MOV AH, 4CH                  ; RETURN CONTROL TO DOS
    INT 21H

WinScreenEnd proc near
	
	mov		ah,2
	mov		bh,0
	mov 	dh,7
	mov		dl,0
	int 10h

	mov 	ah,09
	mov 	al," "
	mov 	bh,0
	mov 	bl,0Ah
	mov 	cx,640
	int 10h
	
	mov		ah,2
	mov		bh,0
	mov 	dh,7
	mov		dl,0
	int 10h

	mov		ah, 09
	mov 	dx, offset win
	int 21h

	ret
WinScreenEnd endp

LoseScreenEnd proc near
		
	mov		ah,2
	mov		bh,0
	mov 	dh,7
	mov		dl,0
	int 10h

	mov 	ah,09
	mov 	al," "
	mov 	bh,0
	mov 	bl,04h
	mov 	cx,640
	int 10h
	
	mov		ah,2
	mov		bh,0
	mov 	dh,7
	mov		dl,0
	int 10h

	mov		ah, 09
	mov 	dx, offset lose
	int 21h

	ret

	ret
LoseScreenEnd endp

RandomBot PROC
	PUSH AX
	PUSH CX
	PUSH DX
	PUSH BX
	PUSH SP ; The value stored is the initial SP value
	PUSH BP
	PUSH SI
	PUSH DI

	mov si, 24
	RunTo42:
		cmp BotPos[si], -1
		jne skipAddBot

			mov ax, 50 ; random 0-4
			int 62h	; random to ax

			cmp ax, CountSpawn
			jne skipAddBot
			mov BotPos[si], 0
		
		skipAddBot:		
		add si,3
		cmp si,42
	jna RunTo42

	mov si,24
	RunToDraw:	
		cmp BotPos[si], -1
		je	skipDrawBot
			mov ah, BotPos[si]
			mov BotPosTemp[0], ah ; Row
			mov ax, si
			mov BotPosTemp[1], al ; Col
			call DrawBotCar
			call CheckCollision

			add BotPos[si], 1
			cmp BotPos[si], 26
			jne skipNewRandom
			mov BotPos[si], -1
			skipNewRandom:

		skipDrawBot:
		add si, 3
		cmp si, 42
	jna RunToDraw

	POP DI
	POP SI
	POP BP
	POP AX ;no POP SP here, only ADD SP,2
	POP BX
	POP DX
	POP CX
	POP AX
	ret
RandomBot endp

CheckCollision PROC
	PUSH AX
	PUSH CX
	PUSH DX
	PUSH BX
	PUSH SP ; The value stored is the initial SP value
	PUSH BP
	PUSH SI
	PUSH DI

	mov ax, 0
	checkColumn:
	mov al, BotPosTemp[1] ; Col
	sub al, PlayerPos

	cmp al, 2
	ja  NextCheckCol
	jmp checkRow

	NextCheckCol:
	mov al, BotPosTemp[1] ; Col
	sub al, PlayerPos
	neg al

	cmp al, 2
	ja 	QuitCheck

	checkRow:

	mov al, BotPosTemp[0] ; Row
	sub al, 21

	cmp al, 1
	ja 	NextCheckRow
	; quit Game !!!!!
	jmp gameCollision
	NextCheckRow:
	mov al, BotPosTemp[0] ; Row
	sub al, 21
	neg al

	cmp al, 1
	ja QuitCheck

	gameCollision:

	mov gameStatus, 1

	QuitCheck:
	POP DI
	POP SI
	POP BP
	POP AX ;no POP SP here, only ADD SP,2
	POP BX
	POP DX
	POP CX
	POP AX
	ret 
CheckCollision endp

DrawBotCar	PROC 	;BotPosTemp[0] <- row  //  BotPosTemp[1] <- col
	PUSH AX
	PUSH CX
	PUSH DX
	PUSH BX
	PUSH SP ; The value stored is the initial SP value
	PUSH BP
	PUSH SI
	PUSH DI

	
	mov ah, 02
	mov bh, 00
	mov dh, BotPosTemp[0]
	mov dl, BotPosTemp[1]
	int 10h

	mov ah, 09
	mov al, 220
	mov bh, 0
	mov bl, 0Eh
	mov cx, 1
	int 10h

	mov ah, 02
	mov bh, 00
	mov dh, BotPosTemp[0]
	inc	dh
	mov dl, BotPosTemp[1]
	dec dl
	int 10h

	mov ah, 09
	mov al, 219
	mov bh, 0
	mov bl, 0Eh
	mov cx, 1
	int 10h

	mov ah, 02
	mov bh, 00
	mov dh, BotPosTemp[0]
	inc	dh
	mov dl, BotPosTemp[1]
	int 10h

	mov ah, 09
	mov al, 219
	mov bh, 0
	mov bl, 0Eh
	mov cx, 1
	int 10h

	mov ah, 02
	mov bh, 00
	mov dh, BotPosTemp[0]
	inc	dh
	mov dl, BotPosTemp[1]
	inc dl
	int 10h

	mov ah, 09
	mov al, 219
	mov bh, 0
	mov bl, 0Eh
	mov cx, 1
	int 10h


	POP DI
	POP SI
	POP BP
	POP AX ;no POP SP here, only ADD SP,2
	POP BX
	POP DX
	POP CX
	POP AX
	ret
DrawBotCar endp

BotSpawn PROC
	PUSH AX
	PUSH CX
	PUSH DX
	PUSH BX
	PUSH SP ; The value stored is the initial SP value
	PUSH BP
	PUSH SI
	PUSH DI

	mov ax, 73	;random
	int 62h

	cmp BotPos[si], -1
	jne SkipSpawnBot
		add BotPos[si], 1
	SkipSpawnBot: 

	POP DI
	POP SI
	POP BP
	POP AX ;no POP SP here, only ADD SP,2
	POP BX
	POP DX
	POP CX
	POP AX
	ret
BotSpawn endp

DrawScore PROC
	PUSH AX
	PUSH CX
	PUSH DX
	PUSH BX
	PUSH SP ; The value stored is the initial SP value
	PUSH BP
	PUSH SI
	PUSH DI

	mov 	tempProc, 62
	LDrawScore:
	mov 	ah, 02h ; set cursor
	mov 	dh, 20
	mov 	dl, tempProc
	int 	10h

	mov 	ax, 176
	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov		bh, 0
	mov 	bl, 00Ch; color
	mov		cx, 1
	int		10h
	;-------- end 1 char created

	inc 	tempProc
	cmp		tempProc, 73

	jne 	LDrawScore

	mov 	ah, 02h ; set cursor
	mov 	dh, 20
	mov 	dl, 65
	int 	10h

	mov 	ax, 'S'
	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov		bh, 0
	mov 	bl, 00Fh; color
	mov		cx, 1
	int		10h
	;-------- end 1 char created

	mov 	ah, 02h ; set cursor
	mov 	dh, 20
	mov 	dl, 66
	int 	10h

	mov 	ax, 'C'
	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov		bh, 0
	mov 	bl, 00Fh; color
	mov		cx, 1
	int		10h
	;-------- end 1 char created

	mov 	ah, 02h ; set cursor
	mov 	dh, 20
	mov 	dl, 67
	int 	10h

	mov 	ax, 'O'
	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov		bh, 0
	mov 	bl, 00Fh; color
	mov		cx, 1
	int		10h
	;-------- end 1 char created

	mov 	ah, 02h ; set cursor
	mov 	dh, 20
	mov 	dl, 68
	int 	10h

	mov 	ax, 'R'
	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov		bh, 0
	mov 	bl, 00Fh; color
	mov		cx, 1
	int		10h
	;-------- end 1 char created

	mov 	ah, 02h ; set cursor
	mov 	dh, 20
	mov 	dl, 69
	int 	10h

	mov 	ax, 'E'
	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov		bh, 0
	mov 	bl, 00Fh; color
	mov		cx, 1
	int		10h
	;-------- end 1 char created

	POP DI
	POP SI
	POP BP
	POP AX ;no POP SP here, only ADD SP,2
	POP BX
	POP DX
	POP CX
	POP AX
	ret 
DrawScore endp

DrawHiScore PROC
	PUSH AX
	PUSH CX
	PUSH DX
	PUSH BX
	PUSH SP ; The value stored is the initial SP value
	PUSH BP
	PUSH SI
	PUSH DI

	mov 	tempProc, 62
	LDrawHiScore:
	mov 	ah, 02h ; set cursor
	mov 	dh, 15
	mov 	dl, tempProc
	int 	10h

	mov 	ax, 176
	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov		bh, 0
	mov 	bl, 00Ch; color
	mov		cx, 1
	int		10h
	;-------- end 1 char created

	inc 	tempProc
	cmp		tempProc, 73

	jne 	LDrawHiScore

	mov 	ah, 02h ; set cursor
	mov 	dh, 15
	mov 	dl, 63
	int 	10h

	mov 	ax, 'H'
	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov		bh, 0
	mov 	bl, 00Fh; color
	mov		cx, 1
	int		10h
	;-------- end 1 char created

	mov 	ah, 02h ; set cursor
	mov 	dh, 15
	mov 	dl, 64
	int 	10h

	mov 	ax, 'I'
	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov		bh, 0
	mov 	bl, 00Fh; color
	mov		cx, 1
	int		10h
	;-------- end 1 char created

	mov 	ah, 02h ; set cursor
	mov 	dh, 15
	mov 	dl, 65
	int 	10h

	mov 	ax, 'G'
	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov		bh, 0
	mov 	bl, 00Fh; color
	mov		cx, 1
	int		10h
	;-------- end 1 char created

	mov 	ah, 02h ; set cursor
	mov 	dh, 15
	mov 	dl, 66
	int 	10h

	mov 	ax, 'H'
	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov		bh, 0
	mov 	bl, 00Fh; color
	mov		cx, 1
	int		10h
	;-------- end 1 char created

	mov 	ah, 02h ; set cursor
	mov 	dh, 15
	mov 	dl, 67
	int 	10h

	mov 	ax, 'S'
	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov		bh, 0
	mov 	bl, 00Fh; color
	mov		cx, 1
	int		10h
	;-------- end 1 char created

	mov 	ah, 02h ; set cursor
	mov 	dh, 15
	mov 	dl, 68
	int 	10h

	mov 	ax, 'C'
	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov		bh, 0
	mov 	bl, 00Fh; color
	mov		cx, 1
	int		10h
	;-------- end 1 char created

	mov 	ah, 02h ; set cursor
	mov 	dh, 15
	mov 	dl, 69
	int 	10h

	mov 	ax, 'O'
	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov		bh, 0
	mov 	bl, 00Fh; color
	mov		cx, 1
	int		10h
	;-------- end 1 char created

	mov 	ah, 02h ; set cursor
	mov 	dh, 15
	mov 	dl, 70
	int 	10h

	mov 	ax, 'R'
	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov		bh, 0
	mov 	bl, 00Fh; color
	mov		cx, 1
	int		10h
	;-------- end 1 char created

	mov 	ah, 02h ; set cursor
	mov 	dh, 15
	mov 	dl, 71
	int 	10h

	mov 	ax, 'E'
	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov		bh, 0
	mov 	bl, 00Fh; color
	mov		cx, 1
	int		10h
	;-------- end 1 char created

	POP DI
	POP SI
	POP BP
	POP AX ;no POP SP here, only ADD SP,2
	POP BX
	POP DX
	POP CX
	POP AX
	ret 
DrawHiScore endp

DrawCar PROC 		; player at row 21
	PUSH AX
	PUSH CX
	PUSH DX
	PUSH BX
	PUSH SP ; The value stored is the initial SP value
	PUSH BP
	PUSH SI
	PUSH DI

		;DrawOldPos
		mov ah, 02
		mov bh, 00
		mov dh,	21
		mov dl, PlayerPosTemp
		int 10h

		mov ah, 09
		mov al, 220;ascii
		mov bh, 00
		mov bl, 00h;attribute
		mov cx, 1
		int 10h

		mov ah, 02
		mov bh, 00
		mov dh,	22
		mov dl, PlayerPosTemp
		dec	dl
		int 10h

		mov ah, 09
		mov al, 219;ascii
		mov bh, 00
		mov bl, 00h;attribute
		mov cx, 1
		int 10h

		mov ah, 02
		mov bh, 00
		mov dh,	22
		mov dl, PlayerPosTemp
		int 10h

		mov ah, 09
		mov al, 219;ascii
		mov bh, 00
		mov bl, 00h;attribute
		mov cx, 1
		int 10h

		mov ah, 02
		mov bh, 00
		mov dh,	22
		mov dl, PlayerPosTemp
		inc dl
		int 10h

		mov ah, 09
		mov al, 219;ascii
		mov bh, 00
		mov bl, 00h;attribute
		mov cx, 1
		int 10h

		;DrawNewPos

		mov ah, 02
		mov bh, 00
		mov dh,	21
		mov dl, PlayerPos
		int 10h

		mov ah, 09
		mov al, 220;ascii
		mov bh, 00
		mov bl, 04h;attribute
		mov cx, 1
		int 10h

		mov ah, 02
		mov bh, 00
		mov dh,	22
		mov dl, PlayerPos
		dec	dl
		int 10h

		mov ah, 09
		mov al, 219;ascii
		mov bh, 00
		mov bl, 04h;attribute
		mov cx, 1
		int 10h

		mov ah, 02
		mov bh, 00
		mov dh,	22
		mov dl, PlayerPos
		int 10h

		mov ah, 09
		mov al, 219;ascii
		mov bh, 00
		mov bl, 04h;attribute
		mov cx, 1
		int 10h

		mov ah, 02
		mov bh, 00
		mov dh,	22
		mov dl, PlayerPos
		inc	dl
		int 10h

		mov ah, 09
		mov al, 219;ascii
		mov bh, 00
		mov bl, 04h;attribute
		mov cx, 1
		int 10h

		mov ah, PlayerPos
		mov PlayerPosTemp, ah

	;-------- end 1 char created

	POP DI
	POP SI
	POP BP
	POP AX ;no POP SP here, only ADD SP,2
	POP BX
	POP DX
	POP CX
	POP AX
	ret 	
DrawCar endp
end main