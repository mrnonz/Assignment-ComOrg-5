;hi non
;matrix2.asm ==== You can use this code on website http://pastebin.com/raw/8MaqeGWN
.model  tiny

	print_color macro
	   mov ax,0920h    ;AH=Function number AL=Space character  
	   mov cx,200      ; number of chars that will be painted
	   int 10h         ;BIOS function 09h
	   int 21h         ;DOS function 09h
	endm
	 
	dark_green macro
	   mov bl,02h      ;dark green color
	   print_color
	endm
	 
	bright_green macro
	   mov bl,0ah      ;bright green color
	   print_color
	endm
	 
	white macro
	   mov bl,0fh      ;white color
	   print_color
	endm
	 
	blue macro
	   mov bl,09       ;blue color
	   print_color
	endm
	 
	y_llo macro
	   mov bl,014      ;yello color
	   print_color
	endm
	 
	red macro
	   mov bl,04       ;red color
	   print_color
	endm

	mas macro
	   lea  dx, msg
	   dark_green
	endm

	mas2 macro
	   lea  dx, msg2
	   white
	endm


	mas3 macro
	   lea  dx, msg3
	   blue
	endm


	mas4 macro
	   lea  dx, msg4
	   y_llo
	endm


	mas5 macro
	   lea  dx, msg5
	   red
	endm


	mas6 macro
	   lea  dx, msg6
	   white
	endm

	mas7 macro
	   lea  dx, msg7
	   white
	endm

	mas8 macro
	   lea  dx, msg8
	   white
	endm

	mas9 macro
	   lea  dx, msg9
	   white
	endm

	mas10 macro
	   lea  dx, msg10
	   white
	endm

	mas11 macro
	   lea  dx, msg11
	   dark_green
	endm


	link_main macro
	 	jmp main
	endm

	link_EndGame macro
		jmp EndGame
	endm


	mas_L macro
	   lea  dx, msg_0L
	   red
	endm
	 
	print_str macro
	  mov     ah, 09h
	  int     21h
	endm
	 
	mas_0L macro
	  lea     dx, msg_0L
	  red
	endm
	;============ no color  ============
	 
	mas_1L macro
	  lea     dx, msg_1L
	  print_str
	endm
	 
	mas_2L macro
	   lea     dx, msg_2L
	   print_str
	endm
	 
	 
	mas_3L macro
	   lea     dx, msg_3L
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
	 
	;========== end no color ==========
	 
	mas_11L macro
	   lea  dx, msg_11L
	   red
	endm
	 
	;============ result ===============
	data_1 macro
	  val dw ?
	  msg_score db ""
	  decimal db "00000$"
	endm
	 
	data_2 macro
	   val_x dw ?
	   msg_x db ""
	   x db "00000$"
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
	 
	print_true macro
	    mas_2L
	    lea dx,msg_score
	    dark_green
	endm
	 
	grey macro
	   mov bl,07      ;white grey color
	   print_color
	endm
	 
	print_space macro
	    lea dx,msg_space
	    grey
	endm
	 
	print_false macro
	    print_space
	    mas_3L
	    lea dx,msg_x
	    red
	endm
	 
	print_numbers macro
	  mov     ax, 4c00h
	  int     21h
	endm
	 
	;============end result ===============
		
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
	 
	cls macro
	   mov     ah, 00h         ; Set to 80x25
	   mov     al, 03h
	   int     10h
	endm
	;---------------------------------------------------------------------------------------------------
.data
	data_1
	data_2

	msg  db 10,13,'============================[The  Matrix Game]=================================$'
	msg2 db 10,13,'                              [Choose Level]$'
	msg3 db 10,13,'                                a)Easy$'
	msg4 db 10,13,'                                b)Hard$'
	msg5 db 10,13,'                                c)Hell$'
	msg6 db 10,13,'                           Enter Level:$'
	msg7 db 10,13,'                          ...Exit press ESC...$'
	msg8 db 10,13,'                           Hello$'
	msg9 db 10,13,'                           Try again press(y):$'
	msg10 db 10,13,"      [Be careful with your characters fall to Blue line !!!! -0-]$"
	msg11 db 10,13,'===============================================================================$'


 
	msg_0L  db 10,13,'===============================   [END Game] ===================================$'
	msg_1L db 10,13,'                             ___________________$'                            
	msg_2L db 10,13,'                                   Score:$'                              
	msg_3L db 10,13,'                            typing Wrong:$'                              
	msg_4L db 10,13,'                             ___________________$'
	 
	;msg_5L db 10,13,' $'                              
	;msg_6L db 10,13,' $'                          
	;msg_7L db 10,13,' $'                        
	;msg_8L db 10,13,' $'                        
	msg_9L db 10,13,' $'      
	                   
	msg_10L db 10,13,'                               Esc to exit...$'
	msg_11L db 10,13,'===============================================================================$'
 	msg_space db ' $',0
