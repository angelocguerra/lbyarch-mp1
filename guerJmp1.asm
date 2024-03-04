; Guerra, Jose Maria Angelo C.
; Sayo, Trisha Alissandra
; S15

%include 'io64.inc'
section .data
inputNum dq 0
continuePrompt db 0


section .text
global main
main:
    mov rbp, rsp; for correct debugging
    ; mov ebp, esp; for correct debugging
    
    PROGRAM_LOOP:
        PRINT_STRING "Do you want to continue (Y/N)? "
        GET_CHAR [continuePrompt]
        PRINT_CHAR [continuePrompt]
        NEWLINE
        
        CMP byte [continuePrompt], 'Y'
        JE PROGRAM_LOOP
        
        JMP FINIS
    
    FINIS:
        NOP
    
    
    
    
    xor rax, rax
    ret