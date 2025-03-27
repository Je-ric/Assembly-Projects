.model small
.stack

.data
            ;NEW LINE
    CR EQU 10          ;COURAGE RETURN
    LF EQU 13          ;LINE FEED

    welcome db "-----------------------------------CALCULATOR----------------------------------- $"

    input1 db CR, LF, CR, LF, "Enter the first Number: $"
    input2 db CR, LF, "Enter the second Number: $"
    chooseMessage db CR, LF, "Press a to ADD, s to SUBTRACT, m to MULTIPLY, d to DIVIDE, e to EXIT: $"
    messageSum db CR, LF, CR, LF, "Sum is: $"
    messageDif db CR, LF, CR, LF, "Difference is: $"
    messageMul db CR, LF, CR, LF, "Product is: $"
    messageDiv db CR, LF, CR, LF, "Quotient is: $"


    exitMessage db CR, LF,"----------------------Thank you for using the calculator!---------------------- $"

    answer db ? ;hold temporary value


.code
.startup

        mov ax, @data
        mov ds, ax

        mov dx, OFFSET welcome
        mov ah, 09h
        int 21h

        first:
        mov dx, OFFSET input1           ;print "input1"
        mov ah, 09h
        int 21h

        mov bx, 0

        start1:
        mov ah, 01h                      ;get input from the user for "input1"
        int 21h

        cmp al, 0dh                     ;condition that jump to "second"
        je second

                                        ;remove garbage
        mov ah, 0
        sub al, 30h
        push ax
        mov ax, 10d
        mul bx
        pop bx
        add bx, ax
        jmp start1                      ;jump to "start1:" to accept more than one number from the input

        second:                         ;print "input2"
        push bx
        mov dx, OFFSET input2
        mov ah, 09h
        int 21h

        mov bx, 0

        start2:                         ;get input from the user for "input2"
        mov ah, 01h                     
        int 21h

        cmp al, 0dh                     ;condition that jump to "choose"
        je choose

                                        ;remove garbage
        mov ah, 0
        sub al, 30h
        push ax
        mov ax, 10d
        mul bx
        pop bx
        add bx, ax                                     
        jmp start2                      ;jump to "start2:" to accept more than one number from the input

        choose:
        mov dx, OFFSET chooseMessage
        mov ah, 09h
        int 21h

        mov ah, 01h                     ;get input from the user to choose what operation he/she want
        mov answer, al
        int 21h

                                        ;condition that jump to the chosen operation
        cmp al, 'a'
        je addition                     ;this jump to "adddition"

        cmp al, 's'
        je subtraction                  ;this jump to "subtraction"
        
        cmp al, 'm'
        je multiplication               ;this jump to "multiplication"

        cmp al, 'd'
        je division                     ;this jump to "division"

        cmp al, 'e'
        je exit                         ;this jump to "exit" to terminate the program


  ;OPERATION
        addition:                       ;addition
        pop ax
        add ax, bx
        push ax
        mov dx, offset messageSum
        mov ah, 09h
        int 21h

        pop ax
        mov cx, 0
        mov dx, 0
        mov bx, 10d
        jmp break                        ;this jump to "break" to stop the operation

        subtraction:                     ;subtraction
        pop ax
        sub ax, bx
        push ax
        mov dx, offset messageDif
        mov ah, 09h
        int 21h

        pop ax
        mov cx, 0
        mov dx, 0
        mov bx, 10d
        jmp break                       ;this jump to "break" to stop the operation

        multiplication:                 ;multiplication
        pop ax
        mul bx
        push ax
        mov dx, offset messageMul
        mov ah, 09h
        int 21h

        pop ax
        mov cx, 0
        mov dx, 0
        mov bx, 10d
        jmp break                    ;this jump to "break" to stop the operation


        division:                    ;division
        pop ax
        mov dx, 0                    ;removes the remainder
        div bx
        push ax
        mov dx, offset messageDiv
        mov ah, 09h
        int 21h

        pop ax
        mov cx, 0
        mov dx, 0
        mov bx, 10d
        jmp break                       ;this jump to "break" to stop the operation
       

        exit:                           ;terminates the program if the user press "e"
        mov ah, 09h
        mov dx, OFFSET exitMessage
        int 21h

        mov ah, 4ch
        int 21h


        ;to stop the OPERATION
                break:
                div bx
                push dx
                mov dx, 0
                inc cx
                or ax, ax
                jne break

        ;pop the result
                ans:
                pop dx
                add dl, 30h
                mov ah, 02h
                int 21h
                loop ans
                jmp first

                mov ah, 4ch                     ;terminates the program
                int 21h

   end
        .exit

