;---------------------------------------------------------------------------------------------------  

	ColumnSt 	db 80 dup(0) ; Column Start
	ColumnCh 	db 80 dup(0) ; Column Char

	temp 	 	db 0
	tempChar 	db 0
	runColumn 	db 0

	Score 		db 0
	Wrong 		db 0
	HP 			db 9
	tempHP      db 9
	RunHP  		db 0

	Level 		db 0
	tempScore	db 0
	tempWrong	db 0

	savePress  	db 0

	skipColumn  db 10

	tempAh 		db 0

	SomeTune  dw 3043, 512	;g1
	dw 50, 128	;silent
	dw 3043, 512	;g1
	dw 50, 128	;silent
	dw 3043, 512	;g1
	dw 50, 128	;silent
	dw 3834, 512	;dis1
	dw 2559, 128	;ais1
	dw 3043, 512	;g1
	dw 50, 64	;silent
	dw 3834, 512	;dis1
	dw 2559, 128	;ais1
	dw 3043, 512	;g1
	dw 50, 256	;silent
	dw 2031, 512	;d2
	dw 50, 64	;silent
	dw 2031, 512	;d2
	dw 50, 64	;silent
	dw 2031, 512	;d2
	dw 50, 64	;silent
	dw 1917, 512	;dis2
	dw 2559, 128	;ais1
	dw 3224, 512	;fis1
	dw 50, 64	;silent
	dw 3834, 512	;dis1
	dw 2559, 128	;ais1
	dw 3043, 512	;g1
	dw 50, 64	;silent
	dw 1521, 512	;g2
	dw 50, 64	;silent
	dw 3043, 256	;g1
	dw 50, 8	;silent
	dw 3043, 256	;g1
	dw 50, 8	;silent
	dw 1521, 512	;g2
	dw 50, 128	;silent
	dw 3224, 512	;fis1
	dw 3416, 128	;f1
	dw 3619, 128	;e1
	dw 1917, 128	;dis2
	dw 3619, 512	;e1
	dw 50, 64	;silent
	dw 2873, 256	;gis1
	dw 2152, 512	;cis2
	dw 50, 32	;silent
	dw 2280, 512	;c2
	dw 4560, 128	;h1
	dw 2559, 128	;ais1
	dw 2711, 128	;a1
	dw 2559, 512	;ais1
	dw 50, 128	;silent
	dw 3834, 128	;dis1
	dw 3224, 512	;fis1
	dw 3834, 128	;dis1
	dw 3224, 256	;fis1
	dw 2559, 512	;ais1
	dw 3043, 128	;g1
	dw 2559, 256	;ais1
	dw 2031, 512	;d2
	dw 50, 64	;silent
	dw 1521, 512	;g2
	dw 50, 128	;silent
	dw 3043, 256	;g1
	dw 50, 8	;silent
	dw 3043, 256	;g1
	dw 50, 8	;silent
	dw 1521, 512	;g2
	dw 50, 128	;silent
	dw 1612, 512	;fis2
	dw 1715, 128	;f2
	dw 1809, 128	;e2
	dw 1917, 128	;dis2
	dw 1809, 512	;e2
	dw 50, 128	;silent
	dw 2873, 256	;gis1
	dw 2152, 512	;cis2
	dw 2280, 512	;c2
	dw 4560, 128	;h1
	dw 2559, 128	;ais1
	dw 2711, 128	;a1
	dw 2559, 512	;ais1
	dw 50, 128	;silent
	dw 3834, 128	;dis1
	dw 3224, 512	;fis1
	dw 3834, 128	;dis1
	dw 2559, 256	;ais1
	dw 3043, 512	;g1
	dw 3834, 128	;dis1
	dw 2559, 128	;ais1
	dw 3043, 512	;g1
	dw 50, 1024	;silent
	dw 00h,00h


	Sonic       dw 1355,32	;a3
	dw 1715,32	;f3
	dw 1355,32	;a3
	dw 1715,32	;f3
	dw 2415,32	;b3
	dw 1521,32	;g3
	dw 2415,32	;b3
	dw 1521,32	;g3
	dw 2280,32	;c3
	dw 1355,32	;a3
	dw 2280,32	;c3
	dw 1355,32	;a3
	dw 2031,32	;d3
	dw 2415,32	;b3
	dw 2031,32	;d3
	dw 2415,32	;b3
	dw 2280,32	;c3
	dw 2415,32	;b3
	dw 1355,32	;a3
	dw 1521,32	;g3
	dw 2280,32	;c3
	dw 2415,32	;b3
	dw 1355,32	;a3
	dw 1521,32	;g3
	dw 2280,32	;c3
	dw 2415,32	;b3
	dw 1355,32	;a3
	dw 1521,32	;g3
	dw 50,64;silent
	dw  00h,00h

	WrongSound    dw 3500, 10  
	dw 5000, 50
	dw 00h,00h

	CorrectSound dw 2500,20
	dw 00h,00h

	MissingSound dw 1000,20
	dw 50,8;silent
	dw 1000,20
	dw 00h,00h

