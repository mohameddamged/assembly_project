.MODEL SMALL
.DATA
    MSG1 DB "************************************WELCOME************************************","$"
    LINE DB 0AH,"$"
    MSG2 DB "ENTER YOUR PASSWORD","$"
    MSG3 DB "INVALID PASSWORD...........,TRY AGAIN","$"
    PASS DB "12345","$"
    L_PASS DW 5
    BALANCE DW 1000D
    
    ;OPTIONS
    MSG4 DB "1-WITHDRAW           2-DEPOSITE           3-CHCEK BALANCE","$"
    ;WITHDRAW
    MSG5 DB "1-1000 EGP           2-2000 EGP           3-3000 EGP           4-4000 EGP","$"
    WITH1 DW 1000D
    WITH2 DW 2000D
    WITH3 DW 3000D
    WITH4 DW 4000D
    SUCCESS DB "TRANSACTION SUCCESSFULLY, ","$"
    BAL_LOW DB "YOUR BALANCE IS LESS THAN THIS VALUE","$"
    ;DEPOSITE
    MSG6 DB "1-1000 EGP           2-2000 EGP           3-3000 EGP           4-4000 EGP","$"
    ;CHECK BALANE 
    MSG7 DB "YOUR AVAILABLE BALANCE IS ","$"
    CUR DB " EGP. ","$"
    MSG8 DB "DO YOU WANT ANTHOER OPERATION?  Y/N","$"
    MSG9 DB "INVALID INPUT","$"
    THANKS DB "********************THANKS FOR BANKING WITH US********************","$"
