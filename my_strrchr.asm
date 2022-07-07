BITS 64                             ; 64 bits mode
SECTION .text                       ; Code section 
GLOBAL strrchr                      ; export strrchr

strrchr:
    PUSH    RCX                     ; push the counter in the stack
    XOR     RCX, RCX                ; clear the counter RCX
    XOR     RAX, RAX                ; set RAX to null (return value)

_strrchr_loop:
    CMP     BYTE [RDI + RCX], SIL   ; compare RDI char 1 by 1 with the 2nd parameter SIL(1 byte)
    JE      _strrchr_found          ; if cmp is ok -> jump to _strrchr_found
    CMP     BYTE [RDI + RCX], 0     ; compare RDI char 1 by 1
    JZ      _strrchr_null           ; if cmp is ok (equal null) -> jump to strrchr_null
    INC     RCX                     ; increment the counter
    JMP    _strrchr_loop            ; loop

_strrchr_found:
    XOR     RAX, RAX                ; clear RAX
    MOV     RAX, RDI                ; put the string into RAX (return value)
    ADD     RAX, RCX                ; put the counter into RAX
    INC     RCX                     ; increment the counter, if no = inf loop
    JMP    _strrchr_loop            ; loop

_strrchr_null:
    POP     RCX                     ; resrore the counter
    RET                             ; leave

; char *strrchr(const char *s, int c)
; RDI = const char *s
; RSI = int c