.code
	org		0100h
main:

	mov     ah, 00h ; Set to 80x25
    mov     al, 03h
    int     10h
;--------- welcome message
set_rol:
    mov     ah, 02h         ; Move cursor XY
    mov     bh, 00h
    mov     dh, 5
    mov     dl, 0
    int     10h

  	mas
  	mas2
  	mas3
  	mas4
  	mas5
  	mas7
  	mas10
  	mas11
  	mas6
WaitSound:
	push ds
    pop  es
	mov  si, offset Sonic
           
    mov  dx,61h                  ; turn speaker on
    in   al,dx                   ;
    or   al,03h                  ;
    out  dx,al                   ;
    mov  dx,43h                  ; get the timer ready
    mov  al,0B6h                 ;
    out  dx,al                   ;


LoopIt: lodsw                        ; load desired freq.
        or   ax,ax                   ; if freq. = 0 then done
        jz   short LDone             ;

        mov  tempAh, ah

        mov 	ah,1h
  		int 	16h

  		jnz		WaitType

  		mov ah, tempAh

        mov  dx,42h                  ; port to out
        out  dx,al                   ; out low order
        xchg ah,al                   ;
        out  dx,al                   ; out high order
        lodsw                        ; get duration
        mov  cx,ax                   ; put it in cx (16 = 1 second)
        call PauseIt                 ; pause it
        jmp  short LoopIt

LDone:  mov  dx,61h                  ; turn speaker off
        in   al,dx                   ;
        and  al,0FCh                 ;
        out  dx,al                   ;
        jmp  WaitSound
WaitType:
  	;mov 	ah,1h
  	;int 	16h

  	;jz		WaitType

  	mov		ah, 00h
	int 	16h

	cmp 	al,'a'          ;a for Easy
  	je 		SetLevel0

  	cmp 	al,'A'          ;a for Easy
  	je 		SetLevel0

  	cmp 	al,'b'          ;a for Hard
  	je 		SetLevel1

  	cmp 	al,'B'          ;a for Hard
  	je 		SetLevel1

  	cmp 	al,'c'          ;a for Hell
  	je 		SetLevel2

  	cmp 	al,'C'          ;a for Hell
  	je 		SetLevel2

  	cmp 	al,1BH          ;Esc for exit
  	je 		exit2

exit2:

	mov  dx,61h                  ; turn speaker off
    in   al,dx                   ;
    and  al,0FCh                 ;
    out  dx,al                   ;

	mov 	ah, 4ch
	int 	21h
SetLevel0:
	mov 	Level, 0
	jmp		SetPointer
SetLevel1:
	mov 	Level, 1
	jmp		SetPointer
SetLevel2:
	mov 	Level, 2
	jmp		SetPointer
SetPointer:
	mov  dx,61h                  ; turn speaker off
    in   al,dx                   ;
    and  al,0FCh                 ;
    out  dx,al                   ;