.386
.CODE
    MAIN PROC FAR
    .STARTUP    
        ;PRINT WELCOME
        LEA DX,MSG1
        CALL PRINTSTR
    TRY_AGAIN:
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;PRINT ENTER PASSWORD
        LEA DX,MSG2
        CALL PRINTSTR
        
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        
        ;MOV LENGTH OF PASSWORD TO CX AND CHECK PASSWORD
        MOV CX,L_PASS
        LEA BX,PASS
        
    CHECK:
        CALL READCHAR
        
        CMP AL,[BX]
        JNE INVALID
        INC BX
        LOOP CHECK
        MOV AH,00H
        INT 16H
        JMP MENU
        
        
    INVALID:
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;PRINT INVALID PASSWORD TRY AGAIN
        LEA DX,MSG3
        CALL PRINTSTR
        JMP TRY_AGAIN
        
    MENU:
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;PRINT OPTIONS
        LEA DX,MSG4
        CALL PRINTSTR
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;READ OPTION
        CALL READCHAR
        CMP AL,31H
        JE WITHDRAW
        CMP AL,32H
        JE DEPOSITE
        CMP AL,33H
        JE CHCEK_BALANCE
        JNE ERROR
    WITHDRAW:
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;PRINT FISRT OPTION
        LEA DX,MSG5
        CALL PRINTSTR
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;READ CHAR
        CALL READCHAR
        ;PRINT NEW LINE
        ;MOV DL,LINE
        ;CALL PRINTCHAR
        CMP AL,31H
        JE OP1
        CMP AL,32H
        JE OP2
        CMP AL,33H
        JE OP3
        CMP AL,34H
        JE OP4

    OP1:
        MOV BX, WITH1
        CMP BX, BALANCE
        JG BAL_LOW_ERROR
        MOV BX, BALANCE
        SUB BX, WITH1
        MOV BALANCE, BX
        CALL SUCCESS_MSG

        ;PRINT DO YOU WANT ANTHOR OPERATION 
        LEA DX,MSG8
        CALL PRINTSTR
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;READ CHAR
        CALL READCHAR
        CMP AL,'Y'
        JE MENU
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;PRINT THANKS
        LEA DX,THANKS
        CALL PRINTSTR
        .EXIT
        
    OP2:
        MOV BX, WITH2
        CMP BX, BALANCE
        JG BAL_LOW_ERROR
        MOV BX, BALANCE
        SUB BX, WITH2
        MOV BALANCE, BX
        CALL SUCCESS_MSG
        ;PRINT DO YOU WANT ANTHOR OPERATION 
        LEA DX,MSG8
        CALL PRINTSTR
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;READ CHAR
        CALL READCHAR
        CMP AL,'Y'
        JE MENU
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;PRINT THANKS
        LEA DX,THANKS
        CALL PRINTSTR
        .EXIT
        
        
    OP3:
        MOV BX, WITH3
        CMP BX, BALANCE
        JG BAL_LOW_ERROR
        MOV BX, BALANCE
        SUB BX, WITH3
        MOV BALANCE, BX
        CALL SUCCESS_MSG
        ;PRINT DO YOU WANT ANTHOR OPERATION 
        LEA DX,MSG8
        CALL PRINTSTR
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;READ CHAR
        CALL READCHAR
        CMP AL,'Y'
        JE MENU
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;PRINT THANKS
        LEA DX,THANKS
        CALL PRINTSTR
        .EXIT
        
        
    OP4:
        MOV BX, WITH4
        CMP BX, BALANCE
        JG BAL_LOW_ERROR
        MOV BX, BALANCE
        SUB BX, WITH4
        MOV BALANCE, BX
        CALL SUCCESS_MSG
        ;PRINT DO YOU WANT ANTHOR OPERATION 
        LEA DX,MSG8
        CALL PRINTSTR
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;READ CHAR
        CALL READCHAR
        CMP AL,'Y'
        JE MENU
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;PRINT THANKS
        LEA DX,THANKS
        CALL PRINTSTR
        .EXIT

    BAL_LOW_ERROR:
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        LEA DX, BAL_LOW
        CALL PRINTSTR
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;PRINT DO YOU WANT ANTHOR OPERATION 
        LEA DX,MSG8
        CALL PRINTSTR
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;READ CHAR
        CALL READCHAR
        CMP AL,'Y'
        JE MENU
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;PRINT THANKS
        LEA DX,THANKS
        CALL PRINTSTR
        .EXIT
        
    DEPOSITE:
            ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;PRINT FISRT OPTION
        LEA DX,MSG6
        CALL PRINTSTR
        MOV DL,LINE
        CALL PRINTCHAR
        ;READ CHAR
        CALL READCHAR
        ;PRINT NEW LINE
        ;MOV DL,LINE
        ;CALL PRINTCHAR
        CMP AL,31H
        JE OP5
        CMP AL,32H
        JE OP6
        CMP AL,33H
        JE OP7
        CMP AL,34H
        JE OP8
        
    OP5:
        CMP BX, BALANCE
        MOV BX, BALANCE
        ADD BX, WITH1
        MOV BALANCE, BX
        CALL SUCCESS_MSG

        
        ;PRINT DO YOU WANT ANTHOR OPERATION 
        LEA DX,MSG8
        CALL PRINTSTR
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;READ CHAR
        CALL READCHAR
        CMP AL,'Y'
        JE MENU
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;PRINT THANKS
        LEA DX,THANKS
        CALL PRINTSTR
        .EXIT
        
    OP6:
        CMP BX, BALANCE
        MOV BX, BALANCE
        ADD BX, WITH2
        MOV BALANCE, BX
        CALL SUCCESS_MSG
        ;PRINT DO YOU WANT ANTHOR OPERATION 
        LEA DX,MSG8
        CALL PRINTSTR
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;READ CHAR
        CALL READCHAR
        CMP AL,'Y'
        JE MENU
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;PRINT THANKS
        LEA DX,THANKS
        CALL PRINTSTR
        .EXIT
        
        
    OP7:
        MOV BX, BALANCE
        ADD BX, WITH3
        MOV BALANCE, BX
        CALL SUCCESS_MSG
        ;PRINT DO YOU WANT ANTHOR OPERATION 
        LEA DX,MSG8
        CALL PRINTSTR
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;READ CHAR
        CALL READCHAR
        CMP AL,'Y'
        JE MENU
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;PRINT THANKS
        LEA DX,THANKS
        CALL PRINTSTR
        .EXIT
        
        
    OP8:
        MOV BX, BALANCE
        ADD BX, WITH4
        MOV BALANCE, BX
        CALL SUCCESS_MSG
        ;PRINT DO YOU WANT ANTHOR OPERATION 
        LEA DX,MSG8
        CALL PRINTSTR
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;READ CHAR
        CALL READCHAR
        CMP AL,'Y'
        JE MENU
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;PRINT THANKS
        LEA DX,THANKS
        CALL PRINTSTR
        .EXIT


        
    CHCEK_BALANCE:
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;PRINT FISRT OPTION
        LEA DX,MSG7
        CALL PRINTSTR
        XOR AX, AX
        MOV AX, BALANCE
        CALL DISPLAY_NUM
        LEA DX,CUR
        CALL PRINTSTR
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;PRINT DO YOU WANT ANTHOR OPERATION 
        LEA DX,MSG8
        CALL PRINTSTR
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;READ CHAR
        CALL READCHAR
        CMP AL,59H
        JE MENU
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        ;PRINT THANKS
        LEA DX,THANKS
        CALL PRINTSTR
        .EXIT
        
        
    ERROR:
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        LEA DX,MSG9
        CALL PRINTSTR
        JMP MENU
    .EXIT
    MAIN ENDP
    
   PRINTSTR PROC NEAR
   MOV AH,09H
   INT 21H
   RET
   PRINTSTR ENDP
   
   PRINTCHAR PROC NEAR
   MOV AH,02H
   INT 21H
   RET
   PRINTCHAR ENDP
   
   READCHAR PROC NEAR
   MOV AH,01H
   INT 21H
   RET
   READCHAR ENDP
   
   
   ;Procedure to display a successful transaction message
   SUCCESS_MSG PROC NEAR
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        LEA DX, SUCCESS
        CALL PRINTSTR
        
        LEA DX, MSG7
        CALL PRINTSTR
        
        XOR AX, AX
        MOV AX,BALANCE
        CALL DISPLAY_NUM
        
        LEA DX, CUR
        CALL PRINTSTR
        ;PRINT NEW LINE
        MOV DL,LINE
        CALL PRINTCHAR
        
        RET
   SUCCESS_MSG ENDP
     
     
    ;Procedure to display a 16bit decimal number
    DISPLAY_NUM PROC NEAR
        XOR CX, CX ;To count the digits
        MOV BX, 10 ;Fixed divider
        
        DIGITS:
        XOR DX, DX ;Zero DX for word division
        DIV BX
        PUSH DX ;Remainder (0,9)
        INC CX
        TEST AX, AX
        JNZ DIGITS ;Continue until AX is empty
        
        NEXT:
        POP DX
        ADD DL, 30H
        MOV AH, 02H
        INT 21H
        LOOP NEXT
        
        RET
    DISPLAY_NUM ENDP
          
END MAIN
