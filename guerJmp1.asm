; Guerra, Jose Maria Angelo C.
; Sayo, Trisha Alissandra
; S15

%include 'io64.inc'
section .data
inputNum dq 0
continuePrompt db 0
digitCount db 0

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
        
        ; m-th power of each digits
        
        ; 1. Count the number of digits
        CALL COUNT_DIGIT
        
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
            MOV RDX, 0
            DIV RCX
            INC byte [digitCount]
            
            JMP START_COUNT_DIGIT
        
        END_COUNT_DIGIT:
            ret
       
    xor rax, rax
    ret