;--------- set pointer -------------
	mov     ah, 00h ; Set to 80x25
    mov     al, 03h
    int     10h

	mov 	si, offset ColumnSt
	mov 	di, offset ColumnCh
	mov 	temp, 0
;input:
;	mov 	ah, 01h
;	int 	16h
;
;	jz 		main; not press
;
;	mov		ah, 00h
;	int 	16h

root:
;--------- random first start ------
	mov 	ax, 10 ; random row in Column to fall
	int 	62h

	mov 	byte ptr [si], al ; create position to fall
	inc 	si
;------------ char
	mov 	ax, 75 ; random Char
	int 	62h
	add 	ax, 48

	mov 	byte ptr [di], al
	inc 	di
	inc 	temp

	cmp 	temp, 80
	jne 	root

	mov 	si, offset ColumnSt
	mov 	di, offset ColumnCh

loopCreate: ; use for create long text
	; -------- prepare for create text
	mov 	dh, [si]
	mov 	temp, dh
	; -------- print char to screen

	mov 	ah, 02h ; set cursor
	mov 	dh, temp
	mov 	dl, runColumn
	int 	10h

	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov 	al, [di]
	mov 	bh, 0
	mov		bl, 00fh ; color
	mov		cx, 1
	int		10h

	dec 	temp
	; -------- print char to screen
	mov 	ah, 02h ; set cursor
	mov 	dh, temp
	mov 	dl, runColumn
	int 	10h

	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov 	al, [di]
	mov		bx, 007h ; color
	mov		cx, 1
	int		10h

	dec 	temp
	; -------- print char to screen
	mov 	ah, 02h ; set cursor
	mov 	dh, temp
	mov 	dl, runColumn
	int 	10h

	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov 	al, [di]
	mov		bx, 00Ah ; color
	mov		cx, 1
	int		10h
	
	dec 	temp
	; -------- print char to screen
	mov 	ah, 02h ; set cursor
	mov 	dh, temp
	mov 	dl, runColumn
	int 	10h

	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov 	al, [di]
	mov		bx, 00Ah ; color
	mov		cx, 1
	int		10h
	
	dec 	temp
	; -------- print char to screen
	mov 	ah, 02h ; set cursor
	mov 	dh, temp
	mov 	dl, runColumn
	int 	10h

	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov 	al, [di]
	mov		bx, 00Ah ; color
	mov		cx, 1
	int		10h
	
	dec 	temp
	; -------- print char to screen
	mov 	ah, 02h ; set cursor
	mov 	dh, temp
	mov 	dl, runColumn
	int 	10h

	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov 	al, [di]
	mov		bx, 002h ; color
	mov		cx, 1
	int		10h
	
	dec 	temp
	; -------- print char to screen
	mov 	ah, 02h ; set cursor
	mov 	dh, temp
	mov 	dl, runColumn
	int 	10h

	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov 	al, [di]
	mov		bx, 002h ; color
	mov		cx, 1
	int		10h
	
	dec 	temp
	; -------- print char to screen
	mov 	ah, 02h ; set cursor
	mov 	dh, temp
	mov 	dl, runColumn
	int 	10h

	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov 	al, [di]
	mov		bx, 008h ; color
	mov		cx, 1
	int		10h
	
	dec 	temp

	; -------- fall Char
	inc 	byte ptr [si]
	mov 	dh, [si]
	cmp 	dh, 23
	jne 	NextFall
MissType:
;------------- Check Miss Char
	dec 	HP
	cmp 	HP, 0
	je 		EndGame
;--------- random first start ------
	mov 	ax, 10 ; random row in Column to fall
	int 	62h

	mov 	byte ptr [si], al ; create position to fall
	inc 	si
;------------ char
	mov 	ax, 75 ; random Char
	int 	62h
	add 	ax, 48

	mov 	byte ptr [di], al

	

NextFall:
	; -------- next Column
	inc 	si
	inc 	di

	mov 	dl, skipColumn
	add 	runColumn, dl ; skip column

	; -------- last column of screen
	cmp 	runColumn, 80
	jge 	gotoCreateLine

	jmp 	loopCreate ; back to create next column
gotoCreateLine:
	jmp 	createLine
EndGame:
	cls 
