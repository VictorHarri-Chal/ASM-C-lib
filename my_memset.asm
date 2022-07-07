BITS 64                             ; 64 bits mode
SECTION .text                       ; Code section 
GLOBAL memset                       ; export memset

memset:
    PUSH    RCX                     ; push the counter in the stack
    XOR     RCX, RCX                ; clear the counter RCX
    XOR     RAX, RAX                ; set RAX to null (return value)

_memset_loop:
    CMP     RDX, RCX                ; compare the 3rd arg n, with the counter          
    JE      _memset_null            ; if comparaison is ok -> go to _memset_null
    MOV     BYTE [RDI + RCX], SIL   ; move the char of the 3rd arg into the 1rst arg
    INC     RCX                     ; increment the counter
    JMP     _memset_loop            ; _loop

_memset_null:
    MOV     RAX, RDI                ; RDI keep the new string, we move it in RAX (ret value)
    POP     RCX                     ; restoring the old counter value
    RET                             ; leaving

; void *memset(void *s, int c, size_t n
; RDI = void* s
; RSI = int c
; RDX = size_t n