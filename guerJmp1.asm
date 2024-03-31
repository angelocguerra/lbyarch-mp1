; Guerra, Jose Maria Angelo C.
; Sayo, Trisha Alissandra
; S15

%include 'io64.inc'
section .data
inputNum dq 0
continuePrompt db 0
digit db 0
dump db 0
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
        MOV dword [inputNum], 0 ; Reset
        GET_DEC 8, [inputNum]
        
        ; Input Validation
        ;CALL INPUT_VALIDATION
        CHECK_DIGIT:
            GET_CHAR [digit]
            CMP byte [digit], 10 ; If digit is \n
            JNE CHECK_DIGIT ; Continue iterating over next
        
        MOV RAX, [inputNum]
        TEST RAX, RAX ; Test using flags
        JZ INVALID_INPUT ; Validation 1: Non-numerical
        JS NEGATIVE_INPUT ; Validation 2: Non-negative
        
        ; If input is valid, return and continue program loop
        ;ret
        
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
            GET_CHAR [continuePrompt]
            NEWLINE
        
            CMP byte [continuePrompt], 'Y'
            JE PROGRAM_LOOP
           
            CMP byte [continuePrompt], 'N'
            JE END_PROGRAM_LOOP
            
            PRINT_STRING "Invalid Input. Try again"
            NEWLINE
            JMP CONTINUE_PROMPT     
            
    INVALID_INPUT:
        PRINT_STRING "Error: Invalid Input"
        JMP CONTINUE_PROMPT
            
    NEGATIVE_INPUT:
        PRINT_STRING "Error: Negative Number Input"
        JMP CONTINUE_PROMPT   
                
    COUNT_DIGIT:
        MOV byte [digitCount], 0 ; reset counter
        MOV RAX, 0 ; reset reg
        MOV RBX, 0 ; reset reg
        
        MOV RAX, [inputNum] ; dividend
        
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
        MOV RAX, 0 ; reset reg
        MOV RBX, 0 ; reset reg
        
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
        MOV RAX, 0 ; reset reg
        MOV RBX, 0 ; reset reg
        
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
            
    END_PROGRAM_LOOP:
        NOP ; End program
       
    xor rax, rax
    ret