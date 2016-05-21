.model tiny
.data
	PlayerPos 	db 33;24-42 
	PlayerPosTemp	db 33 		
	Road		db 7 dup (-5)


.code
	org 0100h
main:

	mov ah, 00
	mov al, 03
	int 10h

	InfinitLoop:
	
	call DrawPlayer
	call Input
	
	jmp InfinitLoop
	;mov ah, 00
	;int 16h

	;MOV AH, 4CH                  ; RETURN CONTROL TO DOS
	;INT 21H
	ret

	BotSpawn proc
		PUSH AX
		PUSH CX
		PUSH DX
		PUSH BX
		PUSH SP ; The value stored is the initial SP value
		PUSH BP
		PUSH SI
		PUSH DI
		
		mov ax, 7
		int 62h

		

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

	Input proc
		PUSH AX
		PUSH CX
		PUSH DX
		PUSH BX
		PUSH SP ; The value stored is the initial SP value
		PUSH BP
		PUSH SI
		PUSH DI

		mov     ah, 01H         ;input from keyboard
        int     16h

        jnz MeeInput
        	jmp retInput
        MeeInput:

        cmp al,'d'
        jne NotLeft
        	cmp PlayerPos,42
        	je NotLeft
        	add PlayerPos,1
        NotLeft:

        cmp al,'a'
        jne NotRight
        	cmp PlayerPos,24
        	je NotRight
        	add PlayerPos,-1
        NotRight:

        mov ah, 0ch             ;clear buffer
        mov al, 0
        int 21h

        retInput:
		POP DI
		POP SI
		POP BP
		POP AX ;no POP SP here, only ADD SP,2
		POP BX
		POP DX
		POP CX
		POP AX
		ret
	Input endp

	DrawPlayer proc
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

        MOV     CX, 01H     ; add 16 = 1sec delay
        MOV     DX, 400H
        MOV     AH, 86H
        INT     15H

		mov ah, PlayerPos
		mov PlayerPosTemp, ah

		POP DI
		POP SI
		POP BP
		POP AX ;no POP SP here, only ADD SP,2
		POP BX
		POP DX
		POP CX
		POP AX
		ret
	DrawPlayer endp
end main