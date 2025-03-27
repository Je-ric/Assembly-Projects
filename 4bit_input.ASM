.model small
.data
.stack

	char db 13,10,13,10, "Enter 4 Bits: $"
    	exitMessage db, "Ok Bye $" 
	ms1 db 10,13,"Hexa:$"
	op_choose db 13,10,        'Try Again (y/n): $'
    	hexa db ?	
value db ? 

.code
again:
	mov ax, @data
        mov ds, ax
	
	mov dx, OFFSET char           ;print "input1"
        mov ah, 09h
        int 21h

	mov ah, 01h                      ;get input from the user for "input1"
        int 21h	
	mov ah, 01h                      ;get input from the user for "input1"
        int 21h
	mov ah, 01h                      ;get input from the user for "input1"
        int 21h
	mov ah, 01h                      ;get input from the user for "input1"
        int 21h
      
	mov dx, OFFSET ms1       
        mov ah, 09h
        int 21h

operation_sign: 
        
        LEA DX, op_choose
        MOV AH, 9H
        INT 21H
      
        MOV AH, 1H
        INT 21H
     
	cmp al, 'y'
	je again
	cmp al, 'n'
	jne again
	cmp al, 'n'
        je exit   

exit:                           ;terminates the program
        mov ah, 09h
        mov dx, OFFSET exitMessage
        int 21h 
   
EX:
    MOV AH, 4CH
    INT 21H

end
	.exit


