.model tiny
.data
    ; 0-9//10-54//55-79
	message db "Hello world!!$"
    time db ?,"$"
    t db "$"
.code
	;org  100h
main:
	

    mov ax,  @data
    mov ds, ax
    ;clear screen
    xor dx, dx
        
    mov ah, 00
    mov al, 03
    int 10h

    mov dx, offset message
    call printf

    mov ah, 2Ch
    int 21h
    mov time,dh
    mov dx, offset time
	call printf
	.exit


; print
printf proc near ;lea dx, message / mov dx,offset message

    mov ah,09h
    int 21h 

    ret
printf endp
; /print

;right
displayright proc near
    pusha
    


    ret
displayright endp
;/right

end main