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
 	val dw ?
	msg_score db ""
	decimal db "00000$"
	val_x dw ?
	msg_x db ""
	x db "00000$"
	Score 		db 0
	Wrong 		db 0

	IsPlayerWin	db 0
	win		db "                                                                                "
			db "      ",219,219,"    ",219,219,"   ",219,219,"",219,219,"",219,219,"   ",219,219,"    ",219,219,"            ",219,219,"  ",219,219,"  ",219,219,"  ",219,219,"",219,219,"",219,219,"  ",219,219,"    ",219,219,"      "
			db "       ",219,219,"  ",219,219,"   ",219,219,"    ",219,219,"  ",219,219,"    ",219,219,"            ",219,219,"  ",219,219,"  ",219,219,"    ",219,219,"    ",219,219,"",219,219,"  ",219,219,"      "
			db "        ",219,219,"",219,219,"    ",219,219,"    ",219,219,"  ",219,219,"    ",219,219,"            ",219,219,"  ",219,219,"  ",219,219,"    ",219,219,"    ",219,219," ",219,219," ",219,219,"      "
			db "         ",219,219,"     ",219,219,"    ",219,219,"  ",219,219,"    ",219,219,"            ",219,219,"  ",219,219,"  ",219,219,"    ",219,219,"    ",219,219,"  ",219,219,"",219,219,"      "
			db "         ",219,219,"     ",219,219,"    ",219,219,"  ",219,219,"    ",219,219,"             ",219,219,"",219,219,"",219,219,"",219,219,"     ",219,219,"    ",219,219,"   ",219,219,219,"       "
			db "         ",219,219,"      ",219,219,"",219,219,"",219,219,"    ",219,219,"",219,219,"",219,219,"               ",219,219,"  ",219,219,"    ",219,219,"",219,219,"",219,219,"  ",219,219,"    ",219,219,"      "
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

end main