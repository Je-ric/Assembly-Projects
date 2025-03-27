.MODEL SMALL
.STACK
.DATA

    ;string for displaying message
    MESSAGE DB 'Enter a 4-bit number: $'
    RESULT DB 'Hexa: $'
    PROMPT DB 10, 'Try Again [Y]/[N]?  $'

    VALUE DB ?

.CODE
START:
    MOV AX, @DATA
    MOV DS, AX

CLEAR:
    MOV AH, 2
    MOV DL, 0DH
    INT 21H

    MOV DL, 0AH
    INT 21H

    LEA DX, MESSAGE
    MOV AH, 9
    INT 21H

    XOR BH, BH

INPUT:
    MOV AH, 1
    INT 21H

    MOV CH, AL

    CMP CH, 0DH
    JE PRINT

    CMP CH, '0'
    JL  EXIT

    CMP CH, '1'
    JG EXIT

    AND CH, 15
    SHL BH, 1
    OR BH, CH

    JMP INPUT

PRINT:
    MOV AH, 9
    LEA DX, RESULT
    INT 21H

    MOV AH, 2

    CMP BH, 9
    JLE NUMBER

CHARACTER:
    ADD BH, 55
    MOV AH, 2
    MOV DL, BH
    INT 21H
    JMP AGAIN

NUMBER:
    ADD BH, 48
    MOV AH, 2
    MOV DL, BH
    INT 21H
    JMP AGAIN

AGAIN:
    MOV AH, 9
    LEA DX, PROMPT
    INT 21H

    MOV AH, 1
    INT 21H

    MOV CH, AL

    CMP CH, 'y'
    JE START
    JNE EXIT

EXIT:
    MOV AH, 4CH
    INT 21H


END START
