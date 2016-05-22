.model tiny

.data
	tempProc	db 	0
	temp2		db 	0
	temp		db 	0
	PoCarBar	db  23 ; for Position of Car on Left-bar
	PoCar 		db 	23 ; for Position of Car on Street
	PlayerPos	db	33 ; 24-42
	PlayerPosTemp db 33
	BotPosTemp	db  5,27	
	multi		db 	3
	BotPos		db	42 dup (-1)	;24-42
	CountFrame 	db 	0
	CountSpawn	dw  0 ;0-3
.code
	org		0100h
main:

	mov     ah, 00h ; Set to 80x25
    mov     al, 03h
    int     10h

ScreenZone:

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

		jmp 	skiptomain
		tomain:
		jmp 	main
		skiptomain:

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

		call	DrawScore
		call	DrawHiScore
		;call	BotSpawn
		call	DrawCar
		;call 	DrawBotCar
		;call	DrawAllBot

		mov     cx, 03h		; add 16 = 1sec delay
		mov     dx, 2120h
		mov     ah, 86h
		int     15h

		inc 	CountFrame
		cmp		CountFrame,25
		jl 		skipCountFrame

		dec 	PoCarBar
		mov 	CountFrame, 0
		skipCountFrame:

		cmp 	PoCarBar, 0
		jne 	tomain

RandomBot PROC
	PUSH AX
	PUSH CX
	PUSH DX
	PUSH BX
	PUSH SP ; The value stored is the initial SP value
	PUSH BP
	PUSH SI
	PUSH DI

	mov si,24
	RunTo42:
		cmp BotPos[si], 0
		jae skipAddBot

			mov ax, 5
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
		cmp BotPos[si], 0
		jb	skipDrawBot
			mov ah, BotPos[si]
			mov BotPosTemp[0], ah
			mov ax, si
			mov BotPosTemp[1], al
			call DrawBotCar

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