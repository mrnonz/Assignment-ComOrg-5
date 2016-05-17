.model tiny

.data
	ObjStreet 	db	25	dup(0)
	temp		db 	0
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

		
		inc 	temp

		cmp		temp, 25
		jne		jmpLcreateLine

	CreateObj:

	mov		si, offset ObjStreet

InfLoop:
	jmp InfLoop


end main