.model small
.stack 100h
.data

;Messages that displayed for the user
first_number_choice db 10,13,        'Addition - a'
                    db 10,13,        'Subtraction - s'
                    db 10,13,        'Multiplication - m'
                    db 10,13,        'Division - d'
                    db 10,13,        'Quit - q'
           
           
input_1             db 13,10,13,10,  'First number : $'
           
input_2             db 13,10,        'Second number : $'



op_choose           db 13,10,        'Choose the operation : $'


addi                db 13,10,13,10,  ' Addition is equal to : $'
soustrac            db 13,10,13,10,  ' Subtraction is equal to : $'
multipli            db 13,10,13,10,  ' Multiplication is equal to : $'
divi                db 13,10,13,10,  ' Division is equal to : $'

.code
       
beginning1:

        MOV AX, @DATA ; Set the data segment
        MOV DS, AX    ; initialize the data segment
    
        LEA DX, first_number_choice
        MOV AH, 9H ; Print the first_number_choice message
        INT 21H 
        MOV BX, 0 ; Reset the register
   
beginning2:
    
        MOV AH, 1H ; Read a single character from keyboard
        INT 21H
        CMP AL, 0DH ; Check if the input is Enter(carriage return)
        JE input1
    
        MOV AH, 0
        SUB AL, 30H  ; Convert the character to decimal by subtracting 0
        PUSH AX
        MOV AX, 10
        MUL BX 
        POP BX       ; Get the value stored in BX
        ADD BX, AX
        JMP beginning2
        
input1:

        PUSH BX
        LEA  DX, input_2 
        MOV  AH, 9H
        INT  21H
        MOV  BX, 0
       
next:
    
        MOV AH, 1H
        INT 21H
        CMP AL, 0DH
        JE operation_sign
      
        MOV AH, 0
        SUB AL, 30H 
        PUSH AX
        MOV AX, 10
        MUL BX
        POP BX
        ADD BX, AX
        JMP next  
        
operation_sign: 
        
        LEA DX, op_choose
        MOV AH, 9H
        INT 21H
      
        MOV AH, 1H
        INT 21H
      

        ;Compare the input with each operation choice
        CMP AL, 'a'
        JE addition 
      
        CMP AL, 's'
        JE subtraction
      
        CMP AL, 'm'
        JE multiplication
      
        CMP AL, 'd'
        JE division
      
        CMP AL, 'q'
        MOV AH, 4CH
        INT 21H

addition:

        POP AX ; Get the 2 input numbers from the stack
        ADD AX, BX ; Perform the addition operation
        PUSH AX
        LEA DX, addi ; print the result message
        MOV AH, 9H
        INT 21H
        POP AX
        MOV CX, 0 ; Reset the counter register
        MOV DX, 0 ; Reset the data register
        MOV BX, 10
        JMP conv

      
subtraction: 

        POP AX  ;Get the 2 input numbers from the stack
        SUB AX, BX  ;Perform the subtraction operation
        PUSH AX
        LEA DX, soustrac    ; print the result message
        MOV AH, 9H
        INT 21H
        POP AX
        MOV CX, 0   ;Reset the counter register
        MOV DX, 0   ;Reset the data register
        MOV BX, 10 
        JMP conv     


multiplication:

        POP AX  ;Get the 2 input numbers from the stack
        MUL BX  ;Perform the subtraction operation
        PUSH AX
        LEA DX, multipli    ; print the result message
        MOV AH, 9H
        INT 21H
        POP AX
        MOV CX, 0   ;Reset the counter register
        MOV DX, 0   ;Reset the data register
        MOV BX, 10
        JMP conv
                   
                   
division:

        POP AX  ;Get the 2 input numbers from the stack
        MOV DX, 0   ;Perform the subtraction operation
        DIV BX
        PUSH AX
        LEA DX, divi    ;print the result message
        MOV AH, 9H
        INT 21H
        POP AX
        MOV CX, 0   ;Reset the counter register
        MOV DX, 0   ;Reset the data register
        MOV BX, 10
        JMP conv
      
conv:
        MOV DX, 0
        DIV BX
        PUSH DX
        MOV DX, 0
        INC CX
        OR AX, AX ; reset AX to 0
        JNE conv
      
            
      
show_res:

        POP DX
        ADD DL, 30H ; Convert the result to ASCII
        MOV AH, 2H ; Print to the screen 
        INT 21H
        LOOP show_res ; Loop through show_res until there's no numbers left to print
      
     
     
        JMP beginning1 ; Restart the program
        end beginning1