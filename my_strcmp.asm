BITS 64                             ; 64 bits mode
SECTION .text                       ; Code section 
GLOBAL strcmp                      ; export strcmp

strcmp:
    PUSH    RCX                     ; push the counter in the stack
    XOR     RCX, RCX                ; clear the counter RCX
    XOR     RAX, RAX                ; set RAX to null (return value)

_strcmp_loop:
    CMP     BYTE [RDI + RCX], 0     ; compare the 1rst string with 0
    JZ      _strcmp_null            ; if string 1 is null, go to _strcmp_null
    CMP     BYTE [RSI + RCX], 0     ; compare the 2nd string with 0
    JZ      _strcmp_null            ; if string 2 is null, go to _strcmp_null
    MOV     R10B, BYTE [RSI + RCX]  ; move the char of the 2nd string into a tmp ledger
    CMP     BYTE [RDI, RCX], R10B   ; compare the 1rst string with the tmp ledger
    JNE     _strcmp_null            ; if not equal = go to _strcmp_null
    INC     RCX                     ; increment the counter
    JMP     _strcmp_loop            ; loop

_strcmp_null:
    MOVZX   RAX, BYTE [RDI + RCX]   ; RDI keep the new string, we move it in RAX (ret value)
    MOVZX   R10, BYTE [RSI + RCX]   ; MOVE RSI into the tmp ledger
    SUB     RAX, R10                ; substract the tmp ledger of RAX
    POP     RCX                     ; restoring the old counter value
    RET                             ; leaving

; int strcmp(const char *s1, const char *s2)
; RDI = const char *s1
; RSI = const char *s2