;---------- Show last screen
	mov     ah, 02h         ; Move cursor XY
    mov     bh, 00h
    mov     dh, 5
    mov     dl, 0
    int     10h

	mas_0L
  	mas_1L
 
	;===========Answer==================
	mov 	dl, Score
	correct_score
	print_true
	 
	mov 	dl, Wrong
	wrong_score
	print_false
	;===========END Answer==================
	mas_4L
	mas_9L
	mas_10L
	mas_11L

	; ========= Sound end game
EndSound:
	push ds
    pop  es
	mov  si, offset SomeTune
           
    mov  dx,61h                  ; turn speaker on
    in   al,dx                   ;
    or   al,03h                  ;
    out  dx,al                   ;
    mov  dx,43h                  ; get the timer ready
    mov  al,0B6h                 ;
    out  dx,al                   ;


LoopItE: lodsw                        ; load desired freq.
        or   ax,ax                   ; if freq. = 0 then done
        jz   short LDoneE             ;

        mov  tempAh, ah

        mov 	ah,1h
  		int 	16h

  		jnz		CloseGame

  		mov ah, tempAh

        mov  dx,42h                  ; port to out
        out  dx,al                   ; out low order
        xchg ah,al                   ;
        out  dx,al                   ; out high order
        lodsw                        ; get duration
        mov  cx,ax                   ; put it in cx (16 = 1 second)
        call PauseIt                 ; pause it
        jmp  short LoopItE

LDoneE:  mov  dx,61h                  ; turn speaker off
        in   al,dx                   ;
        and  al,0FCh                 ;
        out  dx,al                   ;
        jmp  EndSound
	; ========= Sound
CloseGame:
	mov  	ah, 00h
  	int  	16h
	cmp  	al,1BH                   ;Esc for clear screen
  	je 	 	goExit

goExit:
	jmp 	exit
createLine:
	mov 	runColumn, 0 ; set var for runColumn
LineLoop:
	; -------- print -- to screen
	mov 	ah, 02h ; set cursor
	mov 	dh, 23
	mov 	dl, runColumn
	int 	10h

	mov 	ax, '-'
	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov		bh, 0
	mov 	bl, 0BBh; color
	mov		cx, 1
	int		10h

	inc 	runColumn
	cmp 	runColumn, 80
	jne 	LineLoop

	mov 	runColumn, 24
HPLine:
	; -------- print -- to screen
	mov 	ah, 02h ; set cursor
	mov 	dh, 24
	mov 	dl, runColumn
	int 	10h

	mov 	ax, 'H'
	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov		bh, 0
	mov 	bl, 004h; color
	mov		cx, 1
	int		10h
	inc 	runColumn

	mov 	ah, 02h ; set cursor
	mov 	dh, 24
	mov 	dl, runColumn
	int 	10h

	mov 	ax, 'P'
	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov		bh, 0
	mov 	bl, 004h; color
	mov		cx, 1
	int		10h
	inc 	runColumn

	mov 	ah, 02h ; set cursor
	mov 	dh, 24
	mov 	dl, runColumn
	int 	10h

	mov 	ax, ' '
	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov		bh, 0
	mov 	bl, 004h; color
	mov		cx, 1
	int		10h
	inc 	runColumn

	mov 	ah, 02h ; set cursor
	mov 	dh, 24
	mov 	dl, runColumn
	int 	10h

	mov 	ax, ':'
	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov		bh, 0
	mov 	bl, 004h; color
	mov		cx, 1
	int		10h
	inc 	runColumn
;-------- RunHP
	mov 	al, HP
	mov 	RunHP, al
createHP:
	;--------- check HP for play sound
	mov 	al, tempHP
	cmp 	al, HP
	je 		createHPbar

	mov 	al, HP
	mov 	tempHP, al
	call 	MissTypingSound
	;--------- END play sound
