.model small
.data
.stack

    char db, "Enter a letter: $"
    yes db 10,"YES!$"
    no db 10,"Character is not equal to x$"
    
    val db ?

.code
    YEH:
        LEA DX, yes
        MOV AH, 9H
        INT 21H
        JMP EX
    AGAIN:
        LEA DX, no
        MOV AH, 9H
        INT 21H
        JMP START
START:
MAIN PROC

    MOV dl, 10
    MOV AH, 02h
    INT 21H
    
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, char
    MOV AH, 9H
    INT 21H
    
    MOV AH, 1H
    INT 21H
    
    
    MOV val, AL
    CMP val, 'x'
    JE YEH
    
    JNE AGAIN



EX:
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
END START
    