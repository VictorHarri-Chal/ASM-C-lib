BITS 64                             ; 64 bits mode
SECTION .text                       ; Code section 
GLOBAL memmove                      ; export memmove

memmove:
    PUSH    RCX                     ; push the counter in the stack
    XOR     RCX, RCX                ; clear the counter RCX
    XOR     RAX, RAX                ; set RAX to null (return value)

_memmove_push:
    CMP     RCX, RDX                ; compare the counter with the 3rd arg (byte)
    JE      _memmove_pop            ; if the counter = the nbr of byte, go to _memmove_pop
    MOV     R10B, BYTE [RSI + RCX]  ; move the char of RSI into a tmp ledger
    PUSH    R10                     ; push the tmp ledger on the stack
    INC     RCX                     ; increment counter
    JMP     _memmove_push           ; loop

_memmove_pop:
    CMP     RCX, 0                  ; compare the counter with 0
    JZ      _memmove_null           ; if RCX = 0, go to _memmove_null
    DEC     RCX                     ; decremente counter
    POP     R10                     ; pop the tmp ledger from the stack
    MOV     BYTE [RDI + RCX], R10B  ; move the char from the tmp ledger into RDI
    JMP     _memmove_pop            ; loop

_memmove_null:
    MOV     RAX, RDI                ; RDI keep the new string, we move it in RAX (ret value)
    POP     RCX                     ; restoring the old counter value
    RET                             ; leaving

; void *memmove(void *dest, const void *src, size_t n)
; RDI = void* dest
; RSI = const void *src
; RDX = size_t n