createHPbar:
	mov 	ah, 02h ; set cursor
	mov 	dh, 24
	mov 	dl, runColumn
	int 	10h

	mov 	ax, '='
	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov		bh, 0
	mov 	bl, 0EEh; color
	mov		cx, 1
	int		10h

	inc 	runColumn

	mov 	ah, 02h ; set cursor
	mov 	dh, 24
	mov 	dl, runColumn
	int 	10h

	mov 	ax, '='
	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov		bh, 0
	mov 	bl, 0EEh; color
	mov		cx, 1
	int		10h

	inc 	runColumn
	dec 	RunHP

	cmp 	RunHP, 0
	jne 	createHP

	;-------print Wrong
	mov 	ah, 02h ; set cursor
	mov 	dh, 24
	mov 	dl, 0
	int 	10h

	mov 	al, Wrong
	add 	al, '0'
	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov		bh, 0
	mov 	bl, 0CCh; color
	mov		cx, 1
	int		10h

	;-------print Score
	mov 	ah, 02h ; set cursor
	mov 	dh, 24
	mov 	dl, 79
	int 	10h

	mov 	al, Score
	add 	al, '0'
	mov 	ah, 09h ; Write Character and Attribute at Current Cursor Position
	mov		bh, 0
	mov 	bl, 0AAh; color
	mov		cx, 1
	int		10h
input:
	mov 	ah, 01h
	int 	16h

	jz 		clear; not press

	mov		ah, 00h
	int 	16h
	mov 	savePress, al
	cmp     savePress, 1bh ;Esc for exit
	je 		gogoEndGame


	call 	checkAns
clear:
	; clear column to zero
	mov 	runColumn, 0
	mov 	si, offset ColumnSt
	mov 	di, offset ColumnCh

	; -------- depay time
	cmp 	Level, 0
	je 		DelayLevel0

	cmp 	Level, 1
	je 		DelayLevel1

	cmp 	Level, 2
	je 		DelayLevel2	
gogoEndGame:
	link_EndGame
DelayLevel0:
	mov     cx, 0Ah		; add 16 = 1sec delay
	mov     dx, 2120h
	mov     ah, 86h
	int     15h

	jmp 	clearScreen
DelayLevel1:
	mov     cx, 07h		; add 16 = 1sec delay
	mov     dx, 2120h
	mov     ah, 86h
	int     15h

	jmp 	clearScreen
DelayLevel2:
	mov     cx, 04h		; add 16 = 1sec delay
	mov     dx, 2120h
	mov     ah, 86h
	int     15h

	jmp 	clearScreen
clearScreen:
	mov     ah, 00h ; Set to 80x25
    mov     al, 03h
    int     10h

	jmp 	loopCreate
checkAns:
	mov 	dl, Score
	mov 	tempScore, dl
	mov 	temp, 0
	mov 	runColumn, 0
	mov 	si, offset ColumnSt
	mov 	di, offset ColumnCh
LoopcheckAns:
	mov 	al, savePress
	cmp 	[di], al
	jne 	NextCheck

; Correct Zone
	call 	CorrectZone
	inc 	Score
	;--------- random first start ------
	mov 	ax, 10 ; random row in Column to fall
	int 	62h

	mov 	byte ptr [si], al ; create position to fall
	;inc 	si
	;------------ char
	mov 	ax, 75 ; random Char
	int 	62h
	add 	ax, 48

	mov 	byte ptr [di], al
	;inc 	di
NextCheck:
	inc 	si
	inc 	di
	mov 	dl, skipColumn
	add 	temp, dl
	cmp		temp, 80
	jl 		LoopcheckAns

	mov 	dl, Score
	cmp 	dl, tempScore
	jne 	retNext

	call 	WrongTyping
	inc 	Wrong
retNext:
	ret
gotoEndGame:
	link_EndGame
exit:

	mov  dx,61h                  ; turn speaker off
    in   al,dx                   ;
    and  al,0FCh                 ;
    out  dx,al                   ;

	mov     ah, 00h         ; Set to 80x25
   	mov     al, 03h
   	int     10h

	mov 	ah, 4ch
	int 	21h

