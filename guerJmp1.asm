; Guerra, Jose Maria Angelo C.
; Sayo, Trisha Alissandra
; S15

%include 'io64.inc'
section .data
inputNum dq 0
continuePrompt db 0
digitCount db 0
rotatedNum dq 0
sumMthPowerDigit dq 0

section .text
global main
main:
    mov rbp, rsp; for correct debugging
    
    PROGRAM_LOOP:
        ; Input
        PRINT_STRING "Input Number: "
        GET_DEC 8, [inputNum]
        ; PRINT_DEC 8, [inputNum] ; Display in SASM
        NEWLINE
        
        ; Input Validation
        CALL INPUT_VALIDATION
        
        ; A.) m-th power of each digits
        
            ; 1. Count the number of digits
            CALL COUNT_DIGIT
        
            ; 2. Rotate input to perform order m-th power
            CALL ROTATE_INPUT
            
            ; 3. Get m-th power of each digit
            PRINT_STRING "m-th power of each digits: "
            CALL MTH_POWER_DIGIT
            NEWLINE
            
        ; B.) Sum of the m-th power digits
        
        PRINT_STRING "Sum of the m-th power digits: "
        PRINT_DEC 8, [sumMthPowerDigit]
        NEWLINE
        
        ; C.) Check if Armstrong Number
        
        PRINT_STRING "Armstrong Number: "
        MOV RAX, [inputNum]
        MOV RBX, [sumMthPowerDigit]
        CMP RAX, RBX ; If sum == input
        JE DISPLAY_YES ; Display Yes
        JMP DISPLAY_NO ; Else, display No
        
        DISPLAY_YES:
            PRINT_STRING "Yes"
            NEWLINE
            JMP CONTINUE_PROMPT
            
        DISPLAY_NO:
            PRINT_STRING "No"
            NEWLINE
            JMP CONTINUE_PROMPT
        
        CONTINUE_PROMPT:
            NEWLINE
            PRINT_STRING "Do you want to continue (Y/N)? "
            GET_CHAR [continuePrompt] ; Catch '\n' character
            GET_CHAR [continuePrompt]
            ; PRINT_CHAR [continuePrompt] ; Display in SASM
            NEWLINE
        
            CMP byte [continuePrompt], 'Y'
            JE PROGRAM_LOOP
           
            CMP byte [continuePrompt], 'N'
            JE END_PROGRAM_LOOP
            
            PRINT_STRING "Invalid Input. Try again"
            NEWLINE
            JMP CONTINUE_PROMPT
    
    END_PROGRAM_LOOP:
        ret ; End program
        
    INPUT_VALIDATION:
        ; If input is valid, return and continue program loop
        ret
        
        ; Else, proceed to continue prompt
        ; JMP CONTINUE_PROMPT
        
        ; Validation 1: Non-alpabet
        
        ; Validation 2: Non-negative
        
        
    COUNT_DIGIT:
        MOV RAX, [inputNum] ; dividend
        MOV byte [digitCount], 0 ; reset counter
        START_COUNT_DIGIT:
            CMP RAX, 0 ; Check if temp input is 0
            JE END_COUNT_DIGIT
            
            MOV RCX, 10 ; divisor
            MOV RDX, 0 ; remainder
            DIV RCX
            INC byte [digitCount]
            
            JMP START_COUNT_DIGIT
        
        END_COUNT_DIGIT:
            ret
            
    ROTATE_INPUT:
        MOV qword [rotatedNum], 0 ; reset variable
        MOV RAX, [inputNum] ; dividend
        MOV BL, [digitCount]
        START_ROTATE_INPUT:
            CMP BL, 0 ; Check if digitCount is 0
            JE END_ROTATE_INPUT
            
            MOV RCX, 10 ; divisor
            MOV RDX, 0 ; remainder
            DIV RCX
            
            ; Get power of 10
            MOV R8, 1
            MOV R9B, BL ; from digitCount
            DEC R9B
            GET_POWER_10:
                CMP R9B, 0
                JE END_GET_POWER_10
                
                IMUL R8, 10
                DEC R9B
                
                JMP GET_POWER_10
                    
            END_GET_POWER_10:
                IMUL R8, RDX
                ADD [rotatedNum], R8
            
            DEC RBX
            
            JMP START_ROTATE_INPUT
            
        END_ROTATE_INPUT:
            ret
            
    MTH_POWER_DIGIT:
        MOV qword [sumMthPowerDigit], 0 ; reset variable
        MOV RAX, [rotatedNum] ; dividend
        MOV BL, [digitCount] ; iterator for each digit
        
        START_MTH_POWER:
            CMP RBX, 0
            JE END_MTH_POWER
            
            MOV RCX, 10 ; divisor
            MOV RDX, 0 ; remainder
            DIV RCX
            
            ; Raise digit to mth power
            MOV R8B, [digitCount] ; m-th power
            DEC R8B
            MOV R9, RDX ; Set original digit here
            EXPONENTIATE:
                CMP R8B, 0
                JE END_EXPONENTIATE
                
                IMUL RDX, R9
                DEC R8B
                
                JMP EXPONENTIATE
            
                END_EXPONENTIATE:
                    PRINT_DEC 8, RDX
                    ADD [sumMthPowerDigit], RDX
                    DEC RBX
                    CMP RBX, 0
                    JNE COMMA_FORMAT
                    
                    JMP START_MTH_POWER
                    
                    COMMA_FORMAT:
                        PRINT_STRING ", "
                        JMP START_MTH_POWER
            
            JMP START_MTH_POWER
        
            END_MTH_POWER:
                NOP
    
        END_MTH_POWER_DIGIT:
            ret
       
    xor rax, rax
    ret