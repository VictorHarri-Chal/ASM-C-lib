BITS 64                             ; 64 bits mode
SECTION .text                       ; Code section 
GLOBAL memcpy                       ; export memcpy

memcpy:
    PUSH    RCX                     ; push the counter in the stack
    XOR     RCX, RCX                ; clear the counter RCX
    XOR     RAX, RAX                ; set RAX to null (return value)

_memcpy_loop:
    CMP     RDX, RCX                ; compare the 3rd arg n, with the counter          
    JE      _memcpy_null            ; if comparaison is ok -> go to _memcpy_null
    MOV     R10B, BYTE [RSI + RCX]  ; move the char of the 2rd arg into a 1 byte free ledger (R10B)
    MOV     BYTE [RDI + RCX], R10B  ; move the char from R10B into the 1rst arg RDI
    INC     RCX                     ; increment the counter
    JMP     _memcpy_loop            ; _loop

_memcpy_null:
    MOV     RAX, RDI                ; RDI keep the new string, we move it in RAX (ret value)
    POP     RCX                     ; restoring the old counter value
    RET                             ; leaving

; void *memcpy(void *dest, const void *src, size_t n)
; RDI = void* dest
; RSI = const void *src
; RDX = size_t n