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
        PRINT_DEC 8, [inputNum]
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
            
        
        ; Sum of the m-th power digits
        
        
        ; Check if Armstrong Number
        
        
        
        PRINT_STRING "Do you want to continue (Y/N)? "
        GET_CHAR [continuePrompt]
        PRINT_CHAR [continuePrompt]
        NEWLINE
        
        CMP byte [continuePrompt], 'Y'
        JE PROGRAM_LOOP
        
        JMP FINIS
    
    FINIS:
        ret ; End program
        
    INPUT_VALIDATION:
        PRINT_STRING "Input validated!"
        NEWLINE
        ret
        
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
        MOV RAX, [inputNum] ; dividend
        MOV RBX, [digitCount]
        START_ROTATE_INPUT:
            CMP RBX, 0 ; Check if digitCount is 0
            JE END_ROTATE_INPUT
            
            MOV RCX, 10 ; divisor
            MOV RDX, 0 ; remainder
            DIV RCX
            
            ; Get power of 10
            MOV R8, 1
            MOV R9, RBX ; from digitCount
            DEC R9
            GET_POWER_10:
                CMP R9, 0
                JE END_GET_POWER_10
                
                IMUL R8, 10
                DEC R9
                
                JMP GET_POWER_10
                    
            END_GET_POWER_10:
                IMUL R8, RDX
                ADD [rotatedNum], R8
            
            DEC RBX
            
            JMP START_ROTATE_INPUT
            
        END_ROTATE_INPUT:
            ret
            
    MTH_POWER_DIGIT:
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