.model tiny
.data
	IsPlayerWin	db 0
	win		db "                                                                                "
			db "      ",219,219,"    ",219,219,"   ",219,219,"",219,219,"",219,219,"   ",219,219,"    ",219,219,"            ",219,219,"  ",219,219,"  ",219,219,"  ",219,219,"",219,219,"",219,219,"  ",219,219,"    ",219,219,"      "
			db "       ",219,219,"  ",219,219,"   ",219,219,"    ",219,219,"  ",219,219,"    ",219,219,"            ",219,219,"  ",219,219,"  ",219,219,"    ",219,219,"    ",219,219,"",219,219,"  ",219,219,"      "
			db "        ",219,219,"",219,219,"    ",219,219,"    ",219,219,"  ",219,219,"    ",219,219,"            ",219,219,"  ",219,219,"  ",219,219,"    ",219,219,"    ",219,219," ",219,219," ",219,219,"      "
			db "         ",219,219,"     ",219,219,"    ",219,219,"  ",219,219,"    ",219,219,"            ",219,219,"  ",219,219,"  ",219,219,"    ",219,219,"    ",219,219,"  ",219,219,"",219,219,"      "
			db "         ",219,219,"     ",219,219,"    ",219,219,"  ",219,219,"    ",219,219,"             ",219,219,"",219,219,"",219,219,"",219,219,"     ",219,219,"    ",219,219,"   ",219,219,219,"       "
			db "         ",219,219,"      ",219,219,"",219,219,"",219,219,"    ",219,219,"",219,219,"",219,219,"               ",219,219,"  ",219,219,"    ",219,219,"",219,219,"",219,219,"  ",219,219,"    ",219,219,"      "
			db "                                                                                "
			db "                                                                                "
			db "                                                                                "
			db "                                                                                "
			db "                                                                                "
			db "                                                                                "
			db "                                                                                "
			db "                                                                                "
			db "                                                                                "
			db "                                                                                "
			db "                                                                                "
			db "                             Press any Key to continues                         "
			db "                                                                                $"
			

	lose	db "                                                                                "
			db "      ",219,219,"    ",219,219,"   ",219,219,"",219,219,"",219,219,"   ",219,219,"    ",219,219,"      ",219,219,"       ",219,219,"",219,219,"",219,219,"    ",219,219,"",219,219,"",219,219,"   ",219,219,"",219,219,"",219,219,"      "
			db "       ",219,219,"  ",219,219,"   ",219,219,"    ",219,219,"  ",219,219,"    ",219,219,"      ",219,219,"      ",219,219,"    ",219,219,"  ",219,219,"        ",219,219,"          "
			db "        ",219,219,"",219,219,"    ",219,219,"    ",219,219,"  ",219,219,"    ",219,219,"      ",219,219,"      ",219,219,"    ",219,219,"   ",219,219,"",219,219,"",219,219,"   ",219,219,"",219,219,"        "
			db "         ",219,219,"     ",219,219,"    ",219,219,"  ",219,219,"    ",219,219,"      ",219,219,"      ",219,219,"    ",219,219,"        ",219,219,"  ",219,219,"          "
			db "         ",219,219,"     ",219,219,"    ",219,219,"  ",219,219,"    ",219,219,"      ",219,219,"      ",219,219,"    ",219,219,"  ",219,219,"    ",219,219,"  ",219,219,"          "
			db "         ",219,219,"      ",219,219,"",219,219,"",219,219,"    ",219,219,"",219,219,"",219,219,"       ",219,219,"",219,219,"",219,219,"   ",219,219,"",219,219,"",219,219,"    ",219,219,"",219,219,"",219,219,"   ",219,219,"",219,219,"",219,219,"      "
			db "                                                                                "
			db "                                                                                "
			db "                                                                                "
			db "                                                                                "
			db "                                                                                "
			db "                                                                                "
			db "                                                                                "
			db "                                                                                "
			db "                                                                                "
			db "                                                                                "
			db "                                                                                "
			db "                             Press Any Key To Continues                         "
			db "                                                                                $"
			
.code
	org		0100h

main:

EndGame:

	mov     ah, 00h ; Set to 80x25
    mov     al, 03h
    int     10h

    cmp IsPlayerWin, 1 	;if 1 show win else show lose
    je WinEnd

    call LoseScreenEnd
    jmp  ExitGame
    
    WinEnd:
    call WinScreenEnd
    ExitGame:
    
    

    mov ah,00
    int 16h

    MOV AH, 4CH                  ; RETURN CONTROL TO DOS
    INT 21H

WinScreenEnd proc near
	
	mov		ah,2
	mov		bh,0
	mov 	dh,3
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
	mov 	dh,3
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
	mov 	dh,3
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
	mov 	dh,3
	mov		dl,0
	int 10h

	mov		ah, 09
	mov 	dx, offset lose
	int 21h

	ret

	ret
LoseScreenEnd endp

end main