; =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
; This routine waits for a specified amount of milliseconds (within 50ms)
; Since I want to keep it simple, I am going to use the BIOS timer tick
;  at 0040:006Ch. It increments 18.2 times a second.
;   (1000 milliseconds divided by 18.2 = ~55ms)
; This is not a very good delay.  Depending on when it is called,
;  it could delay up to 110ms.  However it will always delay at
;  least 55ms.
; If you do much with this, you will need a much better delay routine.
;  You can code a delay using the RDTSC instruction, if you know you
;  have a CPU that supports that instruction (all modern CPU's do).
; There are many other delay techniques to choose from.
PauseIt proc near uses ax cx es
        mov  ax,0040h
        mov  es,ax

        ; wait for it to change the first time
        mov  al,es:[006Ch]
@a:     cmp  al,es:[006Ch]
        je   short @a

        ; wait for it to change again
loop_it:mov  al,es:[006Ch]
@b:     cmp  al,es:[006Ch]
        je   short @b

        sub  cx,55
        jns  short loop_it

        ret
PauseIt endp


WrongTyping:
	
	; ========= Sound Wrong Typing
		push ds
        pop  es
        mov  si, offset WrongSound
           
        mov  dx,61h                  ; turn speaker on
        in   al,dx                   ;
        or   al,03h                  ;
        out  dx,al                   ;
        mov  dx,43h                  ; get the timer ready
        mov  al,0B6h                 ;
        out  dx,al                   ;
LoopItW: lodsw                        ; load desired freq.
        or   ax,ax                   ; if freq. = 0 then done
        jz   short LDoneW             ;
        mov  dx,42h                  ; port to out
        out  dx,al                   ; out low order
        xchg ah,al                   ;
        out  dx,al                   ; out high order
        lodsw                        ; get duration
        mov  cx,ax                   ; put it in cx (16 = 1 second)
        call PauseIt                 ; pause it
        jmp  short LoopItW

LDoneW:  mov  dx,61h                  ; turn speaker off
        in   al,dx                   ;
        and  al,0FCh                 ;
        out  dx,al                   ;
	; ========= Sound
	ret 
CorrectZone PROC
	PUSH AX
	PUSH CX
	PUSH DX
	PUSH BX
	PUSH SP ; The value stored is the initial SP value
	PUSH BP
	PUSH SI
	PUSH DI
	; ========= Sound Correct Typing
		push ds
        pop  es
        mov  si, offset CorrectSound
           
        mov  dx,61h                  ; turn speaker on
        in   al,dx                   ;
        or   al,03h                  ;
        out  dx,al                   ;
        mov  dx,43h                  ; get the timer ready
        mov  al,0B6h                 ;
        out  dx,al                   ;
LoopItC: lodsw                        ; load desired freq.
        or   ax,ax                   ; if freq. = 0 then done
        jz   short LDoneC             ;
        mov  dx,42h                  ; port to out
        out  dx,al                   ; out low order
        xchg ah,al                   ;
        out  dx,al                   ; out high order
        lodsw                        ; get duration
        mov  cx,ax                   ; put it in cx (16 = 1 second)
        call PauseIt                 ; pause it
        jmp  short LoopItC

LDoneC:  mov  dx,61h                  ; turn speaker off
        in   al,dx                   ;
        and  al,0FCh                 ;
        out  dx,al                   ;
	; ========= Sound
	POP DI
	POP SI
	POP BP
	POP AX ;no POP SP here, only ADD SP,2
	POP BX
	POP DX
	POP CX
	POP AX
	ret 
CorrectZone endp

MissTypingSound PROC
	PUSH AX
	PUSH CX
	PUSH DX
	PUSH BX
	PUSH SP ; The value stored is the initial SP value
	PUSH BP
	PUSH SI
	PUSH DI
	; ========= Sound MissTypingSound Typing
		push ds
        pop  es
        mov  si, offset MissingSound
           
        mov  dx,61h                  ; turn speaker on
        in   al,dx                   ;
        or   al,03h                  ;
        out  dx,al                   ;
        mov  dx,43h                  ; get the timer ready
        mov  al,0B6h                 ;
        out  dx,al                   ;
LoopItM: lodsw                       ; load desired freq.
        or   ax,ax                   ; if freq. = 0 then done
        jz   short LDoneM            ;
        mov  dx,42h                  ; port to out
        out  dx,al                   ; out low order
        xchg ah,al                   ;
        out  dx,al                   ; out high order
        lodsw                        ; get duration
        mov  cx,ax                   ; put it in cx (16 = 1 second)
        call PauseIt                 ; pause it
        jmp  short LoopItM

LDoneM:  mov  dx,61h                 ; turn speaker off
        in   al,dx                   ;
        and  al,0FCh                 ;
        out  dx,al                   ;
	; ========= Sound
	POP DI
	POP SI
	POP BP
	POP AX ;no POP SP here, only ADD SP,2
	POP BX
	POP DX
	POP CX
	POP AX
	ret 
MissTypingSound endp
end main