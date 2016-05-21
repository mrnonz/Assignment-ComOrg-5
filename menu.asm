.model tiny

.data
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

	mov     ah, 00h ; Set to 80x25
    mov     al, 03h
    int     10h

    MOV AH, 4CH                  ; RETURN CONTROL TO DOS
    INT 21H
end main